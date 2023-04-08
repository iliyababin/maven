import 'package:flutter/material.dart';

import '../../../theme/m_themes.dart';
import 'bar_screen.dart';
import 'plate_screen.dart';

class EquipmentScreen extends StatelessWidget {
  const EquipmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Equipment',
          style: TextStyle(
            color: mt(context).text.primaryColor,
          ),
        ),
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
                color: mt(context).text.primaryColor,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const BarScreen()));
            },
            title: Text(
              'Bars',
              style: TextStyle(
                color: mt(context).text.primaryColor,
              ),
            ),
          ),
          ListTile(
            onTap: () {},
            title: Text(
              'Machines',
              style: TextStyle(
                color: mt(context).text.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
