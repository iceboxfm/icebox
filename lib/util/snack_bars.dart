import 'package:flutter/material.dart';

void showMessageSnack(final BuildContext ctx, final String msg,
        [final int seconds = 4]) =>
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: Duration(seconds: seconds),
      ),
    );

void showErrorSnack(final BuildContext ctx, final String msg,
        [final int seconds = 8]) =>
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        backgroundColor: Colors.orangeAccent,
        content: Text(
          msg,
          style: const TextStyle(color: Colors.black),
        ),
        duration: Duration(seconds: seconds),
      ),
    );
