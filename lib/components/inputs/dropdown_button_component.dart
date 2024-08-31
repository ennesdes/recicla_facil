import 'package:flutter/material.dart';
import 'package:recicla_facil/enum/trash_type.dart';
import 'package:recicla_facil/utils/app_config.dart';

class DropdownButtonComponent extends StatelessWidget {
  final TrashTypeEnum selectedType;
  final ValueChanged<TrashTypeEnum?> onChanged;

  const DropdownButtonComponent({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppConfig.primaryColor!),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<TrashTypeEnum>(
          value: selectedType,
          onChanged: onChanged,
          items: TrashTypeEnum.values
              .map<DropdownMenuItem<TrashTypeEnum>>((TrashTypeEnum type) {
            return DropdownMenuItem<TrashTypeEnum>(
              value: type,
              child: Center(
                child: Text(
                  type.description,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }).toList(),
          dropdownColor: Colors.white,
          icon: Icon(
            Icons.arrow_drop_down,
            color: AppConfig.primaryColor,
          ),
          iconSize: 24,
          isExpanded: true,
        ),
      ),
    );
  }
}
