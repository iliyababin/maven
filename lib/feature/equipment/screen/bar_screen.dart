import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../settings/settings.dart';
import '../../theme/theme.dart';
import '../equipment.dart';

class BarScreen extends StatefulWidget {
  const BarScreen({Key? key}) : super(key: key);

  @override
  State<BarScreen> createState() => _BarScreenState();
}

class _BarScreenState extends State<BarScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EquipmentBloc, EquipmentState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return SearchableSelectionScreen(
            title: 'Bars',
            actions: [
              IconButton(
                onPressed: () {
                  showBottomSheetDialog(
                    context: context,
                    child: ListDialog(
                      children: [
                        ListTile(
                          onTap: () {
                            context.read<EquipmentBloc>().add(const BarAdd(Bar.empty()));
                            Navigator.pop(context);
                          },
                          leading: const Icon(Icons.add_outlined),
                          title: const Text('Add'),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            showBottomSheetDialog(
                              context: context,
                              child: ConfirmationDialog(
                                title: 'Reset Bars',
                                subtitle: 'This will reset all bars to default',
                                confirmText: 'Reset',
                                onSubmit: () {
                                  context.read<EquipmentBloc>().add(const BarReset());
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
                icon: const Icon(Icons.more_vert_rounded),
              ),
            ],
            items: state.bars,
            itemBuilder: (context, bar, isSelected) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => BarEditScreen(bar: bar)));
                },
                leading: CircleAvatar(
                  child: Text(bar.name[0].capitalize),
                ),
                title: Text(bar.name),
                subtitle: Text(s(context).parseWeight(bar.weight)),
              );
            },
          );
        }
      },
    );
  }
}
