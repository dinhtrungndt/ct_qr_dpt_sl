import 'package:flutter/material.dart';

import '../../config/color.dart';

class WarningSettingScreen extends StatelessWidget {
  const WarningSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(243, 246, 255, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Cài đặt cảnh báo',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 15),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        color: Colors.white,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          buildWarningItem(
              'Cảnh báo vào ca', 'Cảnh báo khi đến giờ vào ca', false),
          buildWarningItem(
              'Cảnh báo ra ca', 'Cảnh báo khi đến giờ ra ca', true),
          Container(height: 1, width: double.infinity, color: Colors.grey[200]),
          buildWarningItem('Cảnh báo vào ca trễ',
              'Cảnh báo 10 phút trước giờ vào ca', false),
          Container(height: 1, width: double.infinity, color: Colors.grey[200]),
          buildWarningItem('Cảnh báo ra ca trễ',
              'Cảnh báo sau 10 phút nếu bạn quên ca', false),
          Container(height: 1, width: double.infinity, color: Colors.grey[200]),
          buildWarningItem('Cảnh báo của camera AI',
              'Chỉ nhận cảnh báo của camera AI trong khung giờ cài đặt', false),
        ]),
      ),
    );
  }
}

Widget buildWarningItem(String name, String content, bool turnOn) {
  return Padding(
    padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 17),
              ),
              Text(
                content,
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Switch.adaptive(
            activeTrackColor: mainColor,
            activeColor: Colors.white,
            value: turnOn ? true : false,
            onChanged: (value) {}),
        const SizedBox(width: 10),
      ],
    ),
  );
}
