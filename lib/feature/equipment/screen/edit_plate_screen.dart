import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../../theme/theme.dart';
import '../equipment.dart';

class EditPlateScreen extends StatefulWidget {
  const EditPlateScreen({
    Key? key,
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

  void _pickColor() {
    showBottomSheetDialog(
      context: context,
      onClose: () {},
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
        title: const Text('Edit Plate'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<EquipmentBloc>().add(PlateUpdate(
                    plate: Plate(
                      id: widget.plate.id,
                      amount: amount,
                      color: color,
                      height: height,
                      weight: weight,
                    ),
                  ));
              Navigator.pop(context);
            },
            icon: const Icon(Icons.check),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: T(context).shape.large),
        child: CustomScrollView(
          slivers: [
            Heading(title: 'Preview', size: HeadingSize.small,),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  alignment: Alignment.center,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(T(context).shape.large),
                    color: T(context).color.surface,
                  ),
                  child: CustomPaint(
                    size: const Size(200, 200),
                    painter: WeightPlatePainter(
                      color: color,
                      weight: weight,
                      height: height,
                    ),
                  ),
                ),
              ]),
            ),
            Heading(title: 'Details'),
            SliverToBoxAdapter(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(T(context).shape.large),
                child: Material(
                  color: T(context).color.surface,
                  child: Column(
                    children: [
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
                        ),
                        trailing: Text(
                          '$amount plates',
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
                        ),
                        trailing: Text(
                          weight.toString(),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Size',
                        ),
                        trailing: SizedBox(
                          width: 200,
                          child: Slider(
                            min: 0.35,
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
                        ),
                        trailing: Text(
                          '#${color.value.toRadixString(16)}',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
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

    final holePaint = Paint()..color = Colors.black.withOpacity(0.6);
    canvas.drawOval(
        Rect.fromCenter(
          center: center,
          width: 25,
          height: 25,
        ),
        holePaint);

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
