
import 'package:Maven/common/dialog/show_bottom_sheet_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/dialog/confirmation_dialog.dart';
import '../../../database/model/bar.dart';
import '../bloc/equipment/equipment_bloc.dart';
import 'edit_bar_screen.dart';


class BarScreen extends StatefulWidget {
  const BarScreen({Key? key}) : super(key: key);

  @override
  State<BarScreen> createState() => _BarScreenState();
}

class _BarScreenState extends State<BarScreen> {
  bool isSelecting = false;
  List<Bar> selectedBars = [];

  @override
  Widget build(BuildContext context) {
    if(selectedBars.isEmpty) isSelecting = false;
    return Scaffold(
        appBar: AppBar(
            title: Text(selectedBars.isEmpty ? 'Bars' : selectedBars.length.toString()),
            leading: isSelecting ? IconButton(
              onPressed: () {
                setState(() {
                  isSelecting = false;
                  selectedBars.clear();
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
                      title: 'Delete ${selectedBars.length} Bar(s)',
                      subtitle: 'This action cannot be undone',
                      confirmColor: mt(context).color.error,
                      confirmText: 'Delete',
                      onSubmit: () {
                        setState(() {
                          context.read<EquipmentBloc>().add(BarDelete(selectedBars));
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
                      title: 'Reset Bars',
                      subtitle: 'This will reset all bars to default',
                      confirmColor: mt(context).color.error,
                      confirmText: 'Reset',
                      onSubmit: () {
                        setState(() {
                          context.read<EquipmentBloc>().add(BarReset());
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
                  context.read<EquipmentBloc>().add(BarAddEmpty());
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
                selectedBars.clear();
              });
            }
          },
          builder: (context, state) {
            if(state.status == EquipmentStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              List<Bar> bars = state.bars;
              return ListView.builder(
                itemCount: bars.length,
                itemBuilder: (context, index) {
                  Bar bar = bars[index];
                  return AnimatedContainer(
                    color: selectedBars.contains(bar) ? const Color(0xFF004E70) : Colors.transparent,
                    duration: const Duration(milliseconds: 200),
                    child: ListTile(
                      onTap: () {
                        if(isSelecting) {
                          setState(() {
                            if(!selectedBars.remove(bar)) {
                              selectedBars.add(bar);
                            }
                          });
                        } else {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditBarScreen(bar: bar)));
                        }
                      },
                      splashColor: mt(context).color.secondary,
                      onLongPress: () {
                        setState(() {
                          selectedBars.add(bar);
                          isSelecting = true;
                        });
                      },
                      title: Text(
                        bar.name,
                        style: mt(context).textStyle.body1,
                      ),
                      subtitle: Text(
                        bar.weight.toString(),
                        style: mt(context).textStyle.subtitle2,
                      ),
                      trailing: isSelecting ? null : const Icon(
                        Icons.chevron_right_rounded,
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
