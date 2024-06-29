import 'dart:async';
import 'package:erp/pages/login/config_server_page.dart';
import 'package:erp/pages/login/login_page.dart';
import 'package:universal_io/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/mythemes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  int _second = 3; // set timer for 3 second and then direct to next page

  void _startTimer() {
    const period = Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      setState(() {
        _second--;
      });
      if (_second == 0) {
        _cancelFlashsaleTimer();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (Route<dynamic> route) => false);
      }
    });
  }

  void _cancelFlashsaleTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  @override
  void initState() {
    // set status bar color to transparent and navigation bottom color to black21
    SystemChrome.setSystemUIOverlayStyle(
      Platform.isIOS
          ? SystemUiOverlayStyle.light
          : const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              systemNavigationBarColor: BLACK55,
              systemNavigationBarIconBrightness: Brightness.light),
    );

    if (_second != 0) {
      _startTimer();
    }
    super.initState();
  }

  @override
  void dispose() {
    _cancelFlashsaleTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("DPT Solution", style: MyThemes.textIntro)),
          Center(
              child:
                  Text("Giải pháp toàn diện", style: MyThemes.textIntroSmall))
        ],
      ),
    );
  }
}
