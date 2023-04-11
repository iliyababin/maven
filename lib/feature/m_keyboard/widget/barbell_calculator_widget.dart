import 'package:Maven/common/util/general_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../theme/m_themes.dart';
import '../../../common/widget/m_button.dart';
import '../../equipment/bloc/equipment/equipment_bloc.dart';
import '../../equipment/model/plate.dart';
import '../../equipment/screen/equipment_screen.dart';
import '../../equipment/service/equipment_service.dart';

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
          final double barWeight = state.bars.firstWhere((bar) => bar.barId == barId).weight;
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
                color: mt(context).color.neutral,
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
                        color: mt(context).color.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Target: ${weight.toString()} | Possible: $possibleWeight ',
                      style: mt(context).textStyle.subtitle1,
                    ),
                  ],
                ),
              ),
              Container(
                height: 2,
                color: mt(context).color.secondary,
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
                color: mt(context).color.secondary,
              ),
              MButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EquipmentScreen()));
                },
                width: 50,
                borderRadius: 0,
                leading: Icon(
                  Icons.settings,
                  color: mt(context).icon.accentColor,
                ),
              ),
            ],
          );
        }
      }
    );
  }
}
