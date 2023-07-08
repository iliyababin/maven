import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../../theme/theme.dart';
import '../../equipment/equipment.dart';

class BarbellCalculatorWidget extends StatelessWidget {
  const BarbellCalculatorWidget({
    Key? key,
    required this.barId,
    required this.target,
    required this.onWeightChanged,
  }) : super(key: key);

  final int barId;
  final String target;
  final Function(double weight) onWeightChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EquipmentBloc, EquipmentState>(builder: (context, state) {
      if (state.status.isLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state.status.isLoaded) {
        double weight;
        try {
          weight = double.parse(target);
        } catch (e) {
          weight = 0;
        }

        final double barWeight = state.bars.firstWhere((bar) => bar.id == barId).weight;

        List<Plate> plates = EquipmentService.getPlatesFromWeight(state.plates, (weight - barWeight) / 2);

        double possibleWeight = 0;
        for (var plate in plates) {
          possibleWeight += plate.weight;
        }
        possibleWeight = possibleWeight * 2 + barWeight;

        List<Widget> ui = [];

        ui.add(Container(
          width: 40,
          height: 20,
          color: const Color(0xFF4e5967),
          alignment: Alignment.center,
          child: Text(
            barWeight.truncateZeros,
            style: TextStyle(
              color: T(context).color.onSurface,
            ),
          ),
        ));

        ui.add(Container(
          width: 10,
          height: 35,
          color: const Color(0xFF4e5967),
        ));

        ui.add(Container(
          width: 1,
          height: 20,
          color: const Color(0xFF4e5967),
        ));

        for (Plate plate in plates) {
          ui.add(Container(
            height: 125 * plate.height,
            width: 25,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: plate.color,
              borderRadius: BorderRadius.circular(4),
            ),
            child: RotatedBox(
              quarterTurns: 3,
              child: Text(
                plate.weight.toStringAsFixed(plate.weight.truncateToDouble() == plate.weight ? 0 : 1),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ));

          ui.add(Container(
            width: 1,
            height: 20,
            color: const Color(0xFF4e5967),
          ));
        }

        ui.add(Container(
          width: 80,
        ));

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(
                T(context).space.large,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Plate Calculator',
                    style: T(context).textStyle.titleLarge,
                  ),
                  Text(
                    'Target: ${weight.toString()} | Possible: $possibleWeight ',
                    style: T(context).textStyle.labelSmall,
                  ),
                ],
              ),
            ),
            Container(
              height: 175,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ui,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(
                T(context).space.large,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: T(context).space.medium,
                  children: [
                    ActionChip(
                      onPressed: () {
                        onWeightChanged(2.5);
                      },
                      label: const Text(
                        '+ 2.5',
                      ),
                    ),
                    ActionChip(
                      onPressed: () {
                        onWeightChanged(5);
                      },
                      label: const Text(
                        '+ 5',
                      ),
                    ),
                    ActionChip(
                      onPressed: () {
                        onWeightChanged(10);
                      },
                      label: const Text(
                        '+ 10',
                      ),
                    ),
                    ActionChip(
                      onPressed: () {
                        onWeightChanged(-2.5);
                      },
                      label: const Text(
                        '- 2.5',
                      ),
                    ),
                    ActionChip(
                      onPressed: () {
                        onWeightChanged(-5);
                      },
                      label: const Text(
                        '- 5',
                      ),
                    ),
                    ActionChip(
                      onPressed: () {
                        onWeightChanged(-10);
                      },
                      label: const Text(
                        '- 10',
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        );
      } else {
        return const Center(child: Text('Error'));
      }
    });
  }
}
