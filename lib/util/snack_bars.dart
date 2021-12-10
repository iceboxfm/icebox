import 'package:flutter/material.dart';

class SnackBars {
  static void show(final BuildContext ctx, final SnackBar snackBar) =>
      ScaffoldMessenger.of(ctx).showSnackBar(snackBar);

  static SnackBar message(final String msg, [final seconds = 4]) {
    return SnackBar(
      content: Text(msg),
      duration: Duration(seconds: seconds),
    );
  }

  static SnackBar error(final String msg, [final seconds = 8]) {
    return SnackBar(
      backgroundColor: Colors.orangeAccent,
      content: Text(
        msg,
        style: const TextStyle(color: Colors.black),
      ),
      duration: Duration(seconds: seconds),
    );
  }

  static void showMessage(final BuildContext ctx, final String msg,
      [final seconds = 4]) =>
      show(ctx, message(msg, seconds));

  static void showError(final BuildContext ctx, final String msg,
      [final seconds = 8]) =>
      show(ctx, error(msg, seconds));
}
