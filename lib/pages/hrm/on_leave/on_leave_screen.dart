import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import '../../../config/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnLeaveScreen extends StatelessWidget {
  const OnLeaveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(243, 246, 255, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          AppLocalizations.of(context)!.onleave,
          style: const TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: Colors.white,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          buildOnLeaveItem(Elusive.calendar, 'Số ngày nghỉ còn lại'),
        ]),
      ),
    );
  }
}

Widget buildOnLeaveItem(IconData icon, String name) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: [
        Icon(
          icon,
          color: mainColor,
          size: 20,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Text(
            name,
            style: const TextStyle(fontSize: 17),
          ),
        ),
        const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey)
      ],
    ),
  );
}
