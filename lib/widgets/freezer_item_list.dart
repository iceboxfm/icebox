import 'package:flutter/material.dart';
import 'package:icebox/models/freezer_item.dart';
import 'package:icebox/providers/freezer_items.dart';
import 'package:icebox/providers/freezers.dart';
import 'package:icebox/widgets/filter_input.dart';
import 'package:icebox/widgets/freezer_item_list_item.dart';
import 'package:icebox/widgets/limiting_banner.dart';
import 'package:icebox/widgets/quantity_dialog.dart';
import 'package:provider/provider.dart';

class FreezerItemList extends StatelessWidget {
  const FreezerItemList({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final freezerItems = context.watch<FreezerItems>();
    final freezers = context.read<Freezers>();

    return Column(
      children: [
        if (freezerItems.category != null)
          LimitingBanner(
            type: 'category',
            limiter: freezerItems.category!.label,
            onCleared: () => freezerItems.limitCategory(null),
          ),
        if (freezerItems.freezer != null)
          LimitingBanner(
            type: 'freezer',
            limiter: freezers.retrieve(freezerItems.freezer!).description,
            onCleared: () => freezerItems.limitFreezer(null),
          ),
        FilterInput(freezerItems),
        Expanded(
          child: freezerItems.isNotEmpty
              ? ListView.builder(
                  itemCount: freezerItems.count(),
                  itemBuilder: (ctx, idx) => FreezerItemListItem(
                    freezers: freezers,
                    freezerItem: freezerItems[idx] as FreezerItem,
                    onLongPress: (fi) {
                      showDialog(
                        context: context,
                        builder: (ctx) => QuantityDialog(
                          fi.description,
                          fi.quantity,
                        ),
                      ).then((value) {
                        if (value != null) {
                          freezerItems.save(fi.copyWith(quantity: value));
                        }
                      });
                    },
                    onDelete: (fi) {
                      freezerItems.delete(fi.id!).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '"${fi.description}" was deleted.',
                            ),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      });
                    },
                  ),
                )
              : const Center(
                  child: Text('No freezer items.'),
                ),
        ),
      ],
    );
  }
}
