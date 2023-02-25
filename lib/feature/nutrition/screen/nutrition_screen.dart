import 'package:Maven/feature/equipment/service/equipment_service.dart';
import 'package:Maven/main.dart';
import 'package:flutter/material.dart';

import '../../m_keyboard/widget/barbell_calculator_widget.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({Key? key}) : super(key: key);

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(child: BarbellCalculatorWidget(equipmentService: services<EquipmentService>(), weight: 600,)),
    );
  }
}
