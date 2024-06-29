
import 'package:flutter/material.dart';

import '../../config/color.dart';


class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),
      appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          title: const Text(
            'Báo cáo',
            style: TextStyle(color: Colors.black),
          )),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
              height: 45,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('BÁO CÁO CỦA TÔI',
                        style: TextStyle(color: Colors.blueGrey[300]!))),
              )),
          buildReportItem(Icons.calendar_month, 'Bảng công'),
          Container(height: 1, color: Colors.grey[200]),
          buildReportItem(Icons.description, 'Yêu cầu'),
          Container(height: 1, color: Colors.grey[200]),
          buildReportItem(Icons.description, 'Giao việc'),
          SizedBox(
              height: 45,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('BÁO CÁO HỆ THỐNG',
                        style: TextStyle(color: Colors.blueGrey[300]!))),
              )),
          buildReportItem(Icons.calendar_month, 'Chấm công'),
          Container(height: 1, color: Colors.grey[200]),
          buildReportItem(Icons.people, 'Nhân sự'),
          Container(height: 1, color: Colors.grey[200]),
          buildReportItem(Icons.query_builder, 'Thời gian'),
          Container(height: 1, color: Colors.grey[200]),
          buildReportItem(Icons.receipt_outlined, 'Báo cáo của nhân viên'),
        ]),
      ),
    );
  }
}

Widget buildReportItem(IconData icon, String name) {
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
