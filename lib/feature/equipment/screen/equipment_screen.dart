import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../database/database.dart';
import '../../../theme/widget/inherited_theme_widget.dart';
import '../bloc/equipment/equipment_bloc.dart';
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
      body: BlocBuilder<EquipmentBloc, EquipmentState>(
        builder: (context, state) {
          if(state.status == EquipmentStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final List<Plate> plates = state.plates;
            final List<Bar> bars = state.bars;
            return ListView(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PlateScreen()));
                  },
                  leading: const CircleAvatar(
                    child: Text(
                      'P',
                    ),
                  ),
                  title: Text(
                    'Plates',
                    style: T(context).textStyle.body1,
                  ),
                  subtitle: Text(
                    '${plates.length}',
                    style: T(context).textStyle.subtitle1,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const BarScreen()));
                  },
                  leading: const CircleAvatar(
                    child: Text(
                      'B',
                    ),
                  ),
                  title: Text(
                    'Bars',
                    style: T(context).textStyle.body1,
                  ),
                  subtitle: Text(
                    '${bars.length}',
                    style: T(context).textStyle.subtitle1,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: const CircleAvatar(
                    child: Text(
                      'M',
                    ),
                  ),
                  title: Text(
                    'Machines',
                    style: T(context).textStyle.body1,
                  ),
                  subtitle: Text(
                    '0',
                    style: T(context).textStyle.subtitle1,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
