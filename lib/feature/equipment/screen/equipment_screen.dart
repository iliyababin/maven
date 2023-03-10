import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';

import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_scaffold.dart';
import 'plate_screen.dart';

class EquipmentScreen extends StatelessWidget {
  const EquipmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.build(
      context: context,
      appBar: CustomAppBar.build(
        context: context,
        title: 'Equipment'
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PlateScreen()));
            },
            title: Text(
              'Plates',
              style: TextStyle(
                color: mt(context).text.primaryColor
              ),
            ),
          ),
          ListTile(
            onTap: () {},
            title: Text(
              'Bars',
              style: TextStyle(
                  color: mt(context).text.primaryColor
              ),
            ),
          ),
          ListTile(
            onTap: () {},
            title: Text(
              'Machines',
              style: TextStyle(
                  color: mt(context).text.primaryColor
              ),
            ),
          ),
        ],
      )
    );
  }
}
