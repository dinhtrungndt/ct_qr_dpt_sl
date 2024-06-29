import 'package:erp/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});
  @override
  Widget build(BuildContext context) {
    return const SpinKitFadingCircle(
      color: Color.fromARGB(255, 42, 191, 111),
      size: 50.0,
    );
  }
}
