//the services layer after login or register
import 'package:flutter_mvvm_test/src/model/user_model.dart';

import 'cache_helper.dart';
import 'firestore_services.dart';

abstract class Database {
  Future addUserData(String userId, UserModel data);
  Future getUserData(String userId);
  late UserModel userModelData;
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({this.uid});
  final String? uid;
  final _service = FireStoreService.instance;
  @override
  late UserModel userModelData;
  @override
  Future addUserData(String userId, UserModel userModelData) async {
    await _service.setData(path: 'users/$userId', data: userModelData.toJson());
    CacheHelper.saveData(key: 'name', value: '${userModelData.name}');
    CacheHelper.saveData(key: 'phone', value: '${userModelData.phone}');
    CacheHelper.saveData(key: 'email', value: '${userModelData.email}');
    CacheHelper.saveData(key: 'id', value: '${userModelData.id}');
  }

  @override
  Future getUserData(String userId) async =>
      await _service.getData(userId: userId).then((value) {
        userModelData = UserModel.fromJson(value.data());
      });
}
