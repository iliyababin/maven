import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';

class EquipmentSelectionScreen extends StatelessWidget {
  const EquipmentSelectionScreen({
    Key? key,
    this.equipment,
  }) : super(key: key);

  final Equipment? equipment;

  @override
  Widget build(BuildContext context) {
    return SearchableSelectionScreen<Equipment>(
      title: 'Equipment',
      items: Equipment.values,
      itemBuilder: (context, item, isSelected) {
        return ListTile(
          onTap: () {
            Navigator.of(context).pop(item);
          },
          leading: CircleAvatar(
            child: Text(item.name[0]),
          ),
          title: Text(item.name),
          trailing: equipment == item ? const Icon(Icons.check) : null,
        );
      },
    );
  }
}
