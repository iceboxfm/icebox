import 'package:flutter/material.dart';
import 'package:icebox/models/freezer.dart';
import 'package:icebox/providers/freezers.dart';
import 'package:provider/provider.dart';

// FIXME: come up with a shared dialog with good theming

class FreezerDialog extends StatelessWidget {
  final Set<int> freezerIds;

  const FreezerDialog(this.freezerIds);

  @override
  Widget build(final BuildContext context) {
    final freezers = context.read<Freezers>();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            // title
            Container(
              padding: const EdgeInsets.all(6),
              width: double.infinity,
              color: Theme.of(context).backgroundColor,
              child: const Text('Show only...'),
            ),
            // list items
            SizedBox(
              height: 355,
              child: ListView(
                children: freezers.freezers
                    .where((f) => freezerIds.contains(f.id))
                    .map((e) => ListTile(
                          leading: e.type.image,
                          title: Text(e.description),
                          onTap: () => Navigator.pop(context, e.id),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
