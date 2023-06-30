import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../../theme/theme.dart';
import '../../equipment/equipment.dart';

class BarbellCalculatorWidget extends StatelessWidget {
  const BarbellCalculatorWidget({Key? key,
    required this.barId,
    required this.weight,
  }) : super(key: key);

  final int barId;
  final double weight;


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EquipmentBloc, EquipmentState>(
      builder: (context, state) {
        if(state.status == EquipmentStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          print('bbuilding with bar id');
          final double barWeight = state.bars.firstWhere((bar) => bar.id == barId).weight;
          print(barWeight);

        List<Plate> plates = EquipmentService.getPlatesFromWeight(state.plates, (weight - barWeight) / 2);

          double possibleWeight = 0;
          plates.forEach((plate) { possibleWeight += plate.weight; });
          possibleWeight = possibleWeight * 2 + barWeight;


          List<Widget> ui = [];

          ui.add(Container(
            width: 40,
            height: 20,
            color: const Color(0xFF4e5967),
            alignment: Alignment.center,
            child: Text(
              removeDecimalZeroFormat(barWeight),
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
            width: 2,
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
                  style: const TextStyle(
                      color: Colors.white
                  ),
                ),
              ),
            ));

            ui.add(Container(
              width: 2,
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
                padding: const EdgeInsets.only(left: 20, right: 15, top: 20, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Plate Calculator',
                      style: TextStyle(
                        color: T(context).color.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Target: ${weight.toString()} | Possible: $possibleWeight ',
                      style: T(context).textStyle.bodyMedium,
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: T(context).color.outline,
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
                height: 1,
                color: T(context).color.outline,
              ),
              MButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EquipmentScreen()));
                },
                width: 50,
                borderRadius: 0,
                leading: const Icon(
                  Icons.settings,
                ),
              ),
            ],
          );
        }
      }
    );
  }
}
