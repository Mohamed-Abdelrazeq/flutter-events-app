import 'package:events_app/Controllers/LocationController.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Controllers/ImagePickerController.dart';
import 'Controllers/UserInfoController.dart';
import 'Controllers/CurrentPageController.dart';
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
import 'Services/ImageStorage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CurrentPageContoller>(create: (_) => CurrentPageContoller()),
        ChangeNotifierProvider<UserInfoController>(create: (_) => UserInfoController()),
        ChangeNotifierProvider<LocationController>(create: (_) => LocationController()),
        ChangeNotifierProvider<ImagePickerController>(create: (_) => ImagePickerController()),
        ChangeNotifierProvider<ImageStorage>(create: (_) => ImageStorage()),
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
