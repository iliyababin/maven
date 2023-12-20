import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../equipment.dart';

class BarSelectionScreen extends StatefulWidget {
  const BarSelectionScreen({Key? key}) : super(key: key);

  @override
  State<BarSelectionScreen> createState() => _BarSelectionScreenState();
}

class _BarSelectionScreenState extends State<BarSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EquipmentBloc, EquipmentState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SearchableSelectionScreen<Bar>(
            title: 'Select Bar',
            items: state.bars,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.add),
              ),
            ],
            itemBuilder: (context, item, isSelected) {
              return ListTile(
                onTap: () {
                  Navigator.pop(context, item);
                },
                leading: CircleAvatar(
                  child: Text(item.name.substring(0, 1).toUpperCase()),
                ),
                title: Text(item.name),
                subtitle: Text(item.weight.toString()),
              );
            },
          );
        }
      },
    );
  }
}
