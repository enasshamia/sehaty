import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/backend/appProvider.dart';
import 'package:graduation/screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';



void main() { 
  WidgetsFlutterBinding.ensureInitialized();
    AwesomeNotifications().initialize(
      null, // icon for your app notification
      [
        NotificationChannel(
          channelKey: 'key1',
          channelName: 'Proto Coders Point',
          channelDescription: "Notification example",
          defaultColor: Color(0XFF9050DD),
          ledColor: Colors.white,
          playSound: true,
          enableLights:true,
          enableVibration: true
        )
      ]
  );
  runApp(
  

ChangeNotifierProvider<AppsProvider>(
  create: (_) {
    return AppsProvider();
  },
  child: GetMaterialApp(
  theme: ThemeData(
   textTheme: TextTheme(
    bodyText2: GoogleFonts.cairo ()
     
   ),
       appBarTheme: AppBarTheme(
     color: Color.fromRGBO(123, 173, 203, 1),
     textTheme: TextTheme(bodyText2: GoogleFonts.cairo ())
  )),
  home:App ()
  )
  )
);
    
    
    

}




class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if(_error) {
      return Scaffold(body: Center(child: Text("Somthing Wrong"),),);
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return   Scaffold(body: Center(child: CircularProgressIndicator(),),);
    }

    return SplashScreen();
  }
}