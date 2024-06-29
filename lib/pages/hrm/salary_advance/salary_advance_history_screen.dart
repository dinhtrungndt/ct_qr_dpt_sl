import 'package:flutter/material.dart';

import '../../../config/color.dart';

class SalaryAdvanceHistoryScreen extends StatelessWidget {
  const SalaryAdvanceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
        return Scaffold(
      backgroundColor: Color.fromRGBO(243, 251, 249, 1),
      appBar: AppBar(
        title: const Text(
          'Lịch sử ứng lương',
          style: TextStyle(color: blueBlack),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 0,
      ),body: Center(child: Text('Chưa có lịch sử',style: TextStyle(fontSize: 20),),),
      );
  }
}