import 'package:flutter/material.dart';

class DismissibleBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.25),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.delete, color: Colors.red),
                ),
              )),
        ],
      ),
    );
  }
}