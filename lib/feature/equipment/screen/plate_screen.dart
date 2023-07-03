
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
    if(selectedPlates.isEmpty) isSelecting = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlates.isEmpty ? 'Plates' : selectedPlates.length.toString()),
        leading: isSelecting ? IconButton(
          onPressed: () {
            setState(() {
              isSelecting = false;
              selectedPlates.clear();
            });
          },
          icon: const Icon(Icons.close),
        ) : null,
        actions: isSelecting ? [
          IconButton(
            onPressed: () async {
              showBottomSheetDialog(
                context: context,
                child: ConfirmationDialog(
                  title: 'Delete ${selectedPlates.length} Plate(s)',
                  subtitle: 'This action cannot be undone',
                  confirmText: 'Delete',
                  confirmButtonStyle: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(T(context).color.error),
                    foregroundColor: MaterialStateProperty.all(T(context).color.onError),
                  ),
                  onSubmit: () {
                    setState(() {
                      context.read<EquipmentBloc>().add(PlateDelete(selectedPlates));
                    });
                  },

                ),
                onClose: (){},
              );
            },
            icon: const Icon(
              Icons.delete_outline_rounded,
            ),
          ),
        ] : [
          IconButton(
            onPressed: () async {
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
                onClose: (){},
              );
            },
            icon: const Icon(
              Icons.restart_alt_rounded,
            ),
          ),
          IconButton(
            onPressed: () async {
              context.read<EquipmentBloc>().add(PlateAddEmpty());
            },
            icon: const Icon(
              Icons.add_rounded,
            ),
          ),
        ]
      ),
      body: BlocConsumer<EquipmentBloc, EquipmentState>(
        listener: (context, state) {
          if(state.status == EquipmentStatus.delete) {
            setState(() {
              isSelecting = false;
              selectedPlates.clear();
            });
          }
        },
        builder: (context, state) {
          if(state.status == EquipmentStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            List<Plate> plates = state.plates;
            return ListView.builder(
              itemCount: plates.length,
              itemBuilder: (context, index) {
                Plate plate = plates[index];
                return AnimatedContainer(
                  color: selectedPlates.contains(plate) ? T(context).color.primaryContainer : Colors.transparent,
                  duration: const Duration(milliseconds: 200),
                  child: ListTile(
                    onTap: () {
                      if(isSelecting) {
                        setState(() {
                          if(!selectedPlates.remove(plate)) {
                            selectedPlates.add(plate);
                          }
                        });
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditPlateScreen(plate: plate)));
                      }
                    },
                    splashColor: T(context).color.secondary,
                    onLongPress: () {
                      setState(() {
                        if(selectedPlates.contains(plate)) {
                          selectedPlates.remove(plate);
                        } else {
                          selectedPlates.add(plate);
                        }
                        isSelecting = true;
                      });
                    },
                    leading: CircleAvatar(
                      backgroundColor: plate.color,
                    ),
                    title: Text(
                      removeDecimalZeroFormat(plate.weight),
                    ),
                    trailing: Text(
                      plate.amount.toString(),
                    ),
                  ),
                );
              },
            );
          }
        },
      )
    );
  }
}
