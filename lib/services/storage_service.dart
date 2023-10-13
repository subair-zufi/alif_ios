import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  StorageService._() {
    _init();
  }

  static StorageService instance = StorageService._();

  factory StorageService() => instance;

  late SharedPreferences _preferences;

  Future<void> _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static const loggedIn = "loggedIn";
  static const phone = 'phone';
  static const uid = 'uid';

  Future setLoggedIn() async => await _preferences.setBool(loggedIn, true);

  bool get isLoggedIn => _preferences.getBool(loggedIn) ?? false;

  Future setPhone(String value) async => await _preferences.setString(phone, value);
  String? get userPhone => _preferences.getString(phone);

  Future setUid(String value) async => await _preferences.setString(uid, value);
  String? get userId => _preferences.getString(uid);

  Future logout()=> _preferences.clear();
}
