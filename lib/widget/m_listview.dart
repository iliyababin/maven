import 'package:flutter/cupertino.dart';

/// ListView widget with an option for widgets above and below it.
/// Intended to be used when you have different widgets in one listview.
/// Removes the need of shrinkwrap, which impacts performance heavily.
class MListView {
  static ListView build({
    required List<Widget> children,
    Widget? header,
    Widget? footer
  }){
    if(header == null && footer == null) {
      return ListView.builder(
        itemCount: children.length,
        itemBuilder: (context, index) {
          return children[index];
        },
      );
    } else if (header != null && footer != null) {
      return ListView.builder(
        itemCount: children.length + 2,
        itemBuilder: (context, index) {
          int newIndex = index - 1;

          if(newIndex == -1) {
            return header;
          } else if (newIndex == children.length){
            return footer;
          } else {
            return children[newIndex];
          }
        },
      );
    } else if (header != null) {
      return ListView.builder(
        itemCount: children.length + 1,
        itemBuilder: (context, index) {
          int newIndex = index - 1;

          if(newIndex == -1) {
            return header;
          } else {
            return children[newIndex];
          }
        },
      );
    } else if (footer != null){
      return ListView.builder(
        itemCount: children.length + 1,
        itemBuilder: (context, index) {

          if(index == children.length) {
            return footer;
          } else {
            return children[index];
          }
        },
      );
    } else {
      Exception('something terrible happened');
      return ListView(children: [],);
    }
  }
}
