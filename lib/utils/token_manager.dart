import 'package:get_storage/get_storage.dart';

class TokenManager {
  final box = GetStorage();

  Future<void> saveToken(String token) async {
    await box.write('token', token);
  }

  String? getToken() {
    return box.read('token');
  }

  Future<void> removeToken() async {
    await box.remove('token');
  }
}
