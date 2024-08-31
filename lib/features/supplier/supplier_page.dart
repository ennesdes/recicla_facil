import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recicla_facil/features/supplier/supplier_controller.dart';
import 'package:recicla_facil/models/delivery_model.dart';
import 'package:recicla_facil/utils/app_config.dart';
import 'package:recicla_facil/utils/app_font_size.dart';

class SupplierPage extends GetView<SupplierController> {
  final List<DeliveryModel> deliveries = [
    DeliveryModel(
        id: 1,
        recipient: "John Doe",
        date: "2024-08-31",
        status: DeliveryStatus.requested),
    DeliveryModel(
        id: 2,
        recipient: "Jane Smith",
        date: "2024-08-30",
        status: DeliveryStatus.completed),
    DeliveryModel(
        id: 3,
        recipient: "Michael Johnson",
        date: "2024-08-29",
        status: DeliveryStatus.requested),
    DeliveryModel(
        id: 4,
        recipient: "Emily Davis",
        date: "2024-08-28",
        status: DeliveryStatus.completed),
  ];

  SupplierPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fornecedor',
          style: TextStyle(
            fontSize: AppFontSize.getTitleFontSize(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: AppConfig.primaryColor,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed('/search_company_view'),
            icon: const Icon(Icons.add),
          ),
        ],
        leading: IconButton(
          onPressed: () => Get.toNamed('/login_page'),
          icon: const Icon(Icons.exit_to_app),
        ),
      ),
      body: ListView.builder(
        itemCount: deliveries.length,
        itemBuilder: (context, index) {
          final delivery = deliveries[index];
          return ListTile(
            leading: Icon(
              delivery.status == DeliveryStatus.completed
                  ? Icons.check_circle
                  : Icons.pending,
              color: delivery.status == DeliveryStatus.completed
                  ? Colors.green
                  : Colors.orange,
            ),
            title: Text('Tipo de coleta: ${delivery.recipient}'),
            subtitle: Text('Data: ${delivery.date}'),
            trailing: Text(
              delivery.status == DeliveryStatus.completed
                  ? 'Confirmada'
                  : 'Solicitada',
              style: TextStyle(
                color: delivery.status == DeliveryStatus.completed
                    ? Colors.green
                    : Colors.orange,
              ),
            ),
            onTap: () {
              // Ação quando um item é clicado
              // Ex: Navegar para uma página de detalhes
            },
          );
        },
      ),
    );
  }
}
