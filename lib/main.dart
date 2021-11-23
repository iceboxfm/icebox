import 'package:flutter/material.dart';
import 'package:icebox/providers/freezers.dart';
import 'package:icebox/screens/freezer_items_screen.dart';
import 'package:icebox/screens/freezer_screen.dart';
import 'package:icebox/screens/freezers_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(const IceboxApp());

class IceboxApp extends StatelessWidget {
  const IceboxApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Freezers()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const FreezerItemsScreen(),
        routes: {
          FreezerItemsScreen.routeName: (ctx) => const FreezerItemsScreen(),
          FreezersScreen.routeName: (ctx) => const FreezersScreen(),
          FreezerScreen.routeName: (ctx) => const FreezerScreen(),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
              builder: (ctx) => const FreezerItemsScreen());
        },
      ),
    );
  }
}
