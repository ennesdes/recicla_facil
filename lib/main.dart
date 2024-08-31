import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:recicla_facil/features/login%20copy/login_page.dart';
import 'package:recicla_facil/features/supplier/supplier_page.dart';
import 'package:recicla_facil/features/supplier/views/search_company_view.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login_page',
      getPages: [
        GetPage(name: '/login_page', page: () => const LoginPage()),
        GetPage(name: '/supplier_page', page: () => SupplierPage()),
        // GetPage(name: '/collector_page', page: () => SupplierPage()),
        GetPage(
          name: '/search_company_view',
          page: () => const SearchCompanyView(),
        ),
      ],
    );
  }
}
