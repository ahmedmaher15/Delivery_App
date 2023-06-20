import 'package:food_deliverya_pp/data/repository/auth_repo.dart';
import 'package:food_deliverya_pp/models/response_model.dart';
import 'package:food_deliverya_pp/models/signup_body_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRebo authRebo;

  AuthController({required this.authRebo});

  bool _isLoding = false;

  bool get isLoding => _isLoding;

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoding = true;
    update();
    Response response = await authRebo.registration(signUpBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRebo.saveUSerToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoding = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String phone, String password) async {
    _isLoding = true;
    update();
    Response response = await authRebo.login(phone, password);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRebo.saveUSerToken(response.body["token"]);
     // print("My Token is ${response.body["token"]}");
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoding = false;
    update();
    return responseModel;
  }

  void saveUserNumberAndPassword(String number, String password) async {
    authRebo.saveUserNumberAndPassword(number, password);
  }

  //to see if user had Login or no
  bool usrLogedIn()  {
    return  authRebo.usrLogedIn();
  }

  //to clear all the data when u sign out
  bool clearShardData(){
    return authRebo.cleashardData();
  }
}
