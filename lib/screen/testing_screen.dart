import 'package:flutter/material.dart';

class TestingScreen extends StatefulWidget {
  const TestingScreen({Key? key}) : super(key: key);

  @override
  State<TestingScreen> createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {

  bool reordering = false;

  final List<int> _items = List<int>.generate(50, (int index) => index);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Color.fromARGB(255, 243, 242, 248);


    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("ass"),
        centerTitle: true,
      ),
      body: ReorderableListView(
        buildDefaultDragHandles: false,
        children: <Widget>[
          for (int index = 0; index < _items.length; index++)
            Container(
              key: Key('$index'),
              color: _items[index].isOdd ? Colors.red : Colors.green,
              child: GestureDetector(
                onLongPress: () {
                  print('hey');
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 64,
                      height: 64,
                      padding: const EdgeInsets.all(8),
                      child: ReorderableDragStartListener(
                        index: index,
                        child: Card(
                          color: Colors.black,
                          elevation: 2,
                        ),
                      ),
                    ),
                    Text('Item ${_items[index]}'),
                  ],
                ),
              ),
            ),
        ],
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final int item = _items.removeAt(oldIndex);
            _items.insert(newIndex, item);
          });
        },
      )
    );
  }
}