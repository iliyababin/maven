import 'package:Maven/feature/workout/m_keyboard/widget/barbell_calculator_widget.dart';
import 'package:flutter/material.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({Key? key}) : super(key: key);

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(child: BarbellCalculatorWidget(weight: (200-45) / 2)),
    );
  }
}
