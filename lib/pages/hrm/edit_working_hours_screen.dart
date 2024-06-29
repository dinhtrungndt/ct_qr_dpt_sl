import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../config/color.dart';

import 'check_in_screen.dart';
import '../../method/hrm_method.dart';

class EditWorkingHoursScreen extends StatelessWidget {
  const EditWorkingHoursScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.5,
        title: const Text(
          'Chỉnh sửa giờ công',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFF3F6FF),
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.only(left: 10),
                  height: 50,
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: TextFormField(
                          cursorColor: backgroundColor,
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(
                            //contentPadding: EdgeInsets.zero,
                            contentPadding: EdgeInsets.only(left: 15),
                            hintText: 'Tìm kiếm',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: const Color(0xFFdce7f9),
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(Icons.tune),
              )
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _builPersonnel(context, 'trung nguyen', 'Giám đốc'),
                  Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey[300]),
                  _builPersonnel(context, 'Nhân viên demo', 'Nhân viên'),
                  Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey[300]),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

Widget _builPersonnel(BuildContext context, String name, String position) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CheckInScreen(
                  name: name,
                )),
      );
    },
    child: Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: const Color(0xFFB3C0E0),
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              acronymName(name),
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name),
              const SizedBox(
                height: 5,
              ),
              Text(
                position,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          )),
          Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            child: Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: Colors.grey,
            ),
          )
        ],
      ),
    ),
  );
}
