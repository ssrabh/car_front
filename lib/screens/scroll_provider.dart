import 'package:flutter/material.dart';
import 'dart:math' as math;

class ScrollProvider extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();

  Future<void> scrollTo(GlobalKey key) async {
    final context = key.currentContext;
    if (context == null) return;

    // Get RenderBox to compute actual offset from top
    final box = context.findRenderObject() as RenderBox?;
    if (box != null) {
      final position = box.localToGlobal(Offset.zero).dy;
      final currentOffset = scrollController.offset;
      double targetOffset = currentOffset + position - 120;

      // Constrain target offset within scroll limits
      targetOffset = math.max(
        0,
        math.min(targetOffset, scrollController.position.maxScrollExtent),
      );

      await scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
