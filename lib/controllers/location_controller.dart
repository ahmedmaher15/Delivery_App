import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:food_deliverya_pp/data/repository/location_repo.dart';
import 'package:food_deliverya_pp/models/response_model.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/address_model.dart';

class LocationController extends GetxController implements GetxService {
  final LocationRepo locationRepo;

  LocationController({required this.locationRepo});

  late Position _position;
  late Position _pickPosition;
  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();

  Placemark get placemark => _placemark;

  Placemark get pickPlacemark => _pickPlacemark;
  List<AddressModel> _addressList = [];

  List<AddressModel> get addressList => _addressList;
  late List<AddressModel> _allAddressList;

  List<AddressModel> get allAddressList => _allAddressList;
  List<String> _addressTypList = ["home", "office", "others"];

  List<String> get addressTypList => _addressTypList;

  late GoogleMapController _mapController;

  GoogleMapController get mapController => _mapController;
  bool _updateAdressData = true;
  bool _changeAddress = true;

  int _addressTypIndex = 0;

  int get addressTypIndex => _addressTypIndex;

  bool _loading = false;

  bool get loading => _loading;

  Position get position => _position;

  Position get pickPosition => _pickPosition;

  /*for service zoon*/
  bool _isLoading = false;

  bool get isLoding => _isLoading;

  /*whether the user is in service zone or not*/
  bool _inZone = false;

  bool get inZone => _inZone;

  /*show and hiding the button as the map loads*/

  bool _buttonDisabled = true;

  bool get bottonDisabled => _buttonDisabled;

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  void updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAdressData) {
      _loading = true;
      update();
      try {
        if (fromAddress) {
          _position = Position(
            latitude: position.target.longitude,
            longitude: position.target.longitude,
            timestamp: DateTime.now(),
            heading: 1,
            accuracy: 1,
            altitude: 1,
            speedAccuracy: 1,
            speed: 1,
          );
        } else {
          _pickPosition = Position(
            latitude: position.target.longitude,
            longitude: position.target.longitude,
            timestamp: DateTime.now(),
            heading: 1,
            accuracy: 1,
            altitude: 1,
            speedAccuracy: 1,
            speed: 1,
          );
        }
/*
* if button  value is false we are in service area
* */
        ResponseModel _responseModle=await getZone(position.target.latitude.toString(), position.target.longitude.toString(), false);

        _buttonDisabled= !_responseModle .isSuccess;

        //the place when we will start to take with the  server////////////////////////
        if (_changeAddress == true) {
          String _address = await getAddreesfromGeocode(LatLng(position.target.latitude, position.target.longitude));
          fromAddress ? _placemark = Placemark(name: _address) : _pickPlacemark = Placemark(name: _address);
        }
      } catch (e) {
        print(e);
      }
      _loading = false;
      update();
    } else {
      _updateAdressData = true;
    }
  }

  Future<String> getAddreesfromGeocode(LatLng latLng) async {
    String _address = "";
    Response response = await locationRepo.getAddressfromGeocode(latLng);
    if (response.body["status"] == "OK") {
      _address = response.body["results"][0]['formatted_address'].toString();
      // print("printing address"+_address);
    } else {}
    update();
    return _address;
  }

  late Map<String, dynamic> _getAddress;

  Map get getAddress => _getAddress;

  AddressModel getUserAddress() {
    late AddressModel _addressModel;
    //converting to map using jsonDecode//////////////
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    try {
      _addressModel = AddressModel.fromJson(_getAddress);
    } catch (e) {
      print(e);
    }
    return _addressModel;
  }

  void setAddressTypeIndex(int index) {
    _addressTypIndex = index;
    update();
  }

  Future<ResponseModel> addAddress(AddressModel addressModel) async {
    _loading = true;
    Response response = await locationRepo.addAddress(addressModel);
    ResponseModel responseModel;

    if (response.statusCode == 200) {
      await getAddressList();
      String message = response.body["message"];
      responseModel = ResponseModel(true, message);
      await saveUserAddress(addressModel);
    } else {
      print("couldn't save the address");
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }

  Future getAddressList() async {
    Response response = await locationRepo.getAllAddress();
    if (response.statusCode == 200) {
      _addressList = [];
      _allAddressList = [];
      response.body.forEach((address) {
        _addressList.add(AddressModel.fromJson(address));
        _allAddressList.add(AddressModel.fromJson(address));
      });
    } else {
      _addressList = [];
      _allAddressList = [];
    }
    update();
  }

  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());
    return await locationRepo.saveUserAddress(userAddress);
  }

  void clearAddressList() {
    _allAddressList = [];
    _addressList = [];
    update();
  }

  setAddressData() {
    _position = pickPosition;
    _placemark = pickPlacemark;
    _updateAdressData = false;
    update();
  }

  Future<ResponseModel> getZone(String lat, String lang, bool markerLoad) async {
    late ResponseModel _responseModel;

    if (markerLoad) {
      _loading = true;
    } else {
      _isLoading = true;
    }
    update();
    await Future.delayed(Duration(seconds: 2), () {
      _responseModel = ResponseModel(true, 'success');
      if (markerLoad) {
        _loading = false;
      } else {
        _isLoading = false;
      }
      _inZone=true;
    });
    update();
    return _responseModel;
  }

  getUserAddressFromLocalStorage() {
    return locationRepo.getUserAddress();
  }
}
