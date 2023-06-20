import 'package:flutter/material.dart';
import 'package:food_deliverya_pp/controllers/auth_controller.dart';
import 'package:food_deliverya_pp/controllers/location_controller.dart';
import 'package:food_deliverya_pp/controllers/user_controller.dart';
import 'package:food_deliverya_pp/models/address_model.dart';
import 'package:food_deliverya_pp/routes/routes_helper.dart';
import 'package:food_deliverya_pp/screens/address/pick_address_map.dart';
import 'package:food_deliverya_pp/ui/app_text_field.dart';
import 'package:food_deliverya_pp/ui/big_text.dart';
import 'package:food_deliverya_pp/utils/colors.dart';
import 'package:food_deliverya_pp/utils/dimensions.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../ui/app_icon.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  var lController=Get.find<LocationController>() ;
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition =
  CameraPosition(target: LatLng(30.033333,  31.233334), zoom: 17);
  late LatLng _initiolPostion=LatLng(30.033333,  31.233334);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLogged = Get.find<AuthController>().usrLogedIn();
    //&& Get.find<UserController>().userModel == null
    if (_isLogged ) {
      Get.find<UserController>().getUserinfo();
    }
    if (lController.addressList.isNotEmpty) {
      if(lController.getUserAddressFromLocalStorage()==""){
        lController.saveUserAddress(lController.addressList.last);
      }
      lController.getUserAddress();
      _cameraPosition = CameraPosition(
          target: LatLng(
              double.parse(
                 lController.getAddress["latitude"]),
              double.parse(
                  lController.getAddress["longitude"])));
      _initiolPostion = LatLng(
          double.parse(lController.getAddress["latitude"]),
          double.parse(lController.getAddress["longitude"]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address page"),
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {
          if(_contactPersonName.text.isEmpty){
            _contactPersonName.text='${userController.userModel.name}';
            _contactPersonNumber.text='${userController.userModel.phone}';
            if(lController.addressList.isNotEmpty){
           _addressController.text=  lController.getUserAddress().address;
            }

          }
          return GetBuilder<LocationController>(
            builder: (locationController) {
              _addressController.text='${locationController.placemark.name ??""}'
                  '${locationController.placemark.locality ??""}'
                  '${locationController.placemark.postalCode ??""}'
                  '${locationController.placemark.country ??""}';
              print("address for my view is"+_addressController.text);
              return  SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: Dimensions.width10/2,right: Dimensions.width10/2,top: Dimensions.height10/2 ,bottom: Dimensions.height10/2),
                      height: Dimensions.height20*11,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.height10/2),
                        border: Border.all(
                          width:Dimensions.width10/5,
                          color: AppColors.mainColor
                        )
                      ),
                      child: Stack(
                        children: [
                          GoogleMap(initialCameraPosition:
                          CameraPosition(target: _initiolPostion,zoom: 17),
                            zoomControlsEnabled: false,
                            compassEnabled: false,
                            indoorViewEnabled: true,
                            myLocationEnabled: true,
                            mapToolbarEnabled: false,
                            onTap: (latLang){
                              Get.toNamed(RouteHelper.getPickAddressPage(),arguments: PickAddressMap());
                            },
                            onCameraIdle: (){
                              locationController.updatePosition(_cameraPosition,true);
                            },
                            onCameraMove: ((position)=>_cameraPosition=position),
                            onMapCreated: (GoogleMapController controller){
                              locationController.setMapController(controller);
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(

                      padding:  EdgeInsets.only(left:Dimensions.width20 ,top: Dimensions.height20),
                      child: SizedBox(height: 50,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: locationController.addressTypList.length,
                          itemBuilder: (context,index) {
                            return InkWell(
                        onTap: (){
                          locationController.setAddressTypeIndex(index);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.width20,vertical: Dimensions.height10),
                          margin: EdgeInsets.only(right: Dimensions.width10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.height20/4),
                            color: Theme.of(context).cardColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[200]!,
                                spreadRadius: 1,
                                blurRadius: 5
                              ),
                            ]
                          ),
                          child: Icon(
                                index==0?Icons.home_filled:index==1?Icons.work:Icons.location_on,
                                color: locationController.addressTypIndex==index?
                                AppColors.mainColor:Theme.of(context).disabledColor,
                          ),
                        ),
                      );
                          }),),
                    ),
                    SizedBox(height: Dimensions.height20,),
                    Padding(
                      padding:  EdgeInsets.only(left: Dimensions.width20),
                      child: BigText(text: "Delivery address:"),
                    ),
                    SizedBox(height: Dimensions.height10,),
                    AppTextField(textController: _addressController, hentText: "Your Address", icon: Icons.map),
                    SizedBox(height: Dimensions.height20,),
                    Padding(
                      padding:  EdgeInsets.only(left: Dimensions.width20),
                      child: BigText(text: "Contact name:"),
                    ),
                    SizedBox(height: Dimensions.height10,),
                    AppTextField(textController: _contactPersonName, hentText: "Your Name", icon: Icons.person),
                    SizedBox(height: Dimensions.height20,),
                    Padding(
                      padding:  EdgeInsets.only(left: Dimensions.width20),
                      child: BigText(text: "Your number:"),
                    ),
                    SizedBox(height: Dimensions.height10,),
                    AppTextField(textController: _contactPersonNumber, hentText: "Your Number", icon: Icons.phone),
                  ],
                ),
              );
            }
          );
        }
      ),
      bottomNavigationBar: GetBuilder<LocationController>(
        builder: (locationController) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: Dimensions.height20*7,
                padding: EdgeInsets.only(
                    top: Dimensions.height30,
                    bottom: Dimensions.height30,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius20 * 2),
                        topLeft: Radius.circular(Dimensions.radius20 * 2)),
                    color: AppColors.buttonBackgroundColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        AddressModel _addressModel=AddressModel(
                          addressType: locationController.addressTypList[locationController.addressTypIndex],
                          contactPersonName: _contactPersonName.text,
                          contactPersonNumber: _contactPersonNumber.text,
                          address: _addressController.text,
                          latitude: locationController.position.latitude.toString(),
                          longitude: locationController.position.longitude.toString()
                        );
                          locationController.addAddress(_addressModel).then((response) {
                            if(response.isSuccess){
                              Get.toNamed(RouteHelper.getInitiol());
                              Get.snackbar("Address", "Added Successfully");
                              Get.offNamed(RouteHelper.getInitiol());
                            }else{
                              Get.snackbar("Address", "Couldn't save address");

                            }

                          });

                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: Dimensions.height20,
                            bottom: Dimensions.height20,
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                        ),
                        child: BigText(
                          text: 'Save address',
                          color: Colors.white,
                          size: Dimensions.font26,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ); },),
    );
  }
}
