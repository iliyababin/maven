import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

class ReorderSliverList extends StatefulWidget {
  const ReorderSliverList({Key? key,
    required this.children,
    required this.itemBuilder,
    required this.onReorder,
  }) : super(key: key);

  final List children;
  final IndexedWidgetBuilder itemBuilder;
  final Function(int oldIndex, int newIndex) onReorder;

  @override
  State<ReorderSliverList> createState() => _ReorderSliverListState();
}

class _ReorderSliverListState extends State<ReorderSliverList> {
  @override
  Widget build(BuildContext context) {
    return ReorderableSliverList(
      buildDraggableFeedback: (context, constraints, child) {
        return Container(
          constraints: constraints,
          child: child,
        );
      },
      delegate: ReorderableSliverChildBuilderDelegate(
        childCount: widget.children.length,
          (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsetsDirectional.only(bottom: index == widget.children.length - 1 ? 0 : 12),
            child: widget.itemBuilder(context, index),
          );
        },
      ),
      onReorder: (oldIndex, newIndex) {
        widget.onReorder(oldIndex, newIndex);
      },
    );
  }
}
