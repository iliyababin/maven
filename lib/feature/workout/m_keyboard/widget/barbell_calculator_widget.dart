import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dao/plate_dao.dart';
import '../model/plate.dart';
import '../service/barbell_calculator.dart';

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
          width: 20,
          height: 16,
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
            width: 4,
            height: 20,
            color: Color(0xFF4e5967),
          ));

        }

        ui.add(Container(
          width: 80,
        ));


        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: [

                  Text(
                    'Plate Calculator',
                    style: TextStyle(
                      color: mt(context).text.primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w900
                    ),
                  ),

                  SizedBox(height: 5,),

                  Text(
                    'Target Weight: ${weight.toString()}',
                    style: TextStyle(
                        color: mt(context).text.secondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),
                  ),

                ],
              ),
            ),

            Container(
              height: 2,
              color: mt(context).borderColor,
            ),

            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ui,
                ),
              ),
            ),

            Container(
              height: 2,
              color: mt(context).borderColor,
            ),

            Container(
              height: 50,
            )
          ],
        );

      },
    );
  }
}
