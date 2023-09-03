import 'package:flutter/material.dart';

//import 'package:ejemploswidgets/src/home_temp.dart';

//Paginas
//import 'package:ejemploswidgets/src/page/alert_page.dart';
import 'package:ejemploswidgets/src/page/avatar_page.dart';
//import 'package:ejemploswidgets/src/page/home_page.dart';

//Rutas
import 'package:ejemploswidgets/src/routes/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'), // English
        const Locale('es'), // Hebrew
        const Locale.fromSubtags(
            languageCode: 'zh'), // Chinese *See Advanced Locales below*
        // ... other locales the app supports
      ],
      //home: HomePage()
      initialRoute: '/',
      routes: getRutas(),
      onGenerateRoute: (RouteSettings settings) {
        print('Se llamo a la ruta: $settings.name');

        return MaterialPageRoute(
            builder: (BuildContext context) => AvatarPage());
      },
    );
  }
}
