
import 'package:Maven/common/dialog/show_bottom_sheet_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/dialog/confirmation_dialog.dart';
import '../../../theme/m_themes.dart';
import '../bloc/plate/plate_bloc.dart';
import '../model/plate.dart';


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
                  title: 'Delete Selected Plates',
                  subtitle: 'This action cannot be undone',
                  submitColor: mt(context).text.errorColor,
                  confirmText: 'Delete',
                  onSubmit: () {
                    setState(() {
                      context.read<PlateBloc>().add(PlateDelete(selectedPlates));
                    });
                  },
                ),
                onClose: (){},
              );
            },
            icon: Icon(
              Icons.delete_outline_rounded,
              color: mt(context).icon.accentColor,
            ),
          ),
        ] : [
          IconButton(
            onPressed: () async {
              context.read<PlateBloc>().add(PlateAddEmpty());
            },
            icon: Icon(
              Icons.add_rounded,
              color: mt(context).icon.accentColor,
            ),
          ),
        ]
      ),
      body: BlocConsumer<PlateBloc, PlateState>(
        listener: (context, state) {
          if(state.status == PlateStatus.delete) {
            setState(() {
              isSelecting = false;
              selectedPlates.clear();
            });
          }
        },
        builder: (context, state) {
          if(state.status == PlateStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            List<Plate> plates = state.plates;
            return ListView.builder(
              itemCount: plates.length,
              itemBuilder: (context, index) {
                Plate plate = plates[index];
                return AnimatedContainer(
                  color: selectedPlates.contains(plate) ? const Color(0xFF004E70) : Colors.transparent,
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
                        print('PUSH');

                        //Navigator.push(context, MaterialPageRoute(builder: (context) => EditPlateScreen(plate: plate)));
                      }
                    },
                    splashColor: mt(context).borderColor,
                    onLongPress: () {
                      setState(() {
                        selectedPlates.add(plate);
                        isSelecting = true;
                      });
                    },
                    leading: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: plate.color,
                        borderRadius: BorderRadiusDirectional.circular(50),
                      ),
                    ),
                    title: Text(
                      plate.weight.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        color: mt(context).text.primaryColor,
                      ),
                    ),
                    trailing: isSelecting ? null : Icon(
                      Icons.chevron_right_rounded,
                      color: mt(context).icon.accentColor,
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
