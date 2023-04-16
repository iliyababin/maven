

import 'package:Maven/feature/template/widget/template_card_widget.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../../common/dialog/show_bottom_sheet_dialog.dart';
import '../../../common/widget/m_button.dart';
import '../../../theme/m_themes.dart';
import '../../template/model/template.dart';
import '../model/folder.dart';

class FolderWidget extends StatefulWidget {
  const FolderWidget({Key? key,
    required this.folder,
    required this.templates,
  }) : super(key: key);

  final Folder folder;
  final List<Template> templates;

  @override
  State<FolderWidget> createState() => _FolderWidgetState();
}

class _FolderWidgetState extends State<FolderWidget> {
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
   /* if(widget.templateFolder.expanded == true){
      _expandedController.toggle();
    }
    super.initState();
    _expandedController.addListener(() async {
      context.read<TemplateFolderBloc>().add(TemplateFolderToggle(
        templateFolder: widget.templateFolder.copyWith(expanded: _expandedController.expanded),
      ));
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_borderRadius),
        border: Border.all(
          width: 1,
          color: mt(context).color.secondary,
        ),
      ),
      child: Material(
        color: mt(context).color.background,
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
                  iconColor: mt(context).color.primary,
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
                          widget.folder.name,
                          style: mt(context).textStyle.heading3,
                        ),
                        MButton(
                          onPressed: (){
                            showBottomSheetDialog(
                              context: context,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: const [
                                  SizedBox(height: 6),
                                  /*MButton.tiled(
                                    onPressed: (){
                                      showBottomSheetDialog(
                                          context: context,
                                          child: TextInputDialog(
                                            title: 'Enter a Folder Name',
                                            initialValue: widget.templateFolder.name,
                                            keyboardType: TextInputType.name,
                                            onValueSubmit: (value) {
                                              context.read<TemplateFolderBloc>().add(TemplateFolderUpdate(
                                                templateFolder: widget.templateFolder.copyWith(name: value),
                                              ));
                                            },
                                          ),
                                          onClose: (){
                                            Navigator.pop(context);
                                          }
                                      );
                                    },
                                    leading: Icon(
                                      Icons.edit_rounded,
                                      color: mt(context).icon.accentColor,
                                      size: 24,
                                    ),
                                    child: Text(
                                      'Rename',
                                      style: TextStyle(
                                          color: mt(context).text.primaryColor,
                                          fontSize: 17
                                      ),
                                    ),
                                  ),
                                  MButton.tiled(
                                    // TODO: Implement a way to share
                                    onPressed: (){},
                                    leading: Icon(
                                      Icons.share_rounded,
                                      color: mt(context).icon.accentColor,
                                      size: 24,
                                    ),
                                    child: Text(
                                      'Share',
                                      style: TextStyle(
                                        color: mt(context).text.primaryColor,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  MButton.tiled(
                                    onPressed: (){
                                      showBottomSheetDialog(
                                        context: context,
                                        child: ConfirmationDialog(
                                          title: 'Delete Folder',
                                          subtitle: 'This will also delete all the templates inside',
                                          confirmText: 'Delete',
                                          submitColor: mt(context).text.errorColor,
                                          onSubmit: () {
                                            context.read<TemplateFolderBloc>().add(TemplateFolderDelete(
                                              templateFolder: widget.templateFolder,
                                            ));
                                          },
                                        ),
                                        onClose: (){
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                    leading: Icon(
                                      Icons.delete_rounded,
                                      color: mt(context).icon.errorColor,
                                      size: 24,
                                    ),
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                          color: mt(context).text.errorColor,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),*/
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
                          ),
                        ),
                      ],
                    )
                ),
                collapsed: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 18),
                  child: Text(
                    '0/7 complete',
                    style: mt(context).textStyle.subtitle1,
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
                        padding: EdgeInsetsDirectional.only(bottom: 12),
                        child: TemplateCard(
                          template: template,
                        ),
                      );
                    }).toList(),
                    onReorder: (oldIndex, newIndex) {
                      setState(() {
                        if (newIndex > oldIndex) {
                          newIndex -= 1;
                        }
                       /* List<Template> templates = widget.templates;

                        final Template item = templates.elementAt(oldIndex);
                        templates.removeAt(oldIndex);
                        templates.insert(newIndex, item);

                        context.read<TemplateBloc>().add(TemplateReorder(
                            templates: templates
                        ));*/
                      });
                    },
                  ),
                ) : Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      const Icon(
                        Icons.folder_copy_rounded,
                        size: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        child: Text(
                          'This folder is empty.',
                          textAlign: TextAlign.center,
                          style: mt(context).textStyle.subtitle1,
                        ),
                      ),
                      const SizedBox(height: 40)
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
}
