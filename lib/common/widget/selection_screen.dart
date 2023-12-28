import 'package:flutter/material.dart';

import '../../feature/theme/theme.dart';

/// A screen that displays a list of items for selection.
///
/// This screen provides a search functionality to filter the list of items based on a query.
/// It displays an app bar with a title and optional actions, including a search icon to enable filtering.
/// The items are displayed in a scrollable list view, and a custom item builder is used to render each item.
///
/// The `Type` type parameter represents the type of items in the list.
class SearchableSelectionScreen<Type> extends StatefulWidget {
  /// Creates a selection screen.
  const SearchableSelectionScreen({
    Key? key,
    required this.title,
    required this.items,
    required this.itemBuilder,
    this.selectionEnabled = false,
    this.actions = const [],
    this.selectedActionText = 'Delete',
    this.onSelected,
    this.floatingActionButton,
  }) : super(key: key);

  /// The title to be displayed in the app bar.
  final String title;

  /// The list of items to be displayed for selection.
  final List<Type> items;

  /// A callback function that takes a [BuildContext] and an item of type [T],
  /// and returns a widget that represents the item in the list.
  final Widget Function(BuildContext context, Type item, bool isSelected) itemBuilder;

  /// Whether to enable selection of items.
  final bool selectionEnabled;

  /// The additional actions to be displayed in the app bar.
  final List<Widget> actions;

  /// The text to be displayed in the app bar when items are selected.
  final String selectedActionText;

  /// Returns the selected items.
  final Function(List<Type> items)? onSelected;

  /// The floating action button to be displayed in the screen.
  final Widget? floatingActionButton;

  @override
  State<SearchableSelectionScreen<Type>> createState() => _SearchableSelectionScreenState<Type>();
}

class _SearchableSelectionScreenState<Type> extends State<SearchableSelectionScreen<Type>> {
  final FocusNode searchNode = FocusNode();

  bool isSelecting = false;

  bool typing = false;

  String query = '';

  List<Type> selectedItems = [];

  @override
  void dispose() {
    searchNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Type> items = widget.items.where((item) => item.toString().toLowerCase().contains(query.toLowerCase())).toList();
    return Scaffold(
      floatingActionButton: widget.floatingActionButton,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: typing
                ? TextField(
                    focusNode: searchNode,
                    onChanged: (value) {
                      setState(() {
                        query = value;
                      });
                    },
              decoration: const InputDecoration(
                hintText: 'Search',
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            )
                : Text(
              widget.title,
            ),
            floating: true,
            actions: [
              !isSelecting
                  ? typing
                  ? IconButton(
                onPressed: () {
                  setState(() {
                    searchNode.unfocus();
                    query = '';
                    typing = false;
                  });
                },
                icon: const Icon(
                  Icons.close,
                ),
              )
                  : IconButton(
                onPressed: () {
                  setState(() {
                    searchNode.requestFocus();
                    typing = true;
                  });
                },
                icon: const Icon(
                  Icons.search,
                ),
              )
                  : Container(),
              if(!isSelecting)
                ...widget.actions,
              if(widget.onSelected != null && isSelecting)
                TextButton(
                  onPressed: () {
                    setState(() {
                      widget.onSelected!(selectedItems);
                      selectedItems.clear();
                      isSelecting = false;
                    });
                  },
                  child: Text(
                    widget.selectedActionText,
                    style: T(context).textStyle.labelMedium.copyWith(
                      color: T(context).color.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: items.length,
              (context, index) {
                Type item = items[index];
                return InkWell(
                  onTap: widget.onSelected == null ? null : () {
                    if (isSelecting) {
                      setState(() {
                        if (!selectedItems.remove(item)) {
                          selectedItems.add(item);
                        }

                        if (selectedItems.isNotEmpty) {
                          isSelecting = true;
                        } else {
                          isSelecting = false;
                        }
                      });
                    }
                  },
                  onLongPress: widget.selectionEnabled ? widget.onSelected == null ? null : () {
                    setState(() {
                      if (!selectedItems.remove(item)) {
                        selectedItems.add(item);
                      }

                      if (selectedItems.isNotEmpty) {
                        isSelecting = true;
                      } else {
                        isSelecting = false;
                      }
                    });
                  } : null,
                  child: IgnorePointer(
                    ignoring: isSelecting,
                    child: widget.itemBuilder(
                      context,
                      item,
                      selectedItems.contains(item),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
