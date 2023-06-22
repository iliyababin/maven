

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:maven/feature/template/widget/template_widget.dart';

import '../../../database/TEST_ZONE/folder.dart';
import '../../../database/model/template.dart';
import '../../../theme/widget/inherited_theme_widget.dart';

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

  late int _completedAmount;

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
    //_completedAmount = widget.templates.where((element) => element.templateTracker?.completed == true).length;
    if(_completedAmount != widget.templates.length) {
      _expandedController.toggle();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_borderRadius),
        border: Border.all(
          width: 1,
          color: T(context).color.secondary,
        ),
      ),
      child: Material(
        color: T(context).color.background,
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
                  iconColor: T(context).color.primary,
                  iconPlacement: ExpandablePanelIconPlacement.right,
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  iconPadding: const EdgeInsets.fromLTRB(0, 12, 12, 8),
                  inkWellBorderRadius: BorderRadius.circular(_borderRadius),
                  iconSize: 30,
                  useInkWell: false,
                ),
                header: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_borderRadius),
                    ),
                    padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.folder.name,
                          style: T(context).textStyle.titleLarge,
                        ),
                      ],
                    )
                ),
                collapsed: /*Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 18),
                  child: Text(
                    '$_completedAmount / ${widget.templates.length}',
                    style: T(context).textStyle.subtitle1,
                  ),
                )*/ Container(),
                expanded: widget.templates.isNotEmpty ? Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: widget.templates.length,
                    itemBuilder: (context, index) {
                      return TemplateWidget(
                        template: widget.templates[index],
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
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
                          style: T(context).textStyle.subtitle1,
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
