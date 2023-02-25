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
  final TemplateFolder templateFolder;
  final List<Template> templates;

  const TemplateFolderWidget({Key? key,
    required this.templateFolder,
    required this.templates
  }) : super(key: key);

  @override
  State<TemplateFolderWidget> createState() => _TemplateFolderWidgetState();
}

class _TemplateFolderWidgetState extends State<TemplateFolderWidget> {
  final double borderRadius = 10;

  final ExpandableController _expandableController = ExpandableController();

  @override
  void initState() {
    if(widget.templateFolder.expanded == 1){
      _expandableController.toggle();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _expandableController.addListener(() async {
      TemplateFolder templateFolder = widget.templateFolder;
      TemplateFolder modifiedTemplateFolder = templateFolder.copyWith(expanded: _expandableController.expanded ? 1 : 0);

      context.read<TemplateBloc>().add(TemplateFolderUpdate(
          templateFolder: modifiedTemplateFolder
      ));
    });
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          width: 1,
          color: mt(context).templateFolder.borderColor,
        )
      ),
      child: Material(
        color: mt(context).templateFolder.backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: (){
            setState(() {
              if(!_expandableController.expanded) {
                _expandableController.toggle();
              }
            });
          },
          borderRadius: BorderRadius.circular(borderRadius),
          child: ExpandableNotifier(
            controller: _expandableController,
            child: ScrollOnExpand(
              child: ExpandablePanel(
                controller: _expandableController,
                theme: ExpandableThemeData(
                  iconColor: mt(context).accentColor,
                  iconPlacement: ExpandablePanelIconPlacement.right,
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  iconPadding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
                  inkWellBorderRadius: BorderRadius.circular(borderRadius),
                  iconSize: 30,
                  useInkWell: false,
                  
                ),
                header: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
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
                      SizedBox(
                        width: 40,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(borderRadius),
                          child : Material(
                            color: Colors.transparent,
                            child : InkWell(
                              child : Padding(
                                padding : const EdgeInsets.all(5),
                                child : Icon(
                                  Icons.more_horiz,
                                  color: mt(context).icon.accentColor,
                                ),
                              ),
                              onTap : () {
                              },
                            ),
                          ),
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

  ///
  /// Widgets
  ///

  /// Creates a shadow underneath item when reordering.
  /// Accounts for padding.
  ///
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
                  borderRadius: BorderRadius.circular(borderRadius),
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
}
