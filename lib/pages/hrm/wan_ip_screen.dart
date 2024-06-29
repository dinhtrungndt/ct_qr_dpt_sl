import 'package:erp/config/color.dart';
import 'package:flutter/material.dart';

class WanIPScreen extends StatelessWidget {
  const WanIPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> list = [];
    // List<String> branchList = [];
    // List<String> subBranchList = [];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 1,
        title: const Text('Wan IP', style: TextStyle(color: blueBlack)),
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
                Text('Tên Wan IP', style: TextStyle(color: blueGrey1)),
                Text(
                  ' *',
                  style: TextStyle(color: Colors.red),
                )
              ],
            ),
            const SizedBox(height: 10),
            Container(
              color: const Color(0xFFF3F6FF),
              height: 45,
              width: double.infinity,
              child: TextFormField(
                cursorColor: backgroundColor,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  //contentPadding: EdgeInsets.zero,
                  contentPadding: EdgeInsets.only(left: 15),
                  hintText: 'Nhập chữ',
                  hintStyle: TextStyle(color: blueGrey2),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: const [
                Text('Chi nhánh', style: TextStyle(color: blueGrey1)),
                Text(' *', style: TextStyle(color: Colors.red))
              ],
            ),
            const SizedBox(height: 10),
            Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFF3F6FF),
                    borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 45,
                width: double.infinity,
                child: Row(
                  children: const [
                    Text('* ', style: TextStyle(color: Colors.red)),
                    Expanded(
                        child: Text(
                      'Chọn chi nhánh',
                      style: TextStyle(color: blueGrey2, fontSize: 16),
                    )),
                    Icon(Icons.arrow_forward_ios, color: blueGrey1, size: 22)
                  ],
                )),
            const SizedBox(height: 20),
            const Text('Chi nhánh phụ', style: TextStyle(color: blueGrey1)),
            const SizedBox(height: 10),
            Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFF3F6FF),
                    borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 45,
                width: double.infinity,
                child: Row(
                  children: const [
                    Expanded(
                        child: Text(
                      'Chọn chi nhánh phụ',
                      style: TextStyle(color: blueGrey2, fontSize: 16),
                    )),
                    Icon(Icons.arrow_forward_ios, color: blueGrey1, size: 22)
                  ],
                )),
            const SizedBox(height: 20),
            Row(
              children: const [
                Text('Wan IP', style: TextStyle(color: blueGrey1)),
                Text(' *', style: TextStyle(color: Colors.red))
              ],
            ),
            const SizedBox(height: 10),
            Container(
              color: const Color(0xFFF3F6FF),
              height: 45,
              width: double.infinity,
              child: TextFormField(
                cursorColor: backgroundColor,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  //contentPadding: EdgeInsets.zero,
                  contentPadding: EdgeInsets.only(left: 15),
                  hintText: 'Vui lòng nhập chính xác Wan IP',
                  hintStyle: TextStyle(color: blueGrey2),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              child: Text('Lấy Wan IP hiên tại',
                  style: TextStyle(
                      color: mainColor,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                      fontStyle: FontStyle.italic)),
              onTap: () {},
            )
          ]),
        ),
      ),
    );
  }
}
