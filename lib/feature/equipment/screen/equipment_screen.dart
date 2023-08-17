import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../database/database.dart';
import '../../theme/theme.dart';
import '../equipment.dart';

class EquipmentScreen extends StatelessWidget {
  const EquipmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            leading: BackButton(),
            title: const Text(
              'Equipment',
            ),
            centerTitle: false,
          ),
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const PlateScreen()));
                      },
                      leading: const CircleAvatar(
                        child: Text(
                          'P',
                        ),
                      ),
                      title: Text(
                        'Plates',
                        style: T(context).textStyle.bodyLarge,
                      ),
                      subtitle: Text(
                        '${plates.length}',
                        style: T(context).textStyle.bodyMedium,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const BarScreen()));
                      },
                      leading: const CircleAvatar(
                        child: Text(
                          'B',
                        ),
                      ),
                      title: Text(
                        'Bars',
                        style: T(context).textStyle.bodyLarge,
                      ),
                      subtitle: Text(
                        '${bars.length}',
                        style: T(context).textStyle.bodyMedium,
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
                        style: T(context).textStyle.bodyLarge,
                      ),
                      subtitle: Text(
                        '0',
                        style: T(context).textStyle.bodyMedium,
                      ),
                    ),
                  ]),
                );
              }
            },
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Equipment',
        ),
      ),
      body: BlocBuilder<EquipmentBloc, EquipmentState>(
        builder: (context, state) {
          if (state.status == EquipmentStatus.loading) {
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const PlateScreen()));
                  },
                  leading: const CircleAvatar(
                    child: Text(
                      'P',
                    ),
                  ),
                  title: Text(
                    'Plates',
                    style: T(context).textStyle.bodyLarge,
                  ),
                  subtitle: Text(
                    '${plates.length}',
                    style: T(context).textStyle.bodyMedium,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const BarScreen()));
                  },
                  leading: const CircleAvatar(
                    child: Text(
                      'B',
                    ),
                  ),
                  title: Text(
                    'Bars',
                    style: T(context).textStyle.bodyLarge,
                  ),
                  subtitle: Text(
                    '${bars.length}',
                    style: T(context).textStyle.bodyMedium,
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
                    style: T(context).textStyle.bodyLarge,
                  ),
                  subtitle: Text(
                    '0',
                    style: T(context).textStyle.bodyMedium,
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
