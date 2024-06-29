import 'package:flutter/material.dart';

import '../../../config/mythemes.dart';



class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
          text: 'D',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: mainColor
          ),
          children: [
            TextSpan(
              text: 'PT',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'Solution',
              style: TextStyle(color: mainColor, fontSize: 30),
            ),
          ]),
    );
  }
}
