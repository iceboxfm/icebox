import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icebox/providers/freezer_items.dart';
import 'package:icebox/providers/freezers.dart';
import 'package:icebox/screens/freezer_item_screen.dart';
import 'package:icebox/screens/freezer_items_screen.dart';
import 'package:icebox/screens/freezer_screen.dart';
import 'package:icebox/screens/freezers_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // let's only allow portrait orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const IceboxApp());
}

class IceboxApp extends StatelessWidget {
  const IceboxApp({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Freezers()),
        ChangeNotifierProvider(create: (_) => FreezerItems()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const FreezerItemsScreen(),
        routes: {
          FreezerItemsScreen.routeName: (ctx) => const FreezerItemsScreen(),
          FreezersScreen.routeName: (ctx) => const FreezersScreen(),
          FreezerScreen.routeName: (ctx) => const FreezerScreen(),
          FreezerItemScreen.routeName: (ctx) => const FreezerItemScreen(),
        },
        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (ctx) => const FreezerItemsScreen(),
        ),
      ),
    );
  }
}
