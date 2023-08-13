import 'package:flutter/material.dart';

import '../../feature/theme/theme.dart';
import 'developer_screen.dart';

class DesignToolWidget extends StatefulWidget {
  const DesignToolWidget({Key? key}) : super(key: key);

  @override
  _DesignToolWidgetState createState() => _DesignToolWidgetState();
}

class _DesignToolWidgetState extends State<DesignToolWidget> {
  late OverlayEntry _overlayEntry;
  late Offset _offset = const Offset(0, 0);
  late double _overlayWidth;
  late double _overlayHeight;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _overlayWidth = _getOverlayWidth(context);
      _overlayHeight = _getOverlayHeight(context);
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry);
      _offset = Offset(MediaQuery.of(context).size.width - 50, MediaQuery.of(context).size.height / 2);
    });
  }

  @override
  void dispose() {
    _overlayEntry.remove();
    super.dispose();
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          left: _offset.dx,
          top: _offset.dy,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                _offset = Offset(
                  (_offset.dx + details.delta.dx).clamp(0.0, MediaQuery.of(context).size.width - _overlayWidth),
                  (_offset.dy + details.delta.dy).clamp(0.0, MediaQuery.of(context).size.height - _overlayHeight),
                );
              });
            },
            onTap: () {},
            onTapUp: (details) {},
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DeveloperScreen()),
                );
              },
              backgroundColor: T(context).color.background,
              mini: true,
              child: const Icon(
                Icons.more_horiz_rounded,
                color: Colors.red,
              ),
            ),
          ),
        );
      },
    );
  }

  double _getOverlayWidth(BuildContext context) {
    const double iconSize = 40;
    const double margin = 8;
    return iconSize + 2 * margin;
  }

  double _getOverlayHeight(BuildContext context) {
    const double iconSize = 40;
    const double margin = 8;
    return iconSize + 2 * margin;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
