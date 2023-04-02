import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../../theme/m_themes.dart';

class FolderWidget extends StatefulWidget {
  const FolderWidget({Key? key,
    required this.title,
    this.subtitle = 'items',
    required this.children,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final List<Widget> children;

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
                          widget.title,
                          style: TextStyle(
                              color: mt(context).text.primaryColor,
                              fontSize: 18.5,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                        Container(height: 40,)
                      ],
                    )
                ),
                collapsed: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 18),
                  child: Text(
                    '${widget.children.length.toString()} ${widget.subtitle}',
                    style: TextStyle(
                        color: mt(context).text.primaryColor,
                        fontSize: 16
                    ),
                  ),
                ),
                expanded: widget.children.isNotEmpty ? Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 4),
                  child: ReorderableListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    proxyDecorator: proxyDecorator,
                    children: widget.children.map((child) {
                      return Padding(
                        key: UniqueKey(),
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                        child: Text('YOLO'),
                      );
                    }).toList(),
                    onReorder: (oldIndex, newIndex) {
                      setState(() {
                        if (newIndex > oldIndex) {
                          newIndex -= 1;
                        }
                        List<Widget> children = widget.children;

                        final Widget item = children.elementAt(oldIndex);
                        children.removeAt(oldIndex);
                        children.insert(newIndex, item);
                      });
                    },
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
