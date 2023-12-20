import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../settings/settings.dart';
import '../../theme/theme.dart';
import '../equipment.dart';

class BarEditScreen extends StatefulWidget {
  const BarEditScreen({
    Key? key,
    required this.bar,
  }) : super(key: key);

  final Bar bar;

  @override
  State<BarEditScreen> createState() => _BarEditScreenState();
}

class _BarEditScreenState extends State<BarEditScreen> {
  late Bar bar;
  late bool isEdited;

  void updateBar(Bar bar) {
    setState(() {
      this.bar = bar;
      isEdited = this.bar != widget.bar;
    });
  }

  @override
  void initState() {
    bar = widget.bar.copyWith();
    isEdited = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isEdited
          ? FloatingActionButton.extended(
              onPressed: () {
                context.read<EquipmentBloc>().add(BarUpdate(bar));
                Navigator.pop(context);
              },
              icon: const Icon(Icons.check),
              label: const Text('Save'),
            )
          : null,
      appBar: AppBar(
        title: const Text('Edit Bar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_rounded),
            onPressed: () {
              showBottomSheetDialog(
                context: context,
                child: ListDialog(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.copy),
                      title: const Text('Duplicate'),
                      onTap: () {
                        // TODO: Duplicate bar
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.delete,
                        color: T(context).color.error,
                      ),
                      title: Text(
                        'Delete',
                        style: TextStyle(
                          color: T(context).color.error,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        context.read<EquipmentBloc>().add(BarDelete(bar));
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: T(context).space.large),
        child: CustomScrollView(
          slivers: [
            const Heading(
              title: 'Preview',
              size: HeadingSize.small,
            ),
            SliverToBoxAdapter(
              child: Container(
                alignment: Alignment.center,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(T(context).shape.large),
                  color: T(context).color.surface,
                ),
                child: const Text('Not available'),
              ),
            ),
            const Heading(title: 'Details'),
            SliverToBoxAdapter(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(T(context).shape.large),
                child: Material(
                  color: T(context).color.surface,
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          showBottomSheetDialog(
                            context: context,
                            child: TextInputDialog(
                              title: 'Enter Bar Name',
                              initialValue: bar.name,
                              keyboardType: TextInputType.name,
                              onValueSubmit: (value) {
                                updateBar(bar.copyWith(
                                  name: value,
                                ));
                              },
                            ),
                          );
                        },
                        title: const Text('Name'),
                        trailing: Text(bar.name),
                      ),
                      ListTile(
                        onTap: () {
                          showBottomSheetDialog(
                            context: context,
                            child: TextInputDialog(
                              title: 'Weight',
                              initialValue: bar.weight.toString(),
                              onValueSubmit: (value) {
                                updateBar(bar.copyWith(
                                  weight: double.parse(value),
                                ));
                              },
                            ),
                          );
                        },
                        title: const Text('Weight'),
                        trailing: Text(s(context).parseWeight(bar.weight)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
