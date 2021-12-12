import 'package:flutter/material.dart';
import 'package:icebox/models/freezer_item.dart';
import 'package:icebox/providers/freezer_items.dart';
import 'package:icebox/providers/freezers.dart';
import 'package:icebox/screens/freezers_screen.dart';
import 'package:icebox/util/snack_bars.dart';
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
                    freezerDescription: freezers
                        .retrieve(freezerItems[idx].freezerId!)
                        .description,
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
                        showMessageSnack(
                          context,
                          '"${fi.description}" was deleted.',
                        );
                      });
                    },
                  ),
                )
              : NoFreezerItemsText(freezers.isNotEmpty),
        ),
      ],
    );
  }
}

class NoFreezerItemsText extends StatelessWidget {
  final bool hasFreezers;

  const NoFreezerItemsText(this.hasFreezers);

  @override
  Widget build(final BuildContext context) {
    return Center(
      child: hasFreezers ? _noItems() : _noFreezers(context),
    );
  }

  Widget _noItems() {
    return const Text(
      'No freezer items.',
      style: TextStyle(fontSize: 18),
    );
  }

  Widget _noFreezers(final BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'You have no freezers.',
          style: TextStyle(fontSize: 18),
        ),
        TextButton(
          child: const Text(
            'Create one.',
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () => Navigator.of(context)
              .pushReplacementNamed(FreezersScreen.routeName),
        ),
      ],
    );
  }
}
