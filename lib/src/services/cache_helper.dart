import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{

  static SharedPreferences? sharedPreferences;
  static init() async{
    sharedPreferences = await SharedPreferences.getInstance();
  }
  //save data to shared preference
  static Future<dynamic> saveData(
      {required String key, required dynamic value}) async {
    if (value is String) {
      return await sharedPreferences!.setString(key, value);
    }
    if (value is int) {
      return await sharedPreferences!.setInt(key, value);
    }
    if (value is double) {
      return await sharedPreferences!.setDouble(key, value);
    }
    if (value is bool) {
      return await sharedPreferences!.setBool(key, value);
    }
  }
  // remove with key
  static getData({required String key}){
    return sharedPreferences!.get(key);
  }
  //remove everything
  static removeData({required String key}){
    return sharedPreferences!.clear();
  }
}