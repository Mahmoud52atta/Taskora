import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  /// ✅ **تهيئة `SharedPreferences` بشكل صحيح**
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  /// ✅ **جلب `String` مع التأكد من عدم إرجاع `null`**
  static String getDataString({required String key, String defaultValue = ""}) {
    return sharedPreferences.getString(key) ?? defaultValue;
  }

  /// ✅ **جلب `int` مع قيمة افتراضية عند `null`**
  static int getDataInt({required String key, int defaultValue = 0}) {
    return sharedPreferences.getInt(key) ?? defaultValue;
  }

  /// ✅ **جلب `double` مع قيمة افتراضية عند `null`**
  static double getDataDouble(
      {required String key, double defaultValue = 0.0}) {
    return sharedPreferences.getDouble(key) ?? defaultValue;
  }

  /// ✅ **جلب `bool` مع قيمة افتراضية عند `null`**
  static bool getDataBool({required String key, bool defaultValue = false}) {
    return sharedPreferences.getBool(key) ?? defaultValue;
  }

  /// ✅ **تخزين القيم بناءً على نوعها**
  static Future<bool> saveData(
      {required String key, required dynamic value}) async {
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is double) {
      return await sharedPreferences.setDouble(key, value);
    }
    return false;
  }

  /// ✅ **التحقق من وجود مفتاح في `SharedPreferences`**
  static bool containsKey({required String key}) {
    return sharedPreferences.containsKey(key);
  }

  /// ✅ **إزالة بيانات مفتاح معين**
  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  /// ✅ **مسح جميع البيانات المخزنة**
  static Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }
}
