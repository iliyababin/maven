import 'package:Maven/common/model/template.dart';
import 'package:Maven/widget/custom_app_bar.dart';
import 'package:Maven/widget/custom_scaffold.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/template/template_bloc.dart';

class ReorderTemplateScreen extends StatefulWidget {
  const ReorderTemplateScreen({Key? key}) : super(key: key);

  @override
  State<ReorderTemplateScreen> createState() => _ReorderTemplateScreenState();
}

class _ReorderTemplateScreenState extends State<ReorderTemplateScreen> {

  late List<DragAndDropList> lists;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.build(
      context: context,
      appBar: CustomAppBar.build(
          title: "Reorder",
          context: context
      ),
      body: Text('hey')
    );
  }

  DragHandle _buildDragHandle({bool isList = false}) {
    final verticalAlignment = isList
        ? DragHandleVerticalAlignment.top
        : DragHandleVerticalAlignment.center;
    final color = isList ? Colors.blueGrey : Colors.black26;

    return DragHandle(
      verticalAlignment: verticalAlignment,
      child: Container(
        padding: EdgeInsets.only(right: 10),
        child: Icon(Icons.menu, color: color),
      ),
    );
  }

  void _onReorderListItem(
      int oldItemIndex,
      int oldListIndex,
      int newItemIndex,
      int newListIndex,
      List<Template> templates,
      BuildContext context
      ) {
    print("reordering");
    setState(() {
      final oldListItems = lists[oldListIndex].children;
      final newListItems = lists[newListIndex].children;

      final movedItem = oldListItems.removeAt(oldItemIndex);
      newListItems.insert(newItemIndex, movedItem);

      List<Template> eh = templates;

      final movedTemplate = eh.removeAt(oldItemIndex);
      eh.insert(newItemIndex, movedTemplate);

      context.read<TemplateBloc>().add(TemplateReorder(
        templates: templates
      ));
    });
    print("finfished");
  }

  void _onReorderList(
      int oldListIndex,
      int newListIndex,
      ) {
    setState(() {
      final movedList = lists.removeAt(oldListIndex);
      lists.insert(newListIndex, movedList);
    });
  }
}
