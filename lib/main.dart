import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icebox/providers/freezer_items.dart';
import 'package:icebox/providers/freezers.dart';
import 'package:icebox/screens/freezer_item_screen.dart';
import 'package:icebox/screens/freezer_items_screen.dart';
import 'package:icebox/screens/freezer_screen.dart';
import 'package:icebox/screens/freezers_screen.dart';
import 'package:icebox/screens/import_export_screen.dart';
import 'package:provider/provider.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    yield LicenseEntryWithLineBreaks(
      ['google_fonts'],
      await rootBundle.loadString('google_fonts/OFL.txt'),
    );
  });

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
        theme: ThemeData(
          textTheme: GoogleFonts.exo2TextTheme(
            Theme.of(context).textTheme,
          ),
          primarySwatch: const MaterialColor(
            4280402675,
            {
              50: Color(0xffe7f8fe),
              100: Color(0xffcff2fc),
              200: Color(0xff9ee4fa),
              300: Color(0xff6ed7f7),
              400: Color(0xff3dcaf5),
              500: Color(0xff0dbdf2),
              600: Color(0xff0a97c2),
              700: Color(0xff087191),
              800: Color(0xff054b61),
              900: Color(0xff032630),
            },
          ),
          brightness: Brightness.light,
          primaryColor: const Color(0xff21c2f3),
          primaryColorBrightness: Brightness.light,
          primaryColorLight: const Color(0xffcff2fc),
          primaryColorDark: const Color(0xff087191),
          // accentColor: Color(0xff0dbdf2),
          // accentColorBrightness: Brightness.light,
          canvasColor: const Color(0xfffafafa),
          scaffoldBackgroundColor: const Color(0xfffafafa),
          bottomAppBarColor: const Color(0xffffffff),
          cardColor: const Color(0xffffffff),
          dividerColor: const Color(0x1f000000),
          highlightColor: const Color(0x66bcbcbc),
          splashColor: const Color(0x66c8c8c8),
          selectedRowColor: const Color(0xfff5f5f5),
          unselectedWidgetColor: const Color(0x8a000000),
          disabledColor: const Color(0x61000000),
          // buttonColor: Color(0xffe0e0e0),
          toggleableActiveColor: const Color(0xff0a97c2),
          secondaryHeaderColor: const Color(0xffe7f8fe),
          // textSelectionColor: Color(0xff9ee4fa),
          // cursorColor: Color(0xff4285f4),
          // textSelectionHandleColor: Color(0xff6ed7f7),
          backgroundColor: const Color(0xff9ee4fa),
          dialogBackgroundColor: const Color(0xffffffff),
          indicatorColor: const Color(0xff0dbdf2),
          hintColor: const Color(0x8a000000),
          errorColor: const Color(0xffd32f2f),
        ),
        debugShowCheckedModeBanner: false,
        home: const FreezerItemsScreen(),
        routes: {
          FreezerItemsScreen.routeName: (ctx) => const FreezerItemsScreen(),
          FreezersScreen.routeName: (ctx) => const FreezersScreen(),
          FreezerScreen.routeName: (ctx) => const FreezerScreen(),
          FreezerItemScreen.routeName: (ctx) => const FreezerItemScreen(),
          ImportExportScreen.routeName: (ctx) => const ImportExportScreen(),
        },
        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (ctx) => const FreezerItemsScreen(),
        ),
      ),
    );
  }
}
