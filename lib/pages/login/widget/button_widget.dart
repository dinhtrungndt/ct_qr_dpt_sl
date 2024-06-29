import 'package:flutter/material.dart';

import '../../../config/mythemes.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  Widget? widget;
  ButtonWidget({Key? key, required this.text, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: const Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [mainColor, mainColor2])),
      child: widget != null
          ? widget!
          : Text(
              text,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
    );
  }
}
