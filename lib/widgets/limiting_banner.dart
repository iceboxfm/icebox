import 'package:flutter/material.dart';

class LimitingBanner extends StatelessWidget {
  final String limiter;
  final Function onCleared;

  const LimitingBanner({
    required this.limiter,
    required this.onCleared,
  });

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      color: Colors.teal.shade300,
      // TODO: theme
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          Text('Showing only "$limiter" items.'),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => onCleared(),
          ),
        ],
      ),
    );
  }
}
