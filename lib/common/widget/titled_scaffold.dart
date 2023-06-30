import 'package:flutter/material.dart';

import '../../theme/theme.dart';


class TitledScaffold extends StatelessWidget {
  const TitledScaffold({Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsetsDirectional.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: T(context).textStyle.headingLarge,
              ),
              /*IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.settings,
                  color: T(context).color.onBackground,
                ),
              ),*/
            ],
          ),
        ),
        backgroundColor: T(context).color.background,
        centerTitle: false,
        toolbarHeight: 100,
      ),
      body: body,
    );
  }
}
