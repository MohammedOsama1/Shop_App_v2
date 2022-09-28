import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    return sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future addData(key, value) async {
    return  await sharedPreferences!.setString(key, value);
  }

  static  getData(key)  {
    return sharedPreferences?.get(key);
  }
  static deleteDate(key) async{
    await sharedPreferences!.remove(key);
  }
}
