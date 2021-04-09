import 'package:events_app/Controllers/MyLocationProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Controllers/AddEventProvider.dart';
import 'Controllers/UserProvider.dart';
import 'Controllers/PageProvider.dart';
import 'Views/Screens/AccountPage.dart';
import 'Views/Screens/AddEventScreen.dart';
import 'Views/Screens/EnterScreen.dart';
import 'Views/Screens/HomePage.dart';
import 'Views/Screens/Loading.dart';
import 'Views/Screens/Login.dart';
import 'Views/Screens/MapPicker.dart';
import 'Views/Screens/MyHomePage.dart';
import 'Views/Screens/Register.dart';
import 'Views/Screens/SomethingIsWrong.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<PageProvider>(create: (_) => PageProvider()),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<AddEventProvider>(create: (_) => AddEventProvider()),
        ChangeNotifierProvider<MyLocationProvider>(create: (_) => MyLocationProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/EnterScreen': (context) => EnterScreen(),
        '/Login': (context) => Login(),
        '/Register': (context) => Register(),
        '/MyHomePage': (context) => MyHomePage(),
        '/AccountPage': (context) => AccountPage(),
        '/HomePage': (context) => HomePage(),
        '/AddEventScreen': (context) => AddEventScreen(),
        '/MyMapPicker': (context) => MyMapPicker(),
      },
      home: FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return SomethingWentWrong();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return EnterScreen();
          }
          return Loading();
        },
      ),
    );
  }
}
