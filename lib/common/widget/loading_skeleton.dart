import 'package:flutter/material.dart';
import 'package:maven/common/common.dart';
import 'package:shimmer/shimmer.dart';

import '../../feature/theme/theme.dart';


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
      baseColor: T(context).color.surface.baseShimmer,
      highlightColor: T(context).color.surface.highlightShimmer,
      period: Duration(milliseconds: 800 + (offset * 100)),
      child: child,
    );
  }
}
