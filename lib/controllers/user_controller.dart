import 'package:food_deliverya_pp/data/repository/user_repo.dart';
import 'package:food_deliverya_pp/models/response_model.dart';
import 'package:food_deliverya_pp/models/signup_body_model.dart';
import 'package:food_deliverya_pp/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({required this.userRepo});
  bool _isLoding = false;

   late UserModel _userModel;
  bool get isLoding => _isLoding;
  UserModel get userModel => _userModel;

  Future<ResponseModel> getUserinfo() async {
    Response response = await userRepo.getUserInfo();
   // print("the body of User ${response.body}");
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _userModel=UserModel.fromJson(response.body);
      _isLoding=true;
      responseModel = ResponseModel(true, "Successfully");
      //print("hello man every thing is okay");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    //  print("_userModel false");
    }

    update();
    return responseModel;
  }

}