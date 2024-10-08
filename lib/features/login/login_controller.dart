import 'package:get/get.dart';
import 'package:recicla_facil/components/alerts/custom_snackbar.dart';
import 'package:recicla_facil/features/login/login_service.dart';
import 'package:recicla_facil/models/api_response.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class LoginController {
  var isLoading = false.obs;
  late String? token;

  Future<void> login(
    String login,
    String password,
    SimpleFontelicoProgressDialog dialog,
  ) async {
    try {
      isLoading.value = true;

      final ApiResponse response = await LoginService().login(login, password);

      if (response.success) {
        CustomSnackbar.showSuccess(response.message!);
        dialog.hide();
        Get.offAllNamed('/table');
      } else {
        CustomSnackbar.showError(response.message!);
      }
    } on Exception catch (ex) {
      printError(info: 'Erro ao realizar login: $ex');
    } finally {
      dialog.hide();
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;

      final ApiResponse response = await LoginService().logout();

      if (response.success) {
        CustomSnackbar.showSuccess(response.message!);

        Get.offAllNamed('/login');
      } else {
        CustomSnackbar.showError(response.message!);
      }
    } on Exception catch (ex) {
      printError(info: 'Erro ao realizar logout: $ex');
    } finally {
      isLoading.value = false;
    }
  }
}
