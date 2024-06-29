import 'package:flutter/material.dart';

import '../../../config/color.dart';

class FilterRequestManagementScreen extends StatelessWidget {
  const FilterRequestManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Lọc',
            style: TextStyle(color: blueBlack),
          ),
          iconTheme: const IconThemeData(color: blueBlack),
          elevation: 1,
        ),
        body: Container());
  }
}
