import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../config/color.dart';


class InforScreen extends StatelessWidget {
  const InforScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF2FBF8),
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          title: const Text(
            'Thông tin',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            InkWell(
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                child: Text(
                  'LƯU',
                  style: TextStyle(color: mainColor),
                ),
              ),
              onTap: () {},
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              height: 40,
              child: TabBar(
                  labelColor: mainColor,
                  indicatorColor: mainColor,
                  unselectedLabelColor: Colors.grey[400],
                  padding: const EdgeInsets.all(0),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 0),
                  tabs: const [
                    Tab(
                        child:
                            Text('Thông tin', style: TextStyle(fontSize: 16))),
                    Tab(
                        child:
                            Text('Thiết bị', style: TextStyle(fontSize: 16))),
                  ]),
            ),
            Expanded(
                child: Container(
                    color: mainColor.withOpacity(0.15),
                    child: TabBarView(children: [buildInfor(), buildDivice()])))
          ],
        ),
      ),
    );
  }
}

Widget buildInfor() {
  List<String> list = [];
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Container(
        height: 50,
        padding: const EdgeInsets.only(left: 10),
        alignment: Alignment.centerLeft,
        child: const Text('THÔNG TIN CÁ NHÂN',
            style: TextStyle(color: Colors.grey))),
    Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Họ và tên',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
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
                    hintText: 'VD: Nguyễn Văn A',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('Số điện thoại', style: TextStyle(color: Colors.grey[600])),
              const SizedBox(height: 10),
              Container(
                color: const Color(0xFFF3F6FF),
                height: 50,
                width: double.infinity,
                child: TextFormField(
                  cursorColor: backgroundColor,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15),
                    hintText: 'Nhập số điện thoại của bạn',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    LengthLimitingTextInputFormatter(11),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text('Email', style: TextStyle(color: Colors.grey[600])),
              const SizedBox(height: 10),
              Container(
                color: const Color(0xFFF3F6FF),
                height: 50,
                width: double.infinity,
                child: TextFormField(
                  cursorColor: backgroundColor,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15),
                    hintText: 'Nhập email của bạn',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('Mã nhân viên', style: TextStyle(color: Colors.grey[600])),
              const SizedBox(height: 10),
              Container(
                color: const Color(0xFFF3F6FF),
                height: 50,
                width: double.infinity,
                child: TextFormField(
                  cursorColor: backgroundColor,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15),
                    hintText: 'Mã nhân viên',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text('Ngày sinh', style: TextStyle(color: Colors.grey[600])),
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
                  hint: Text('VD: 11-11-1991',
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down_outlined, size: 30),
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
              Text('Địa chỉ', style: TextStyle(color: Colors.grey[600])),
              const SizedBox(height: 10),
              Container(
                color: const Color(0xFFF3F6FF),
                height: 50,
                width: double.infinity,
                child: TextFormField(
                  cursorColor: backgroundColor,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15),
                    hintText: 'Địa chỉ',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
               
            ],
          ),
        ),
      ),
    )
  ]);
}

Widget buildDivice() {
  return SingleChildScrollView(
    child: Column(children: [
      Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            SizedBox(
                width: 40,
                child: Text('STT', style: TextStyle(color: Colors.grey[600]))),
            Expanded(
                child: Text('Tên', style: TextStyle(color: Colors.grey[600]))),
            SizedBox(
                width: 80,
                child: Text('Hệ điều hành',
                    style: TextStyle(color: Colors.grey[600]))),
            const SizedBox(width: 50)
          ],
        ),
      ),
      buildDiviceItem(1, 'S22 Ultra', 'Android')
    ]),
  );
}

Widget buildDiviceItem(int id, String name, String operatingSystem) {
  return Container(
    height: 55,
    color: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      children: [
        SizedBox(
            width: 40,
            child: Text('$id', style: const TextStyle(color: Colors.grey))),
        Expanded(child: Text(name, style: const TextStyle(color: Colors.grey))),
        SizedBox(
            width: 80,
            child: Text(operatingSystem,
                style: const TextStyle(color: Colors.grey))),
         SizedBox(
            width: 50,
            child: InkWell(
              onTap: (){},
              child:const  Icon(
                Icons.delete_forever,
                color: Colors.red,
              ),
            ))
      ],
    ),
  );
}
