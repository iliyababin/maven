import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/common/widget/selection_screen.dart';
import 'package:maven/feature/equipment/bloc/equipment/equipment_bloc.dart';

import '../../../database/database.dart';

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
        } else if (state.status.isLoaded) {
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
            itemBuilder: (context, item) {
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
        } else {
          return const Center(
            child: Text('There was an error loading the bars'),
          );
        }
      },
    );
  }
}
