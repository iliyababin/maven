import 'package:Maven/feature/workout/barbell_calculator/service/barbell_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dao/plate_dao.dart';
import '../model/plate.dart';

class BarbellCalculatorWidget extends StatelessWidget {
  const BarbellCalculatorWidget({Key? key,
    required this.weight,
  }) : super(key: key);

  final double weight;

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: getPlatesFromWeight(context.read<PlateDao>(), weight),
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Plate> plates = snapshot.data!;

        List<Widget> ui = [];

        ui.add(Container(
          width: 30,
          height: 20,
          color: Color(0xFF4e5967),
        ));

        ui.add(Container(
          width: 10,
          height: 30,
          color: Color(0xFF4e5967),
        ));

        ui.add(Container(
          width: 2,
          height: 20,
          color: Color(0xFF4e5967),
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
                plate.weightLb.toStringAsFixed(plate.weightLb.truncateToDouble() == plate.weightLb ? 0 : 1),
                style: const TextStyle(
                  color: Colors.white
                ),
              ),
            ),
          ));

          ui.add(Container(
            width: 3,
            height: 20,
            color: Color(0xFF4e5967),
          ));
        }



        return Row(
          children: ui,
        );

      },
    );
  }
}
