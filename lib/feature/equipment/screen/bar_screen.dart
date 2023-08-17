import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../theme/theme.dart';
import '../equipment.dart';

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
    return BlocBuilder<EquipmentBloc, EquipmentState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state.status.isLoaded) {
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
                            context.read<EquipmentBloc>().add(const BarAddEmpty());
                          },
                          leading: const Icon(
                            Icons.add_outlined,
                          ),
                          title: const Text(
                            'Create',
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            showBottomSheetDialog(
                              context: context,
                              child: ConfirmationDialog(
                                title: 'Reset Bars',
                                subtitle: 'This will reset all bars to default',
                                confirmText: 'Reset',
                                confirmButtonStyle: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(T(context).color.error),
                                  foregroundColor:
                                  MaterialStateProperty.all(T(context).color.onError),
                                ),
                                onSubmit: () {
                                  setState(() {
                                    context.read<EquipmentBloc>().add(const BarReset());
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
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(
                  Icons.more_vert_rounded,
                ),
              ),
            ],
            items: state.bars,
            itemBuilder: (context, bar, isSelected) {
              return ListTile(
                leading: CircleAvatar(
                  child: Text(
                    bar.name[0].capitalize,
                  ),
                ),
                title: Text(
                  bar.name,
                ),
                subtitle: Text(
                  bar.weight.toString(),
                ),
              );
            },
          );
        } else {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: Text('Error'),
            ),
          );
        }
      },
    );
    return Scaffold(
        appBar: AppBar(
            title: Text(
                selectedBars.isEmpty ? 'Bars' : selectedBars.length.toString()),
            leading: isSelecting
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isSelecting = false;
                        selectedBars.clear();
                      });
                    },
                    icon: const Icon(Icons.close),
                  )
                : null,
            actions: isSelecting
                ? [
                    IconButton(
                      onPressed: () async {
                        showBottomSheetDialog(
                          context: context,
                          child: ConfirmationDialog(
                            title: 'Delete ${selectedBars.length} Bar(s)',
                            subtitle: 'This action cannot be undone',
                            confirmText: 'Delete',
                            confirmButtonStyle: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  T(context).color.error),
                              foregroundColor: MaterialStateProperty.all(
                                  T(context).color.onError),
                            ),
                            onSubmit: () {
                              setState(() {
                                context
                                    .read<EquipmentBloc>()
                                    .add(BarDelete(selectedBars));
                              });
                            },
                          ),
                          onClose: () {},
                        );
                      },
                      icon: const Icon(
                        Icons.delete_outline_rounded,
                      ),
                    ),
                  ]
                : [
                    IconButton(
                      onPressed: () async {
                        showBottomSheetDialog(
                          context: context,
                          child: ConfirmationDialog(
                            title: 'Reset Bars',
                            subtitle: 'This will reset all bars to default',
                            confirmText: 'Reset',
                            confirmButtonStyle: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  T(context).color.error),
                              foregroundColor: MaterialStateProperty.all(
                                  T(context).color.onError),
                            ),
                            onSubmit: () {
                              setState(() {
                                context
                                    .read<EquipmentBloc>()
                                    .add(const BarReset());
                              });
                            },
                          ),
                          onClose: () {},
                        );
                      },
                      icon: const Icon(
                        Icons.restart_alt_rounded,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        context.read<EquipmentBloc>().add(const BarAddEmpty());
                      },
                      icon: const Icon(
                        Icons.add_rounded,
                      ),
                    ),
                  ]),
        body: BlocConsumer<EquipmentBloc, EquipmentState>(
          listener: (context, state) {
            if (state.status == EquipmentStatus.delete) {
              setState(() {
                isSelecting = false;
                selectedBars.clear();
              });
            }
          },
          builder: (context, state) {
            if (state.status == EquipmentStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              List<Bar> bars = state.bars;
              return ListView.builder(
                itemCount: bars.length,
                itemBuilder: (context, index) {
                  Bar bar = bars[index];
                  return AnimatedContainer(
                    color: selectedBars.contains(bar)
                        ? const Color(0xFF004E70)
                        : Colors.transparent,
                    duration: const Duration(milliseconds: 200),
                    child: ListTile(
                      onTap: () {
                        if (isSelecting) {
                          setState(() {
                            if (!selectedBars.remove(bar)) {
                              selectedBars.add(bar);
                            }
                          });
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditBarScreen(bar: bar)));
                        }
                      },
                      splashColor: T(context).color.secondary,
                      onLongPress: () {
                        setState(() {
                          selectedBars.add(bar);
                          isSelecting = true;
                        });
                      },
                      leading: CircleAvatar(
                        child: Text(
                          bar.name[0].capitalize,
                        ),
                      ),
                      title: Text(
                        bar.name,
                      ),
                      trailing: Text(
                        bar.weight.toString(),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}
