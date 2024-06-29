import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../model/hrm_model/attendance_model.dart';
import '../../../config/color.dart';
import '../../../method/hrm_method.dart';

class ShiftInformationScreen extends StatelessWidget {
  const ShiftInformationScreen(
      {super.key, required this.attendanceModel, required this.edit});
  final AttendanceModel attendanceModel;
  final bool edit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Chi tiết',
            style: TextStyle(color: blueBlack),
          ),
          iconTheme: const IconThemeData(color: blueBlack),
          elevation: 1,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10),
                height: 50,
                alignment: Alignment.centerLeft,
                width: double.infinity,
                color: mainColor.withOpacity(0.1),
                child: Text(
                  'THÔNG TIN CA LÀM',
                  style: TextStyle(color: blueBlack.withOpacity(0.8)),
                ),
              ),
              buildShiftInformationList(attendanceModel),
              Container(
                padding: const EdgeInsets.only(left: 10),
                height: 50,
                alignment: Alignment.centerLeft,
                width: double.infinity,
                color: mainColor.withOpacity(0.1),
                child: Text(
                  'THÔNG TIN CHẤM CÔNG',
                  style: TextStyle(color: blueBlack.withOpacity(0.8)),
                ),
              ),
              buildShiftInformationItem(
                  'Giờ chấm công vào',
                  attendanceModel.checkin == null
                      ? '--:--'
                      : attendanceModel.checkin!.substring(0, 5)),
              Container(
                  height: 1, width: double.infinity, color: Colors.grey[300]),
              buildShiftInformationItem(
                  'Giờ chấm công ra',
                  attendanceModel.checkout == null
                      ? '--:--'
                      : attendanceModel.checkout!.substring(0, 5)),
              (edit)
                  ? Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              // primary: mainColor,
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.zero,
                              side:
                                  const BorderSide(color: Colors.red, width: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Text('Xóa',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red)),
                            onPressed: () {}),
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ));
  }
}

Widget buildShiftInformationList(AttendanceModel attendanceModel) {
  return Column(
    children: [
      buildShiftInformationItem(
          'Tên ca làm', capitalize(attendanceModel.shift)),
      Container(height: 1, width: double.infinity, color: Colors.grey[300]),
      buildShiftInformationItem('Múi giờ', 'Asia/Ho_Chi_Minh(GMT+07:00)'),
      Container(height: 1, width: double.infinity, color: Colors.grey[300]),
      buildShiftInformationItem('Giờ bắt đầu',
          '${DateFormat('dd/MM/yyyy').format(attendanceModel.day)} ${attendanceModel.startShift.substring(0, 5)}'),
      Container(height: 1, width: double.infinity, color: Colors.grey[300]),
      buildShiftInformationItem('Giờ kết thúc',
          '${DateFormat('dd/MM/yyyy').format(attendanceModel.day)} ${attendanceModel.endShift.substring(0, 5)}'),
      Container(height: 1, width: double.infinity, color: Colors.grey[300]),
      // buildShiftInformationItem('Giờ tính công vào', ''),
      // Container(height: 1, width: double.infinity, color: Colors.grey[300]),
      // buildShiftInformationItem('Giờ tính công ra', ''),
      // Container(height: 1, width: double.infinity, color: Colors.grey[300]),
      buildShiftInformationItem('Cho phép đi muộn sau', '0 phút'),
      Container(height: 1, width: double.infinity, color: Colors.grey[300]),
      buildShiftInformationItem('Cho phép về sớm trước', '0 phút'),
      Container(height: 1, width: double.infinity, color: Colors.grey[300]),
      // buildShiftInformationItem('Chi nhánh', 'Vietgoat'),
    ],
  );
}

Widget buildShiftInformationItem(String name, String value) {
  return Container(
    height: 50,
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            name,
            style: const TextStyle(color: blueGrey1, fontSize: 16),
          ),
        ),
        Text(
          value,
          style: TextStyle(color: blueBlack),
        ),
      ],
    ),
  );
}
