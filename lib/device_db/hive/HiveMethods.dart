import 'dart:io';

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
      ..registerAdapter(CartDataBaseAdapter())
      ..registerAdapter(MapDetailAdapter());
    await Hive.openBox<CartDataBase>(DB_NAME);
    await Hive.openBox(USER_DB);
  }

  addData(
      String imageUrl,
      String name,
      String description,
      String price,
      int numberOfItems,
      String selectedShoulders,
      String selectedChest,
      String selectedTypes, String selectedWaist) async {
    _dataBox = await Hive.openBox(DB_NAME);
    CartDataBase cartDataBase = CartDataBase(
        imageUrl: imageUrl,
        name: name,
        description: description,
        price: price,
        numberOfItems: numberOfItems,
        shoulder: selectedShoulders,
        chest: selectedChest,
        type: selectedTypes,
    waist: selectedWaist);
    await _dataBox.add(cartDataBase);
    _dataBox.close();
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
