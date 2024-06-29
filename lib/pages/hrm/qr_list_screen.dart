import 'package:flutter/material.dart';
import '../../config/color.dart';

import 'qr_screen.dart';

class QRListScreen extends StatelessWidget {
  const QRListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> qrList = [];
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        title: const Text(
          'Danh sách QR',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QRScreen()),
                );
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: (qrList.isEmpty)
          ? const Center(
              child: Text(
              'Trang này chưa có dữ liệu',
              style: TextStyle(fontSize: 17, color: Colors.blueGrey),
            ))
          : SingleChildScrollView(
              child: Column(children: []),
            ),
    );
  }
}

Widget buildCompanyItem(IconData icon, String name) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.only(left: 10, right: 15),
    height: 45,
    child: Row(children: [
      Icon(
        icon,
        color: mainColor,
        size: 20,
      ),
      const SizedBox(width: 15),
      Expanded(
          child: Text(
        name,
        style: const TextStyle(fontSize: 16),
      )),
      InkWell(
        onTap: () {},
        child: SizedBox(
          height: 45,
          width: 45,
          child: Icon(Icons.arrow_forward_ios_rounded,
              size: 20, color: Colors.blueGrey[300]!),
        ),
      )
    ]),
  );
}
