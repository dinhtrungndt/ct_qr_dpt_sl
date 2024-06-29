import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/entypo_icons.dart';

class ChooseScreen extends StatelessWidget {
  const ChooseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // toolbarHeight: 0,
        title: const Text(
          'Chọn',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.clear)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(children: [
          buildChooseItem(FontAwesome.money, 'Tạm ứng lương'),
          Container(height: 1, color: Colors.grey[200]),
          buildChooseItem(Icons.access_time_rounded, 'Làm thêm giờ'),
          Container(height: 1, color: Colors.grey[200]),
          buildChooseItem(Entypo.briefcase, 'Công tác/Ra ngoài'),
          Container(height: 1, color: Colors.grey[200]),
          buildChooseItem(FontAwesome.bed, 'Nghỉ phép'),
        ]),
      ),
    );
  }
}

Widget buildChooseItem(IconData icon, String name) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15),
    child: Row(
      children: [
        Container(
          width: 60,
          alignment: Alignment.centerLeft,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFe4ecff)),
            child: Icon(
              icon,
              color: Colors.blueGrey,
              size: 22,
            ),
          ),
        ),
        Text(
          name,
          style: const TextStyle(fontSize: 17),
        )
      ],
    ),
  );
}
