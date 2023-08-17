import 'package:flutter/material.dart';

import '../../feature/theme/theme.dart';

enum SliverBoxType {
  empty,
  loading,
}

class SliverBoxWidget extends StatefulWidget {
  const SliverBoxWidget({
    Key? key,
    this.type = SliverBoxType.empty,
    this.side = false,
    this.text = '',
  }) : super(key: key);

  final SliverBoxType type;
  final bool side;
  final String text;

  @override
  State<SliverBoxWidget> createState() => _SliverBoxWidgetState();
}

class _SliverBoxWidgetState extends State<SliverBoxWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = Tween<double>(begin: 0, end: 2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0, 0.75, curve: Curves.easeInOut),
      ),
    );

    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.side ? T(context).space.large : 0,
      ),
      sliver: SliverToBoxAdapter(
        child: Container(
          height: 100,
          key: const ValueKey('add'),
          decoration: BoxDecoration(
            color: T(context).color.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: animation,
                  builder: (BuildContext context, Widget? child) {
                    final int dotsCount = animation.value.toInt() + 1;
                    final String dots = '.' * dotsCount;
                    return Text(
                      widget.type == SliverBoxType.empty
                          ? widget.text.isEmpty ? 'Empty' : widget.text
                          : 'Loading$dots',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
