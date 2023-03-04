import 'package:Maven/common/dialog/show_bottom_sheet_dialog.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/m_themes.dart';
import '../../../widget/m_flat_button.dart';
import '../bloc/template/template_bloc.dart';
import '../model/template.dart';
import '../model/template_folder.dart';
import 'template_card_widget.dart';

class TemplateFolderWidget extends StatefulWidget {
  const TemplateFolderWidget({Key? key,
    required this.templateFolder,
    required this.templates
  }) : super(key: key);

  final TemplateFolder templateFolder;
  final List<Template> templates;

  @override
  State<TemplateFolderWidget> createState() => _TemplateFolderWidgetState();
}

class _TemplateFolderWidgetState extends State<TemplateFolderWidget> {
  final ExpandableController _expandedController = ExpandableController();

  final double _borderRadius = 10;

  /// Creates a shadow underneath item when reordering.
  ///
  /// Accounts for padding.
  /// [Source](https://github.com/flutter/flutter/issues/76706#issuecomment-986181379)
  Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Material(
          elevation: 0,
          color: Colors.transparent,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 12,
                child: Material(
                  borderRadius: BorderRadius.circular(_borderRadius),
                  elevation: 5,
                  shadowColor: mt(context).templateFolder.dragShadowColor,
                ),
              ),
              child!,
            ],
          ),
        );
      },
      child: child,
    );
  }
  
  @override
  void initState() {
    if(widget.templateFolder.expanded == 1){
      _expandedController.toggle();
    }
    _expandedController.addListener(() async {
      TemplateFolder templateFolder = widget.templateFolder;
      TemplateFolder modifiedTemplateFolder = templateFolder.copyWith(expanded: _expandedController.expanded ? 1 : 0);
      context.read<TemplateBloc>().add(TemplateFolderToggle(
          templateFolder: modifiedTemplateFolder
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_borderRadius),
        border: Border.all(
          width: 1,
          color: mt(context).templateFolder.borderColor,
        ),
      ),
      child: Material(
        color: mt(context).templateFolder.backgroundColor,
        borderRadius: BorderRadius.circular(_borderRadius),
        child: InkWell(
          onTap: (){
            setState(() {
              if(!_expandedController.expanded) {
                _expandedController.toggle();
              }
            });
          },
          borderRadius: BorderRadius.circular(_borderRadius),
          child: ExpandableNotifier(
            controller: _expandedController,
            child: ScrollOnExpand(
              child: ExpandablePanel(
                controller: _expandedController,
                theme: ExpandableThemeData(
                  iconColor: mt(context).accentColor,
                  iconPlacement: ExpandablePanelIconPlacement.right,
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  iconPadding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
                  inkWellBorderRadius: BorderRadius.circular(_borderRadius),
                  iconSize: 30,
                  useInkWell: false,
                ),
                header: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_borderRadius),
                  ),
                  padding: const EdgeInsets.fromLTRB(15, 15, 0, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.templateFolder.name,
                        style: TextStyle(
                          color: mt(context).text.primaryColor,
                          fontSize: 18.5,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                      MFlatButton(
                        onPressed: (){
                          showBottomSheetDialog(
                            context: context,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                MFlatButton(
                                  onPressed: (){},
                                  height: 60,
                                  expand: false,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  width: double.infinity,
                                  borderRadius: 0,
                                  leading: Padding(
                                    padding: const EdgeInsets.only(left: 18, right: 16),
                                    child: Icon(
                                      Icons.edit_rounded,
                                      color: mt(context).icon.accentColor,
                                      size: 24,
                                    ),
                                  ),
                                  text: Text(
                                    'Rename Folder',
                                    style: TextStyle(
                                      color: mt(context).text.primaryColor,
                                      fontSize: 17
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onClose: (){},
                          );
                        },
                        height: 40,
                        width: 50,
                        borderRadius: _borderRadius,
                        backgroundColor: Colors.transparent,
                        leading: Icon(
                          Icons.more_horiz,
                          color: mt(context).icon.accentColor,
                        ),
                      ),
                    ],
                  )
                ),
                collapsed: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 18),
                  child: Text(
                    '${widget.templates.length.toString()} templates',
                    style: TextStyle(
                      color: mt(context).text.primaryColor,
                      fontSize: 16
                    ),
                  ),
                ),
                expanded: widget.templates.isNotEmpty ? Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 4),
                  child: ReorderableListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    proxyDecorator: proxyDecorator,
                    children: widget.templates.map((template) {
                      return Padding(
                        key: UniqueKey(),
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                        child: TemplateCard(
                          template: template,
                        ),
                      );
                    }).toList(),
                    onReorder: (oldIndex, newIndex) => _reorder(oldIndex, newIndex),
                  ),
                ) : Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      Icon(
                        Icons.folder_copy_rounded,
                        color: mt(context).icon.accentColor,
                        size: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        child: Text(
                          'This folder is empty.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: mt(context).text.secondaryColor
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            MFlatButton(
                              text: Text(
                                'Create New',
                                style: TextStyle(
                                  color: mt(context).text.primaryColor
                                ),
                              ),
                              borderColor: mt(context).borderColor,
                              backgroundColor: mt(context).templateFolder.backgroundColor,
                              onPressed: (){},
                            ),
                            const SizedBox(width: 16,),
                            MFlatButton(
                              text: Text(
                                'Move Existing',
                                style: TextStyle(
                                  color: mt(context).text.primaryColor
                                ),
                              ),
                              borderColor: mt(context).borderColor,
                              backgroundColor: mt(context).templateFolder.backgroundColor,
                              onPressed: (){},
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///
  /// Functions
  ///

  void _reorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      List<Template> templates = widget.templates;

      final Template item = templates.elementAt(oldIndex);
      templates.removeAt(oldIndex);
      templates.insert(newIndex, item);

      context.read<TemplateBloc>().add(TemplateReorder(
        templates: templates
      ));
    });
  }
  
  
}
