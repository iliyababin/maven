import 'package:Maven/common/model/template.dart';
import 'package:Maven/common/model/workout_folder.dart';
import 'package:Maven/theme/m_themes.dart';
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

  late List<DragAndDropList> _lists;
  bool _collapseFolders = false;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.build(
      context: context,
      appBar: CustomAppBar.build(
        title: "Manage",
        context: context,
        actions: [

          IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 125),
              transitionBuilder: (child, anim) => RotationTransition(
                turns: child.key == const ValueKey('icon1')
                    ? Tween<double>(begin: 1, end: 0.5).animate(anim)
                    : Tween<double>(begin: 0.5, end: 1).animate(anim),
                child: FadeTransition(opacity: anim, child: child),
              ),
              child: _collapseFolders ? Icon(
                key: const Key('icon1'),
                Icons.unfold_more_rounded,
                color: mt(context).icon.accentColor,
              ) : Icon(
                key: UniqueKey(),
                Icons.unfold_less_rounded,
                color: mt(context).icon.accentColor,
              )
            ),
            onPressed: () {
              setState(() {
                _collapseFolders = !_collapseFolders;
              });
            },
          )

        ]
      ),
      body: BlocBuilder<TemplateBloc, TemplateState>(
        builder: (context, state) {
          if(state.status == TemplateStatus.loading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == TemplateStatus.success || state.status == TemplateStatus.reordering) {
            List<TemplateFolder> templateFolders = state.templateFolders;
            List<Template> templates = state.templates;

            _generateLists(templateFolders, templates);

            return DragAndDropLists(
              listGhostOpacity: 0,
              itemGhostOpacity: 0,
              itemDragOnLongPress: false,
              constrainDraggingAxis: false,
              itemDivider: const SizedBox(height: 8),
              listPadding: const EdgeInsets.only(top: 15, bottom: 0, left: 15, right: 15),
              lastListTargetSize: 100,
              onItemReorder: (oldItemIndex, oldListIndex, newItemIndex, newListIndex) => _onReorderListItem(oldItemIndex, oldListIndex, newItemIndex, newListIndex,),
              onListReorder: (oldListIndex, newListIndex) => _onReorderList(oldListIndex, newListIndex, templateFolders),
              children: _lists,
              itemDecorationWhileDragging: BoxDecoration(
                color: mt(context).backgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                    color: mt(context).bottomNavigationBar.shadowColor,
                    blurRadius: 4,
                  )
                ],
              ),
              listDecorationWhileDragging: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(color: mt(context).bottomNavigationBar.shadowColor, blurRadius: 4)
                ],
              ),
              listDecoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(8),
                border: Border.all(
                  color: mt(context).borderColor,
                  width: 1
                ),
                color: mt(context).backgroundColor
              ),
              itemDragHandle: DragHandle(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.drag_indicator_rounded,
                    color: mt(context).icon.secondaryColor,
                  ),
                ),
              ),
              listDragHandle: DragHandle(
                verticalAlignment: DragHandleVerticalAlignment.top ,
                child: Padding(

                  padding: const EdgeInsets.only(top: 15, right: 15),
                  child: Icon(
                    Icons.drag_indicator_rounded,
                    color: mt(context).icon.accentColor,
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: Text('There was an error.'),);
          }
        },
      ),
    );
  }

  void _onReorderListItem(
      int oldItemIndex,
      int oldListIndex,
      int newItemIndex,
      int newListIndex,
  ) {
    setState(() {
      final rd = _lists[oldListIndex].children.removeAt(oldItemIndex);
      _lists[newListIndex].children.insert(newItemIndex, rd);
    });

    context.read<TemplateBloc>().add(TemplateMoveToFolder(
      oldTemplateIndex: oldItemIndex,
      oldTemplateFolderIndex: oldListIndex,
      newTemplateIndex: newItemIndex,
      newTemplateFolderIndex: newListIndex
    ));
  }



  void _onReorderList(
    int oldListIndex,
    int newListIndex,
    List<TemplateFolder> templateFolders
  ) {
    setState(() {
      final removedList = _lists.removeAt(oldListIndex);
      _lists.insert(newListIndex, removedList);
    });
    final movedList = templateFolders.removeAt(oldListIndex);
    templateFolders.insert(newListIndex, movedList);
    context.read<TemplateBloc>().add(TemplateFolderReorder(templateFolders: templateFolders));
  }

  void _generateLists(
    List<TemplateFolder> templateFolders,
    List<Template> templates,
  ) {
    _lists = templateFolders.map((templateFolder) {
      return DragAndDropList(
        canDrag: true,
        leftSide: const Padding(padding: EdgeInsetsDirectional.only(start: 15)),
        rightSide: const Padding(padding: EdgeInsetsDirectional.only(end: 15)),
        header: Container(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [

              Text(
                templateFolder.name,
                style: TextStyle(
                    color: mt(context).text.primaryColor,
                    fontSize: 18.5,
                    fontWeight: FontWeight.w700
                ),
              ),
            ],
          ),
        ),
        contentsWhenEmpty: Stack(
          children: [
            !_collapseFolders ? Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                'This folder is empty.',
                textAlign: TextAlign.center,

                style: TextStyle(
                    color: mt(context).text.secondaryColor
                ),
              ),
            ) : Container()
          ],
        ),
        lastTarget: !_collapseFolders ? const SizedBox(height: 30) : const SizedBox(height: 0),
        children: !_collapseFolders ? templates.where((template) => template.templateFolderId == templateFolder.templateFolderId).map((template) => DragAndDropItem(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsetsDirectional.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(10),
              border: Border.all(
                  color: mt(context).borderColor,
                  width: 1
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  template.name,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: mt(context).text.primaryColor
                  ),
                ),
              ],
            ),
          ),
        )).toList() : [],
      );
    }).toList();
  }

}
