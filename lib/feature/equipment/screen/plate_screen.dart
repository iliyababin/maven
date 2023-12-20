import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../theme/theme.dart';
import '../equipment.dart';

class PlateScreen extends StatefulWidget {
  const PlateScreen({Key? key}) : super(key: key);

  @override
  State<PlateScreen> createState() => _PlateScreenState();
}

class _PlateScreenState extends State<PlateScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EquipmentBloc, EquipmentState>(
      builder: (context, state) {
        if (state.status == EquipmentStatus.loading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          final List<Plate> plates = state.plates;
          return SearchableSelectionScreen(
            title: 'Plates',
            items: plates,
            actions: [
              IconButton(
                onPressed: () {
                  showBottomSheetDialog(
                    context: context,
                    child: ListDialog(
                      children: [
                        ListTile(
                          onTap: () {
                            context.read<EquipmentBloc>().add(const PlateAdd(Plate.empty()));
                            Navigator.pop(context);
                          },
                          leading: const Icon(Icons.add_rounded),
                          title: const Text('Add'),
                        ),
                        ListTile(
                          onTap: () async {
                            showBottomSheetDialog(
                              context: context,
                              child: ConfirmationDialog(
                                title: 'Reset Plates',
                                subtitle: 'This will reset all plates to default',
                                confirmText: 'Reset',
                                onSubmit: () {
                                  context.read<EquipmentBloc>().add(const PlateReset());
                                },
                              ),
                            );
                          },
                          leading: Icon(
                            Icons.restart_alt_rounded,
                            color: T(context).color.error,
                          ),
                          title: Text(
                            'Reset',
                            style: TextStyle(
                              color: T(context).color.error,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.more_vert_outlined),
              )
            ],
            itemBuilder: (context, plate, isSelected) {
              return ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PlateEditScreen(plate: plate)));
                },
                leading: CircleAvatar(backgroundColor: plate.color),
                title: Text(plate.weight.truncateZeros),
              );
            },
          );
        }
      },
    );
  }
}
