import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:recicla_facil/components/buttons/button_elevated.dart';
import 'package:recicla_facil/components/inputs/input_text_field.dart';
import 'package:recicla_facil/features/login/login_controller.dart';
import 'package:recicla_facil/utils/app_config.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final controller = LoginController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(
      context: context,
    );

    final emailValidator = MultiValidator([
      RequiredValidator(errorText: 'E-mail é obrigatório'),
      EmailValidator(errorText: 'Insira um e-mail válido!'),
    ]);

    final passwordValidator = MultiValidator([
      RequiredValidator(errorText: 'Senha é obrigatória'),
      MinLengthValidator(
        6,
        errorText: 'Senha precisa ter no mínimo 6 caracteres',
      ),
    ]);

    return Obx(
      () => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppConfig.primaryColor,
                      ),
                      child: Center(
                        child: Image.asset(
                          AppConfig.login,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ),
                    decoration: BoxDecoration(
                      color: AppConfig.backgroundColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          InputTextField(
                            controller: loginController,
                            icon: Icons.person,
                            label: 'Email',
                            validator: emailValidator.call,
                          ),
                          InputTextField(
                            controller: passwordController,
                            icon: Icons.lock,
                            label: 'Senha',
                            isSecret: true,
                            validator: passwordValidator.call,
                          ),
                          ButtonElevated(
                            onPressed: controller.isLoading.value
                                ? () {}
                                : () async {
                                    dialog.show(
                                      message: 'Aguarde...',
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      type: SimpleFontelicoProgressDialogType
                                          .phoenix,
                                      backgroundColor: Colors.black54,
                                      indicatorColor: AppConfig.primaryColor,
                                    );

                                    await Future.delayed(
                                      const Duration(milliseconds: 500),
                                    );

                                    if (formKey.currentState!.validate()) {
                                      await controller.login(
                                        loginController.text,
                                        passwordController.text,
                                        dialog,
                                      );
                                    } else {
                                      dialog.hide();
                                    }
                                  },
                            text: 'ENTRAR',
                            backgroundColor: AppConfig.primaryColor!,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
