import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../../common/dialog/show_bottom_sheet_dialog.dart';
import '../../../common/dialog/text_input_dialog.dart';
import '../../../common/widget/m_button.dart';
import '../../../database/model/plate.dart';
import '../../../theme/widget/inherited_theme_widget.dart';
import '../bloc/equipment/equipment_bloc.dart';

class EditPlateScreen extends StatefulWidget {
  const EditPlateScreen({Key? key,
    required this.plate,
  }) : super(key: key);

  final Plate plate;

  @override
  State<EditPlateScreen> createState() => _EditPlateScreenState();
}

class _EditPlateScreenState extends State<EditPlateScreen> {

  late int amount;
  late Color color;
  late double height;
  late double weight;

  void _pickColor () {
    showBottomSheetDialog(
      context: context,
      onClose: () {
      },
      height: 350,
      child: ColorPicker(
        hexInputBar: true,
        enableAlpha: false,
        colorPickerWidth: 500,
        pickerAreaHeightPercent: 0.4,
        pickerColor: color,

        labelTypes: const [],
        onColorChanged: (value) {
          setState(() {
            color = value;
          });
        },
      ),
    );
  }

  @override
  void initState() {
    amount = widget.plate.amount;
    color = widget.plate.color;
    height = widget.plate.height;
    weight = widget.plate.weight;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          MButton(
            onPressed: (){
              context.read<EquipmentBloc>().add(PlateUpdate(
                plate: Plate(
                  plateId: widget.plate.plateId,
                  amount: amount,
                  color: color,
                  height: height,
                  weight: weight,
                  isCustomized: false,
                ),
              ));
              Navigator.pop(context);
            },
            width: 75,
            child: const Text(
              'Save',
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            height: 250,
            child: CustomPaint(
              size: const Size(200, 200),
              painter: WeightPlatePainter(
                color: color,
                weight: weight,
                height: height,
              ),
            ),
          ),
          ListTile(
            onTap: () => showBottomSheetDialog(
              context: context,
              onClose: () {},
              height: 250,
              child: TextInputDialog(
                title: 'Total Plates Available',
                initialValue: amount.toString(),
                onValueChanged: (value) {
                  setState(() {
                    amount = value.isEmpty ? 0 : int.parse(value);
                  });
                },
              ),
            ),
            title: Text(
              'Amount',
              style: T(context).textStyle.body1,
            ),
            subtitle: Text(
              '$amount plates',
              style: T(context).textStyle.subtitle1,
            ),
          ),
          ListTile(
            onTap: () => showBottomSheetDialog(
              context: context,
              onClose: () {},
              height: 250,
              child: TextInputDialog(
                title: 'Total Plate Weight',
                initialValue: weight.toString(),
                onValueChanged: (value) {
                  setState(() {
                    weight = value.isEmpty ? 0 : double.parse(value);
                  });
                },
              ),
            ),
            title: Text(
              'Weight',
              style: T(context).textStyle.body1,
            ),
            subtitle: Text(
              weight.toString(),
              style: T(context).textStyle.subtitle1,
            ),
          ),
          ListTile(
            title: Text(
              'Size',
              style: T(context).textStyle.body1,
            ),
            subtitle: Text(
              height.toStringAsFixed(3),
              style: T(context).textStyle.subtitle1,
            ),
            trailing: SizedBox(
              width: 200,
              child: Slider(
                min: 0.5,
                max: 1.0,
                value: height,
                onChanged: (double value) {
                  setState(() {
                    height = value;
                  });
                },
              ),
            ),
          ),
          ListTile(
            onTap: () => _pickColor(),
            leading: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            title: Text(
              'Color',
              style: T(context).textStyle.body1,
            ),
            subtitle: Text(
              '#${color.value.toRadixString(16)}',
              style: T(context).textStyle.subtitle1,
            ),
          ),
        ],
      ),
    );
  }
}

class WeightPlatePainter extends CustomPainter {
  final Color color;
  final double weight;
  final double height;

  WeightPlatePainter({
    required this.color,
    required this.weight,
    required this.height,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = height * 100;

    // Define the colors for the gradient based on the specified color
    final gradientColors = [color.shade800, color.shade500, color.shade900];

    // Draw the outer circle with gradient fill
    final outerGradient = RadialGradient(
      center: const Alignment(-0.5, -0.6),
      radius: 1.3,
      colors: gradientColors,
      stops: const [0.3, 0.5, 0.8],
    );
    paint.shader = outerGradient.createShader(Rect.fromCircle(
      center: center,
      radius: radius,
    ));
    canvas.drawCircle(center, radius, paint);

    // Define the highlight color based on the specified color
    final highlightColor = color == Colors.white ? Colors.grey.shade400 : Colors.white;

    final metalPaint = Paint()
      ..shader = SweepGradient(
        center: const Alignment(-0.6, -0.2),
        colors: [
          Colors.grey.shade200,
          Colors.grey.shade400,
          Colors.grey.shade200,
        ],
        stops: const [0.0, 0.5, 1.0],
        startAngle: 0,
        endAngle: 2 * pi,
        transform: const GradientRotation(pi / 4),
      ).createShader(Rect.fromCircle(
        center: center,
        radius: radius * 0.35,
      ));
    canvas.drawCircle(center, radius * 0.35, metalPaint);

    final holePaint = Paint()
      ..color = Colors.black.withOpacity(0.6);
    canvas.drawOval(Rect.fromCenter(
      center: center,
      width: 25,
      height: 25,
    ), holePaint);

    // Add engraved text indicating the weight on both sides
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: radius * 0.25,
      fontWeight: FontWeight.bold,
      shadows: [
        Shadow(
          color: highlightColor,
          blurRadius: 2,
          offset: const Offset(0, 1),
        ),
      ],
    );

    final textSpan = TextSpan(
      text: removeDecimalZeroFormat(weight),
      style: textStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    final textWidth = textPainter.width;
    final textHeight = textPainter.height;

    canvas.save();
    canvas.translate(center.dx - textWidth / 2, center.dy - textHeight / 2);
    textPainter.paint(canvas, Offset(65 * height, 0));
    canvas.restore();

    canvas.save();
    canvas.translate(center.dx - textWidth / 2, center.dy - textHeight / 2);
    textPainter.paint(canvas, Offset(-65 * height, 0));
    canvas.restore();

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

String removeDecimalZeroFormat(double n) {
  return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
}


extension ColorShade800Extension on Color {
  Color get shade800 {
    final hslColor = HSLColor.fromColor(this);
    return hslColor.withLightness((hslColor.lightness - 0.2).clamp(0.0, 1.0)).toColor();
  }
}

extension ColorShade500Extension on Color {
  Color get shade500 {
    final hslColor = HSLColor.fromColor(this);
    return hslColor.withLightness((hslColor.lightness - 0.1).clamp(0.0, 1.0)).toColor();
  }
}

extension ColorShade900Extension on Color {
  Color get shade900 {
    final hslColor = HSLColor.fromColor(this);
    return hslColor.withLightness((hslColor.lightness - 0.3).clamp(0.0, 1.0)).toColor();
  }
}