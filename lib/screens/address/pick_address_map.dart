import 'package:flutter/material.dart';
import 'package:food_deliverya_pp/base/custom_button.dart';
import 'package:food_deliverya_pp/controllers/location_controller.dart';
import 'package:food_deliverya_pp/routes/routes_helper.dart';
import 'package:food_deliverya_pp/utils/colors.dart';
import 'package:food_deliverya_pp/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'add_address_page.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignUp;
  final bool fromAddress;
  final GoogleMapController? googleMapController;

  const PickAddressMap({Key? key, required this.fromSignUp, required this.fromAddress, this.googleMapController}) : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initalPosation;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /* if (widget.fromAddress!) {}*/
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initalPosation = const LatLng(45.53225, -122.677433);
      _cameraPosition = CameraPosition(target: _initalPosation, zoom: 17);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initalPosation = LatLng(double.parse(Get.find<LocationController>().getAddress['latitude']),
            double.parse(Get.find<LocationController>().getAddress['longitude']));
        _cameraPosition = CameraPosition(target: _initalPosation, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.infinity,
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(target: _initalPosation, zoom: 17),
                    zoomControlsEnabled: false,
                    onCameraMove: (cameraPosition) {
                      _cameraPosition = cameraPosition;
                    },
                    onCameraIdle: () {
                      Get.find<LocationController>().updatePosition(_cameraPosition, false);
                    },
                    onMapCreated: (mapController) {
                      _mapController = mapController;
                      if (true) {
                        debugPrint("pick from web");
                      }
                    },
                  ),
                  Center(
                    child: !locationController.loading
                        ? Image.asset(
                            "assets/image/pick_marker.png",
                            height: Dimensions.height25 * 2,
                            width: Dimensions.width10 * 5,
                          )
                        : const CircularProgressIndicator(),
                  ),
                  Positioned(
                    top: Dimensions.height45,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.height10),
                      height: Dimensions.height25 * 2,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: Dimensions.height25,
                            color: AppColors.yellowColor,
                          ),
                          Expanded(
                              child: Text(
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimensions.font16,
                            ),
                            locationController.pickPlacemark.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )),
                          SizedBox(
                            width: Dimensions.width10,
                          ),
                          Icon(
                            Icons.search,
                            size: Dimensions.height25,
                            color: AppColors.yellowColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: Dimensions.height20 * 4,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      child: locationController.isLoding
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : CustomButton(
                              buttonText:locationController.inZone? widget.fromAddress?'Pick Address':'Pick Location':'Service is not available in your area',
                              onPressed:(locationController.bottonDisabled||locationController.loading)
                                  ? null
                                  : () {
                                      if (locationController.pickPosition.latitude != 0 && locationController.pickPlacemark.name != null) {
                                        if (widget.fromAddress) {
                                          if (widget.googleMapController != null) {
                                            widget.googleMapController!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
                                                target:
                                                    LatLng(locationController.pickPosition.latitude,
                                                        locationController.pickPosition.longitude))));
                                            locationController.setAddressData();
                                          }
                                          Get.toNamed(RouteHelper.getAddressPage());
                                        }
                                      }
                                    },
                            ))
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
