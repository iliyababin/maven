import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingSkeleton extends StatelessWidget {
  const LoadingSkeleton({
    required this.child,
    required this.offset,
  });

  final Widget child;
  final int offset;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: mt(context).color.secondary.withAlpha(75),
      highlightColor: mt(context).color.secondary,
      period: Duration(milliseconds: 800 + (offset * 100)),
      child: child,
    );
  }
}
