import 'package:flutter/material.dart';

import '../../../theme/widget/inherited_theme_widget.dart';
import 'bar_screen.dart';
import 'plate_screen.dart';

class EquipmentScreen extends StatelessWidget {
  const EquipmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Equipment',
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
              style: T(context).textStyle.body1,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const BarScreen()));
            },
            title: Text(
              'Bars',
              style: T(context).textStyle.body1,
            ),
          ),
          ListTile(
            onTap: () {},
            title: Text(
              'Machines',
              style: T(context).textStyle.body1,
            ),
          ),
        ],
      ),
    );
  }
}
