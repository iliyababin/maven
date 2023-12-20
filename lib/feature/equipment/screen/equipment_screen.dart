import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../database/database.dart';
import '../equipment.dart';

class EquipmentScreen extends StatelessWidget {
  const EquipmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Equipment',
      )),
      body: CustomScrollView(
        slivers: [
          BlocBuilder<EquipmentBloc, EquipmentState>(
            builder: (context, state) {
              if (state.status == EquipmentStatus.loading) {
                return const SliverFillRemaining(
                  child: CircularProgressIndicator(),
                );
              } else {
                final List<Plate> plates = state.plates;
                final List<Bar> bars = state.bars;
                return SliverList(
                  delegate: SliverChildListDelegate([
                    ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) => const PlateScreen()));
                      },
                      leading: const CircleAvatar(
                        child: Text('P'),
                      ),
                      title: const Text('Plates'),
                      subtitle: Text('${plates.length}'),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) => const BarScreen()));
                      },
                      leading: const CircleAvatar(
                        child: Text('B'),
                      ),
                      title: const Text('Bars'),
                      subtitle: Text('${bars.length}'),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: const CircleAvatar(
                        child: Text('M'),
                      ),
                      title: const Text('Machines'),
                      subtitle: const Text('0'),
                    ),
                  ]),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
