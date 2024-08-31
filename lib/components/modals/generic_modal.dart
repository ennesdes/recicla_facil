import 'package:flutter/material.dart';
import 'package:recicla_facil/utils/app_config.dart';

class GenericModalComponent extends StatelessWidget {
  final Widget content;

  const GenericModalComponent({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: AppConfig.backgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: content,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
