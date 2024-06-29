import 'package:erp/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../infor_screen.dart';

class AddPersonnelScreen extends StatefulWidget {
  const AddPersonnelScreen({super.key});

  @override
  State<AddPersonnelScreen> createState() => _AddPersonnelScreenState();
}

class _AddPersonnelScreenState extends State<AddPersonnelScreen> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Thêm nhân viên',
          style: TextStyle(color: blueBlack),
        ),
        iconTheme: IconThemeData(color: blueBlack),
        elevation: 0,
        actions: [
          InkWell(
            child: Center(
                child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Text(
                      'THÊM',
                      style: TextStyle(color: mainColor),
                    ))),
            onTap: () {
              //       Navigator.push(
              // context,
              // MaterialPageRoute(builder: (context) => const InforScreen()),
              //);
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Họ và tên',
                    style: TextStyle(color: blueBlack.withOpacity(0.7)),
                  ),
                  Text(
                    '*',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                color: backgroundColor.withOpacity(0.3),
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                width: double.infinity,
                child: TextFormField(
                  cursorColor: backgroundColor,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    // contentPadding: EdgeInsets.only(top: -17),
                    hintText: 'VD: Nguyễn Văn A',
                    hintStyle: TextStyle(color: blueGrey2),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Số điện thoại',
                    style: TextStyle(color: blueBlack.withOpacity(0.7)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                color: backgroundColor.withOpacity(0.3),
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                width: double.infinity,
                child: TextFormField(
                  cursorColor: backgroundColor,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    // contentPadding: EdgeInsets.only(top: -17),
                    hintText: 'Nhập SĐT của bạn',
                    hintStyle: TextStyle(color: blueGrey2),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: InkWell(
                    onTap: () {
                      setState(() {
                        expanded = !expanded;
                      });
                    },
                    child: Icon(
                        expanded
                            ? Icons.keyboard_arrow_up_outlined
                            : Icons.keyboard_arrow_down_outlined,
                        color: mainColor,
                        size: 40)),
              ),
              Visibility(
                  visible: expanded ? true : false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Email',
                              style:
                                  TextStyle(color: blueBlack.withOpacity(0.7))),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        color: backgroundColor.withOpacity(0.3),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 50,
                        width: double.infinity,
                        child: TextFormField(
                          cursorColor: backgroundColor,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            // contentPadding: EdgeInsets.only(top: -17),
                            hintText: 'Email',
                            hintStyle: TextStyle(color: blueGrey2),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text('Mã nhân viên',
                              style:
                                  TextStyle(color: blueBlack.withOpacity(0.7))),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        color: backgroundColor.withOpacity(0.3),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 50,
                        width: double.infinity,
                        child: TextFormField(
                          cursorColor: backgroundColor,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            // contentPadding: EdgeInsets.only(top: -17),
                            // hintText: 'Email',
                            hintStyle: TextStyle(color: blueGrey2),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text('Ngày sinh',
                              style:
                                  TextStyle(color: blueBlack.withOpacity(0.7))),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        color: backgroundColor.withOpacity(0.3),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 50,
                        width: double.infinity,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'VD: 15-09-1986',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: blueBlack.withOpacity(0.7)),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: blueBlack.withOpacity(0.7),
                                size: 30,
                              )
                            ]),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text('Địa chỉ',
                              style:
                                  TextStyle(color: blueBlack.withOpacity(0.7))),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                          color: backgroundColor.withOpacity(0.3),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 50,
                          width: double.infinity,
                          child: TextFormField(
                            cursorColor: backgroundColor,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              // contentPadding: EdgeInsets.only(top: -17),
                              hintText: 'Địa chỉ',
                              hintStyle: TextStyle(color: blueGrey2),
                              border: InputBorder.none,
                            ),
                          )),
                      const SizedBox(height: 20),
                      Container(
                        color: mainColor.withOpacity(0.1),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 40,
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: Text('HỒ SƠ CÔNG TY',
                            style:
                                TextStyle(color: blueBlack.withOpacity(0.7))),
                      ),
                      const SizedBox(height: 10),
                      Text('Quyền truy cập',
                          style: TextStyle(color: blueBlack.withOpacity(0.7))),
                      const SizedBox(height: 10),
                      Container(
                        color: backgroundColor.withOpacity(0.3),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 50,
                        width: double.infinity,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Quyền truy cập',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: blueBlack.withOpacity(0.7)),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: blueBlack.withOpacity(0.7),
                                size: 20,
                              )
                            ]),
                      ),
                      const SizedBox(height: 20),
                      Text('Vùng',
                          style: TextStyle(color: blueBlack.withOpacity(0.7))),
                      const SizedBox(height: 10),
                      Container(
                        color: backgroundColor.withOpacity(0.3),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 50,
                        width: double.infinity,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Vùng',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: blueBlack.withOpacity(0.7)),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: blueBlack.withOpacity(0.7),
                                size: 20,
                              )
                            ]),
                      ),
                      const SizedBox(height: 20),
                      Text('Chi nhánh',
                          style: TextStyle(color: blueBlack.withOpacity(0.7))),
                      const SizedBox(height: 10),
                      Container(
                        color: backgroundColor.withOpacity(0.3),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 50,
                        width: double.infinity,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Chi nhánh',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: blueBlack.withOpacity(0.7)),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: blueBlack.withOpacity(0.7),
                                size: 20,
                              )
                            ]),
                      ),
                      const SizedBox(height: 20),
                      Text('Phòng ban',
                          style: TextStyle(color: blueBlack.withOpacity(0.7))),
                      const SizedBox(height: 10),
                      Container(
                        color: backgroundColor.withOpacity(0.3),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 50,
                        width: double.infinity,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Phòng ban',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: blueBlack.withOpacity(0.7)),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: blueBlack.withOpacity(0.7),
                                size: 20,
                              )
                            ]),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text('Chức vụ',
                              style:
                                  TextStyle(color: blueBlack.withOpacity(0.7))),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        color: backgroundColor.withOpacity(0.3),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 50,
                        width: double.infinity,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Chức vụ',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: blueBlack.withOpacity(0.7)),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: blueBlack.withOpacity(0.7),
                                size: 20,
                              )
                            ]),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildName() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(
            'Họ và tên',
            style: TextStyle(color: blueBlack.withOpacity(0.7)),
          ),
          Text(
            '*',
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Container(
        color: backgroundColor.withOpacity(0.3),
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        width: double.infinity,
        child: TextFormField(
          cursorColor: backgroundColor,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            // contentPadding: EdgeInsets.only(top: -17),
            hintText: 'VD: Nguyễn Văn A',
            hintStyle: TextStyle(color: blueGrey2),
            border: InputBorder.none,
          ),
        ),
      ),
      const SizedBox(height: 20),
      Text(
        'Số điện thoại',
        style: TextStyle(color: blueBlack.withOpacity(0.7)),
      ),
      const SizedBox(height: 10),
      Container(
        color: backgroundColor.withOpacity(0.3),
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        width: double.infinity,
        child: TextFormField(
          cursorColor: backgroundColor,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            // contentPadding: EdgeInsets.only(top: -17),
            hintText: 'Nhập SĐT của bạn',
            hintStyle: TextStyle(color: blueGrey2),
            border: InputBorder.none,
          ),
        ),
      ),
      const SizedBox(height: 10),
      Center(
          child: Icon(
        Icons.keyboard_arrow_down_outlined,
        color: mainColor,
        size: 40,
      )),
      Visibility(
          child: Column(
        children: [],
      ))
    ],
  );
}
