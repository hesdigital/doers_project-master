import 'dart:async';

import 'package:doers_project/frontMenu/homeScreen.dart';
import 'package:doers_project/helper/constColor.dart';
import 'package:doers_project/ui/widget/menu/mainmenu.dart';
import 'package:doers_project/ui/widget/menu/penjelasanScreen.dart';
import 'package:doers_project/ui/widget/testUi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(home: splashScreen()));
}

class splashScreen extends StatefulWidget {
  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  User user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();

  }

  void startTimer() {
    Timer(Duration(seconds: 3), () {
      navigateUser(); //It will redirect  after 3 seconds
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColors,
      body: Center(
        child: Image.asset('asset/images/logo.png'),
      ),
    );
  }

  Future<void> navigateUser() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String status = prefs.getString('email');
    print('printnya '+ status.toString());

    var auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((user) {
      if (status!= null || user != null) {
        print("user is logged in");
        Get.off(MainMenu());
        //navigate to home page using Navigator Widget
      } else {
        print("user is not logged in");
        Get.off(PenjelasanScreen());
        //navigate to sign in page using Navigator Widget
      }
    });

  //
  //   if (status != null && user != null) {
  //     Get.off(MainMenu());
  //   } else {
  //     Get.off(PenjelasanScreen());
  //   }
  }
}
