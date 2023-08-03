import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../../theme/theme.dart';
import '../equipment.dart';

class PlateScreen extends StatefulWidget {
  const PlateScreen({Key? key}) : super(key: key);

  @override
  State<PlateScreen> createState() => _PlateScreenState();
}

class _PlateScreenState extends State<PlateScreen> {
  bool isSelecting = false;
  List<Plate> selectedPlates = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EquipmentBloc, EquipmentState>(
      listener: (context, state) {
        if (state.status == EquipmentStatus.delete) {
          setState(() {
            isSelecting = false;
            selectedPlates.clear();
          });
        }
      },
      builder: (context, state) {
        if (state.status == EquipmentStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          List<Plate> plates = state.plates;
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
                            context.read<EquipmentBloc>().add(PlateAddEmpty());
                          },
                          leading: const Icon(
                            Icons.add_rounded,
                          ),
                          title: Text(
                            'Add',
                          ),
                        ),
                        ListTile(
                          onTap: () async {
                            showBottomSheetDialog(
                              context: context,
                              child: ConfirmationDialog(
                                title: 'Reset Plates',
                                subtitle: 'This will reset all plates to default',
                                confirmText: 'Reset',
                                confirmButtonStyle: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(T(context).color.error),
                                  foregroundColor: MaterialStateProperty.all(T(context).color.onError),
                                ),
                                onSubmit: () {
                                  setState(() {
                                    context.read<EquipmentBloc>().add(PlateReset());
                                  });
                                },
                              ),
                              onClose: () {},
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
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(
                  Icons.more_vert_outlined,
                ),
              )
            ],
            onSelected: (items) {
              // TODO: Implement
            },
            itemBuilder: (context, plate, isSelected) {
              return ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditPlateScreen(plate: plate)));
                },
                leading: CircleAvatar(
                  backgroundColor: plate.color,
                ),
                title: Text(
                  plate.weight.truncateZeros,
                ),
                tileColor: isSelected ? T(context).color.primaryContainer : null,
                trailing: Text(
                  plate.amount.toString(),
                ),
              );
            },
          );
        }
      },
    );
  }
}
