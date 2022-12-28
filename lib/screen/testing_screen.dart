import 'package:flutter/material.dart';

class TestingScreen extends StatelessWidget {
  const TestingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {},
          children: [
            ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text('Item 1'),
                );
              },
              body: ListTile(
                title: Text('Item 1 child'),
                subtitle: Text('Details goes here'),
              ),
              isExpanded: true,
            ),
            ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text('Item 2'),
                );
              },
              body: ListTile(
                title: Text('Item 2 child'),
                subtitle: Text('Details goes here'),
              ),
              isExpanded: false,
            ),
          ],
        ),
      ),
    );
  }
}
