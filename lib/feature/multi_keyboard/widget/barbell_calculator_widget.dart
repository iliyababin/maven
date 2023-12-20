import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../equipment/equipment.dart';
import '../../theme/theme.dart';

class BarbellCalculatorWidget extends StatefulWidget {
  const BarbellCalculatorWidget({
    Key? key,
    this.barId,
    required this.target,
    required this.onWeightChanged,
  }) : super(key: key);

  final int? barId;
  final String target;
  final Function(double weight) onWeightChanged;

  @override
  State<BarbellCalculatorWidget> createState() => _BarbellCalculatorWidgetState();
}

class _BarbellCalculatorWidgetState extends State<BarbellCalculatorWidget> {
  Widget buildActionChip(double value) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: T(context).color.surface),
      child: ActionChip(
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(T(context).shape.large),
        ),
        onPressed: () {
          widget.onWeightChanged(value);
        },
        label: Text(
          '${value.isNegative ? '-' : '+'} ${value.abs().truncateZeros}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EquipmentBloc, EquipmentState>(builder: (context, state) {
      if (state.status.isLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state.status.isLoaded) {
        double weight;
        try {
          weight = double.parse(widget.target);
        } catch (e) {
          weight = 0;
        }

        final double barWeight = state.bars.firstWhere(
          (bar) => bar.id == widget.barId,
          orElse: () {
            return state.bars.first;
          },
        ).weight;

        List<Plate> plates =
            EquipmentService.getPlatesByWeight(state.plates, (weight - barWeight) / 2);

        double possibleWeight = 0;
        for (var plate in plates) {
          possibleWeight += plate.weight;
        }
        possibleWeight = possibleWeight * 2 + barWeight;

        List<Widget> ui = [];

        ui.add(Container(
          width: 40,
          height: 20,
          color: T(context).color.inverseSurface,
          alignment: Alignment.center,
          child: Text(
            barWeight.truncateZeros,
            style: TextStyle(
              color: T(context).color.inverseSurface.computeLuminance() > 0.5 ? Colors.black : Colors.white,
            ),
          ),
        ));


        ui.add(Container(
          width: 10,
          height: 35,
          color: T(context).color.inverseSurface,
        ));

        ui.add(Container(
          width: 1,
          height: 20,
          color: T(context).color.inverseSurface,
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
                style: TextStyle(
                  color: plate.color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                ),
              ),
            ),
          ));

          ui.add(Container(
            width: 1,
            height: 20,
            color: T(context).color.inverseSurface,
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
                    'Target: ${weight.truncateZeros}',
                    style: T(context).textStyle.titleLarge,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ui,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: T(context).space.large,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: T(context).space.medium,
                  children: [
                    SizedBox(
                      width: T(context).space.medium,
                    ),
                    buildActionChip(2.5),
                    buildActionChip(5),
                    buildActionChip(10),
                    buildActionChip(-2.5),
                    buildActionChip(-5),
                    buildActionChip(-10),
                    SizedBox(
                      width: T(context).space.medium,
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
