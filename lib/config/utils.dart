import 'package:flutter/material.dart';

class Utils {
  // Global Keys
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  // Show a global snackbar (works from anywhere)
  static void showSnackBar(String message,
      {Color? backgroundColor,
      Duration duration = const Duration(seconds: 3)}) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: duration,
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
    );
    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }

  // Show a global alert dialog
  static Future<void> showAlertDialog(
      {required String title,
      required String content,
      String confirmText = 'OK',
      VoidCallback? onConfirm}) async {
    final BuildContext? context = navigatorKey.currentContext;
    if (context == null) return;
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              if (onConfirm != null) onConfirm();
            },
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  // Show a bottom sheet dialog globally (for actions, forms, etc)
  static Future<T?> showBottomDialog<T>(Widget child,
      {bool scrollControlled = false}) {
    final BuildContext? context = navigatorKey.currentContext;
    if (context == null) return Future.value();
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: scrollControlled,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
      builder: (_) => child,
    );
  }

  // Optionally add more convenience methods here
}
