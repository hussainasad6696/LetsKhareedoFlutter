import 'dart:io';

import 'package:hive/hive.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:path_provider/path_provider.dart';

import '../CartDB.dart';

class HiveMethods {
  Box<CartDataBase> dataBox;
  Box userBox;

  init() async {
    Directory document = await getApplicationDocumentsDirectory();
    Hive.init(document.path);
    Hive.registerAdapter(CartDataBaseAdapter());
    await Hive.openBox<CartDataBase>(DB_NAME);
    await Hive.openBox(USER_DB);
  }

  addData(String imageUrl, String name, String description, String price,
      int numberOfItems) async {
    dataBox = await Hive.openBox(DB_NAME);
    CartDataBase cartDataBase = CartDataBase(
        imageUrl: imageUrl,
        name: name,
        description: description,
        price: price,
        numberOfItems: numberOfItems);
    await dataBox.add(cartDataBase);
    dataBox.close();
  }

  Future<List<CartDataBase>> getMeAllTheData() async {
    dataBox = await Hive.openBox(DB_NAME);
    // List data = dataBox.values.toList();
    // dataBox.close();
    List<CartDataBase> cartData = [];

    for (int i = 0; i < dataBox.length; i++) {
      var cartMap = dataBox.getAt(i);
      cartData.add(cartMap);
    }
    return cartData;
  }

  Future deleteAll(String name) async {
    dataBox = await Hive.openBox(name);
    dataBox.deleteAll(dataBox.keys);
    dataBox.close();
  }


  Future deleteFromList(int index) async {
    dataBox = await Hive.openBox(DB_NAME);
    dataBox.deleteAt(index);
    dataBox.close();
  }

  updateData(int index, int numberOfItems) async {
    dataBox = await Hive.openBox(DB_NAME);
    CartDataBase cartDataBase = dataBox.values.toList()[index];
    cartDataBase.numberOfItems = numberOfItems;
    dataBox.putAt(index, cartDataBase);
    dataBox.close();
  }

  Future<int> numberOfProductsInCart() async {
    dataBox = await Hive.openBox(DB_NAME);
    int numberOfItems = dataBox.values.toList().length;
    dataBox.close();
    return numberOfItems;
  }

  Future<void> userPreferencesUuid(String uuid) async {
    userBox = await Hive.openBox(USER_DB);
    userBox.put(USER_PREFERENCE_UUID_KEY, uuid);
    userBox.close();
  }

  Future<bool> userPreferenceUuidCheck() async {
    userBox = await Hive.openBox(USER_DB);
    String uuid = userBox.get(USER_PREFERENCE_UUID_KEY);
    return uuid == null ?  true : false ;
  }
}
