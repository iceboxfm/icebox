import 'package:flutter/material.dart';

class TimeRemaining extends StatelessWidget {
  final Duration timeRemaining;

  const TimeRemaining(this.timeRemaining);

  @override
  Widget build(BuildContext context) {
    return Chip(
      padding: const EdgeInsets.all(1),
      backgroundColor: _selectBackgroundColor(timeRemaining),
      label: timeRemaining.inDays <= 0
          ? const Icon(Icons.error, color: Colors.white)
          : Text(
        _daysRemainingText(timeRemaining),
        style: TextStyle(
          color: _selectTextColor(timeRemaining),
        ),
      ),
    );
  }

  String _daysRemainingText(final Duration remaining) {
    return remaining.inDays < 30
        ? '${remaining.inDays} d'
        : '${(remaining.inDays / 30).toStringAsFixed(0)} m';
  }

  Color _selectBackgroundColor(final Duration remaining) {
    if (remaining.inDays < 30) {
      return Colors.red;
    } else if (remaining.inDays < 60) {
      return Colors.amber;
    } else {
      return Colors.green;
    }
  }

  Color _selectTextColor(final Duration remaining) {
    if (remaining.inDays < 30) {
      return Colors.white;
    } else if (remaining.inDays < 60) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }
}
