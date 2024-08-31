import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:recicla_facil/features/collector/list_proposal_page.dart';
import 'package:recicla_facil/features/login/login_page.dart';
import 'package:recicla_facil/features/supplier/supplier_controller.dart';
import 'package:recicla_facil/features/supplier/supplier_page.dart';
import 'package:recicla_facil/features/supplier/views/search_company_view.dart';
import 'package:recicla_facil/utils/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Recicla fácil',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppConfig.primaryColor!),
        useMaterial3: true,
      ),
      initialRoute: '/login_page',
      getPages: [
        GetPage(name: '/login_page', page: () => const LoginPage()),
        GetPage(name: '/supplier_page', page: () => SupplierPage()),
        GetPage(name: '/collector_page', page: () => const ListProposalPage()),
        GetPage(
          name: '/search_company_view',
          page: () => SearchCompanyView(
            controller: Get.put(SupplierController()),
          ),
        ),
      ],
    );
  }
}
