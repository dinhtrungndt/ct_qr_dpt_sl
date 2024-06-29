
import 'package:flutter/material.dart';

import '../../config/color.dart';


class KPIScreen extends StatelessWidget {
  const KPIScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: const Color.fromRGBO(243, 246, 255, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'KPI',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 15),
        padding: EdgeInsets.all(10),
         color: Colors.white,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          buildKPIItem(
              Icons.description_outlined, 'Danh sách kết quả'),
          buildKPIItem(
               Icons.description_sharp, 'Danh sách chấm điểm'),
        ]),
      ),
    );
  }
}

Widget buildKPIItem(IconData icon, String name) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: [
        Icon(icon,color: mainColor,),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            name,
            style:const  TextStyle( fontSize: 17),
          ),
        ),
        const Icon(Icons.arrow_forward_ios_rounded,color: Colors.grey,size: 20)
     
      ],
    ),
  );
}