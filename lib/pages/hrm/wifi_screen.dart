import 'package:erp/config/color.dart';
import 'package:flutter/material.dart';



class WifiScreen extends StatelessWidget {
  const WifiScreen({super.key});

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
        title: const Text('Wifi', style: TextStyle(color: blueBlack)),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Text('Wifi', style: TextStyle(color: blueGrey1)),
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
                  Text('BSSID', style: TextStyle(color: blueGrey1)),
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
              // Container(
              //   color: const Color(0xFFF3F6FF),
              //   height: 45,
              //   width: double.infinity,
              //   padding: const EdgeInsets.symmetric(horizontal: 10),
              //   child: DropdownButton<String>(
              //     underline: const SizedBox.shrink(),
              //     elevation: 0,
              //     value: null,
              //     hint: Row(
              //       children: [
              //         Text('* ', style: TextStyle(color: Colors.red)),
              //         Text('Chọn chi nhánh',
              //             style: TextStyle(color: blueGrey2, fontSize: 16)),
              //       ],
              //     ),
              //     isExpanded: true,
              //     icon: const Icon(Icons.arrow_forward_ios, color: blueGrey1),
              //     style: const TextStyle(color: Colors.grey),
              //     onChanged: (String? value) {},
              //     items: list.map<DropdownMenuItem<String>>((String value) {
              //       return DropdownMenuItem<String>(
              //         value: value,
              //         child: Text(value),
              //       );
              //     }).toList(),
              //   ),
              // ),
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
                        'Chi nhánh phụ',
                        style: TextStyle(color: blueGrey2, fontSize: 16),
                      )),
                      Icon(Icons.arrow_forward_ios, color: blueGrey1, size: 22)
                    ],
                  )),
              const SizedBox(height: 20),

              const Text('Phòng ban', style: TextStyle(color: blueGrey1)),
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
                        'Phòng ban',
                        style: TextStyle(color: blueGrey2, fontSize: 16),
                      )),
                      Icon(Icons.arrow_forward_ios, color: blueGrey1, size: 22)
                    ],
                  )),
              const SizedBox(height: 20),
              const Text('Nhân viên', style: TextStyle(color: blueGrey1)),
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
                        'Nhân viên',
                        style: TextStyle(color: blueGrey2, fontSize: 16),
                      )),
                      Icon(Icons.arrow_forward_ios, color: blueGrey1, size: 22)
                    ],
                  )),
              const SizedBox(height: 20),
              const Text('Chọn phương thức chấm công',
                  style: TextStyle(color: blueGrey1)),
              const SizedBox(height: 10),
              Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFF3F6FF),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: mainColor,width: 1)),
                 // padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 45,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Radio<int>(
                        value: 1,
                        activeColor: mainColor,
                        groupValue: 1,
                        onChanged: (intdex) {},
                      ),
                      const Expanded(
                          child: Text(
                        'Dựa vào tên Wifi',
                        style: TextStyle(color: blueBlack, fontSize: 16),
                      )),
                    ],
                  )),
              const SizedBox(height: 10),
              Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFF3F6FF),
                      borderRadius: BorderRadius.circular(5)),
                  //padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 45,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Radio<int>(
                        value: 2,
                        activeColor: mainColor,
                        groupValue: 1,
                        onChanged: (intdex) {},
                      ),
                      const Expanded(
                          child: Text(
                        'Dựa vào tên Wifi và BSSID',
                        style: TextStyle(color: blueBlack, fontSize: 16),
                      )),
                    ],
                  )),
              const SizedBox(height: 20),
              InkWell(
                child: Text('Lấy thông tin Wifi hiên tại',
                    style: TextStyle(
                        color: mainColor,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        fontStyle: FontStyle.italic)),
                onTap: () {},
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
