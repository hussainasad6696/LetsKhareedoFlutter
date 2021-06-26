import 'dart:ffi';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/device_db/userAddresses/mapDetailModel.dart';
import 'package:path_provider/path_provider.dart';

import '../CartDB.dart';

class HiveMethods {
  Box<CartDataBase> _dataBox;
  Box<MapDetail> _mapBox;
  Box userBox;

  init() async {
    Directory document = await getApplicationDocumentsDirectory();
    Hive
      ..init(document.path)
      ..registerAdapter(CartDataBaseAdapter())..registerAdapter(
        MapDetailAdapter());
    await Hive.openBox<CartDataBase>(DB_NAME);
    await Hive.openBox<CartDataBase>(DB_FAV_NAME);
    await Hive.openBox(USER_DB);
  }

  addData(CartDataBase cartDataBase) async {
    _dataBox = await Hive.openBox(DB_NAME);
    /*CartDataBase cartDataBase = CartDataBase(
        imageUrl: imageUrl,
        name: name,
        description: description,
        price: price,
        numberOfItems: numberOfItems,
        shoulder: selectedShoulders,
        chest: selectedChest,
        type: selectedTypes,
        waist: selectedWaist,
        uuid: uuid);*/
    await _dataBox.add(cartDataBase);
    _dataBox.close();
  }

  addDataToFav(CartDataBase cartDataBase) async {
    _dataBox = await Hive.openBox(DB_FAV_NAME);
    // CartDataBase cartDataBase = CartDataBase(
    //     imageUrl: imageUrl,
    //     name: name,
    //     description: description,
    //     price: price,
    //     numberOfItems: numberOfItems,
    //     shoulder: selectedShoulders,
    //     chest: selectedChest,
    //     type: selectedTypes,
    //     waist: selectedWaist,
    //     uuid: uuid);
    // print("added $uuid   $name");
    await _dataBox.add(cartDataBase).then((value) {
      print("Data added $value----------${cartDataBase.uuid}");
    });
    _dataBox.close();
  }

  Future<bool> checkForExistance(String uuid) async {
    _dataBox = await Hive.openBox(DB_FAV_NAME);
    bool check = false;
    for(int i = 0; i < _dataBox.length; i++){
      if(uuid == _dataBox.getAt(i).uuid){
        check = true;
        break;
      }
    }
    return check;
  }

  deleteFromFav(String uuid) async {
   _dataBox = await Hive.openBox(DB_FAV_NAME);
   for(int i = 0; i < _dataBox.length; i++){
     if(uuid == _dataBox.getAt(i).uuid){
       print("$uuid");
       _dataBox.deleteAt(i).then((value) {
         print("Deleted $uuid --------$uuid");
       });
       break;
     }
   }
  }

  Future<List<CartDataBase>> getAllTheFavData() async {
    _dataBox = await Hive.openBox(DB_FAV_NAME);
    List<CartDataBase> favData = [];
    for(int i = 0; i < _dataBox.length; i++){
      var favDataObj = _dataBox.getAt(i);
      favData.add(favDataObj);
    }
    return favData;
  }


  addDataMap(MapDetail mapDetailData) async {
    _mapBox = await Hive.openBox(MAP_DB_NAME);
    await _mapBox.add(mapDetailData);
    _mapBox.close();
  }

  Future<int> getMeTheListNumberOfItemsInDb() async {
    _dataBox = await Hive.openBox(DB_NAME);
    return _dataBox.length;
  }

  Future<double> getMeTheTotalCostOfSelectedProducts() async {
    _dataBox = await Hive.openBox(DB_NAME);
    double totalPrice = 0.0;
    for (int i = 0; i < _dataBox.length; i++) {
      try {
        var cartMap = _dataBox
            .getAt(i)
            .price;
        double price = double.parse(cartMap);
        totalPrice = totalPrice + price;
      } catch (e) {
        print("$e ===================error==");
      }
    }
    return totalPrice;
  }

  Future<List<CartDataBase>> getMeAllTheData() async {
    _dataBox = await Hive.openBox(DB_NAME);
    List<CartDataBase> cartData = [];
    for (int i = 0; i < _dataBox.length; i++) {
      var cartMap = _dataBox.getAt(i);
      cartData.add(cartMap);
    }
    return cartData;
  }

  Future<List<MapDetail>> getMeAllMapDetailData() async {
    _mapBox = await Hive.openBox(MAP_DB_NAME);
    List<MapDetail> mapDetail = [];
    for (int i = 0; i < _mapBox.length; i++) {
      var mapDetailMap = _mapBox.getAt(i);
      mapDetail.add(mapDetailMap);
    }
    return mapDetail;
  }

  Future deleteAll(String name) async {
    _dataBox = await Hive.openBox(name);
    _dataBox.deleteAll(_dataBox.keys);
    _dataBox.close();
  }

  Future deleteAllMapDataFrom() async {
    _mapBox = await Hive.openBox(MAP_DB_NAME);
    _mapBox.deleteAll(_mapBox.keys);
    _mapBox.close();
  }

  Future deleteFromList(int index) async {
    _dataBox = await Hive.openBox(DB_NAME);
    _dataBox.deleteAt(index);
    _dataBox.close();
  }

  Future deleteMapDataFromList(int index) async {
    _mapBox = await Hive.openBox(MAP_DB_NAME);
    _mapBox.deleteAt(index);
    _mapBox.close();
  }

  updateData(int index, int numberOfItems) async {
    _dataBox = await Hive.openBox(DB_NAME);
    CartDataBase cartDataBase = _dataBox.values.toList()[index];
    cartDataBase.numberOfItems = numberOfItems;
    _dataBox.putAt(index, cartDataBase);
    _dataBox.close();
  }

  Future updateMapData(int index, MapDetail mapDetail) async {
    _mapBox = await Hive.openBox(MAP_DB_NAME);
    _mapBox.putAt(index, mapDetail);
    _mapBox.close();
  }

  Future<String> getUserPreferenceUuid() async {
    userBox = await Hive.openBox(USER_DB);
    String uuid = userBox.get(USER_PREFERENCE_UUID_KEY);
    return uuid;
  }

  Future<void> userPreferencesUuid(String uuid) async {
    userBox = await Hive.openBox(USER_DB);
    userBox.put(USER_PREFERENCE_UUID_KEY, uuid);
    userBox.close();
  }

  Future<bool> userPreferenceUuidCheck() async {
    userBox = await Hive.openBox(USER_DB);
    String uuid = userBox.get(USER_PREFERENCE_UUID_KEY);
    return uuid == null ? true : false;
  }
}
