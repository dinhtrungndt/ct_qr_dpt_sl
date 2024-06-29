import 'package:flutter/material.dart';

import '../../../config/color.dart';

class ChosseBranchScreen extends StatelessWidget {
  const ChosseBranchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Chọn chi nhánh',
          style: TextStyle(color: blueBlack),
        ),
        iconTheme: IconThemeData(color: blueBlack),
        elevation: 0,
      ),
      body: Column(children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Vietgoat',
                  style: const TextStyle(fontSize: 17),
                ),
                Icon(
                  Icons.check,
                  color: mainColor,
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ABC',
                  style: const TextStyle(fontSize: 17),
                ),
                Icon(
                  Icons.check,
                  color: Colors.white,
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
