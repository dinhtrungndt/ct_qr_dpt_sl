
import 'package:flutter/material.dart';

import '../../config/color.dart';


class QRScreen extends StatelessWidget {
  const QRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> list = [];
   // List<String> branchList = [];
   // List<String> subBranchList = [];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'QR',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          InkWell(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              alignment: Alignment.center,
              child: Text(
                'TẠO',
                style: TextStyle(color: mainColor),
              ),
            ),
            onTap: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Text('Tên QR'),
                Text(
                  ' *',
                  style: TextStyle(color: Colors.red),
                )
              ],
            ),
            const SizedBox(height: 10),
            Container(
              color: const Color(0xFFF3F6FF),
              height: 50,
              width: double.infinity,
              child: TextFormField(
                cursorColor: backgroundColor,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  //contentPadding: EdgeInsets.zero,
                  contentPadding: EdgeInsets.only(left: 15),
                  hintText: 'Nhập chữ',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: const [
                Text('Chi nhánh'),
                Text(' *', style: TextStyle(color: Colors.red))
              ],
            ),
            const SizedBox(height: 10),
            Container(
              color: const Color(0xFFF3F6FF),
              height: 50,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButton<String>(
                underline: const SizedBox.shrink(),
                elevation: 0,
                value: null,
                hint: Row(
                  children: [
                    Text('* ', style: TextStyle(color: Colors.red)),
                    Text('Chọn chi nhánh',
                        style: TextStyle(color: Colors.grey, fontSize: 16)),
                  ],
                ),
                isExpanded: true,
                icon: const Icon(Icons.arrow_forward_ios),
                style: const TextStyle(color: Colors.grey),
                onChanged: (String? value) {},
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Text('Chi nhánh phụ'),
            const SizedBox(height: 10),
            Container(
              color: const Color(0xFFF3F6FF),
              height: 50,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButton<String>(
                underline: const SizedBox.shrink(),
                elevation: 0,
                value: null,
                hint: Text('Chọn chi nhánh phụ',
                    style: TextStyle(color: Colors.grey, fontSize: 16)),
                isExpanded: true,
                icon: const Icon(Icons.arrow_forward_ios),
                style: const TextStyle(color: Colors.grey),
                onChanged: (String? value) {},
                items:
                    list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Text('Thông tin khác'),
            const SizedBox(height: 10),
            Container(
              color: const Color(0xFFF3F6FF),
              height: 50,
              width: double.infinity,
              child: TextFormField(
                cursorColor: backgroundColor,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  //contentPadding: EdgeInsets.zero,
                  contentPadding: EdgeInsets.only(left: 15),
                  hintText: 'Nhập chữ',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Phòng ban'),
            const SizedBox(height: 10),
            Container(
              color: const Color(0xFFF3F6FF),
              height: 50,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButton<String>(
                underline: const SizedBox.shrink(),
                elevation: 0,
                value: null,
                hint: Text('Phòng ban',
                    style: TextStyle(color: Colors.grey, fontSize: 16)),
                isExpanded: true,
                icon: const Icon(Icons.arrow_forward_ios),
                style: const TextStyle(color: Colors.grey),
                onChanged: (String? value) {},
                items:
                    list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Text('Nhân viên'),
            const SizedBox(height: 10),
            Container(
              color: const Color(0xFFF3F6FF),
              height: 50,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButton<String>(
                underline: const SizedBox.shrink(),
                elevation: 0,
                value: null,
                hint: Text('Nhân viên',
                    style: TextStyle(color: Colors.grey, fontSize: 16)),
                isExpanded: true,
                icon: const Icon(Icons.arrow_forward_ios),
                style: const TextStyle(color: Colors.grey),
                onChanged: (String? value) {},
                items:
                    list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Chia sẻ vị trí'),
                Switch.adaptive(
                    value: false,
                    activeTrackColor: mainColor,
                    activeColor: Colors.white,
                    onChanged: (newValue) {})
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
