import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../theme/m_themes.dart';
import '../../../common/widget/m_button.dart';
import '../../equipment/bloc/plate/plate_bloc.dart';
import '../../equipment/model/plate.dart';
import '../../equipment/screen/equipment_screen.dart';
import '../../equipment/service/equipment_service.dart';

class BarbellCalculatorWidget extends StatelessWidget {
  const BarbellCalculatorWidget({Key? key,
    required this.weight,
  }) : super(key: key);

  final double weight;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlateBloc, PlateState>(
      builder: (context, state) {
        if(state.status == PlateStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          List<Plate> plates = EquipmentService.getPlatesFromWeight(state.plates, weight);
          double remainingWeight = (weight - 45)  ;
          plates.forEach((element) {remainingWeight -= element.weight;});

          List<Widget> ui = [];

          ui.add(Container(
            width: 20,
            height: 16,
            color: const Color(0xFF4e5967),
          ));

          ui.add(Container(
            width: 10,
            height: 30,
            color: const Color(0xFF4e5967),
          ));

          ui.add(Container(
            width: 2,
            height: 20,
            color: const Color(0xFF4e5967),
          ));

          double possibleWeight = 0;
          plates.forEach((plate) {possibleWeight += plate.weight;});
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
                          color: mt(context).text.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w900
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Target: ${weight.toString()} | Possible: ${remainingWeight} ',
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
              SizedBox(
                height: 55,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    MButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EquipmentScreen()));
                      },
                      width: 55,
                      borderRadius: 0,
                      leading: Icon(
                        Icons.settings,
                        color: mt(context).icon.accentColor,
                      ),
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
              )
            ],
          );
        }
      }
    );
  }
}
