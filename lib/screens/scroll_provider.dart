import 'package:flutter/material.dart';

class ScrollProvider extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();

  void scrollTo(GlobalKey key, {double alignment = 0.0}) {
    final context = key.currentContext;
    if (context == null) return;

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
      alignment: alignment,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
