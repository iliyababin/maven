import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../settings/settings.dart';
import '../../theme/theme.dart';
import '../equipment.dart';

class PlateEditScreen extends StatefulWidget {
  const PlateEditScreen({
    Key? key,
    required this.plate,
  }) : super(key: key);

  final Plate plate;

  @override
  State<PlateEditScreen> createState() => _PlateEditScreenState();
}

class _PlateEditScreenState extends State<PlateEditScreen> {
  late Plate plate;
  late bool isEdited;

  void _pickColor() {
    showBottomSheetDialog(
      context: context,
      onClose: () {},
      child: ColorPicker(
        hexInputBar: true,
        enableAlpha: false,
        colorPickerWidth: 500,
        pickerAreaHeightPercent: 0.4,
        pickerColor: plate.color,
        labelTypes: const [],
        onColorChanged: (value) {
          updatePlate(plate.copyWith(color: value));
        },
      ),
    );
  }

  void updatePlate(Plate plate) {
    setState(() {
      this.plate = plate;
      isEdited = this.plate != widget.plate;
    });
  }

  @override
  void initState() {
    plate = widget.plate.copyWith();
    isEdited = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isEdited
          ? FloatingActionButton.extended(
              onPressed: () {
                context.read<EquipmentBloc>().add(PlateUpdate(plate));
                Navigator.pop(context);
              },
              label: const Text('Save'),
              icon: const Icon(Icons.save),
            )
          : null,
      appBar: AppBar(
        title: const Text('Edit Plate'),
        actions: [
          IconButton(
            onPressed: () {
              showBottomSheetDialog(
                context: context,
                child: ListDialog(
                  children: [
                    ListTile(
                      onTap: () {
                        // TODO: Duplicate plate
                      },
                      leading: const Icon(Icons.copy_rounded),
                      title: const Text('Duplicate'),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        context.read<EquipmentBloc>().add(PlateDelete(plate));
                      },
                      leading: Icon(
                        Icons.delete_rounded,
                        color: T(context).color.error,
                      ),
                      title: Text(
                        'Delete',
                        style: TextStyle(color: T(context).color.error),
                      ),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: T(context).shape.large),
        child: CustomScrollView(
          slivers: [
            const Heading(
              title: 'Preview',
              size: HeadingSize.small,
            ),
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
                      color: plate.color,
                      weight: plate.weight,
                      height: plate.height,
                    ),
                  ),
                ),
              ]),
            ),
            const Heading(title: 'Details'),
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
                          child: TextInputDialog(
                            title: 'Total Plates Available',
                            initialValue: plate.amount.toString(),
                            onValueChanged: (value) {
                              updatePlate(
                                  plate.copyWith(amount: value.isEmpty ? 0 : int.parse(value)));
                            },
                          ),
                        ),
                        title: const Text('Amount'),
                        trailing: Text('${plate.amount} plates'),
                      ),
                      ListTile(
                        onTap: () => showBottomSheetDialog(
                          context: context,
                          onClose: () {},
                          child: TextInputDialog(
                            title: 'Total Plate Weight',
                            initialValue: plate.weight.toString(),
                            onValueChanged: (value) {
                              updatePlate(
                                  plate.copyWith(weight: value.isEmpty ? 0 : double.parse(value)));
                            },
                          ),
                        ),
                        title: const Text('Weight'),
                        trailing: Text(s(context).parseWeight(plate.weight)),
                      ),
                      ListTile(
                        title: const Text('Size'),
                        trailing: SizedBox(
                          width: 200,
                          child: Slider(
                            min: 0.35,
                            max: 1.0,
                            value: plate.height,
                            onChanged: (double value) {
                              updatePlate(plate.copyWith(height: value));
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
                            color: plate.color,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        title: const Text('Color'),
                        trailing: Text('#${plate.color.value.toRadixString(16)}'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
      text: weight.truncateZeros,
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
