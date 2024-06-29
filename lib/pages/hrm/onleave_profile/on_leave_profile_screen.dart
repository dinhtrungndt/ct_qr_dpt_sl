import 'package:erp/base/widget/loading.dart';
import 'package:erp/model/hrm_model/employee_model.dart';
import 'package:erp/model/hrm_model/on_leave_model.dart';
import 'package:erp/pages/hrm/onleave_profile/bloc/onleave_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/elusive_icons.dart';
import '../../../config/color.dart';

class OnLeaveProfileScreen extends StatefulWidget {
  const OnLeaveProfileScreen({Key? key});

  @override
  State<OnLeaveProfileScreen> createState() => _OnLeaveProfileScreenState();
}

class _OnLeaveProfileScreenState extends State<OnLeaveProfileScreen> {
  late OnleaveProfileBloc onLeaveProfileBloc;

  @override
  void initState() {
    onLeaveProfileBloc = BlocProvider.of<OnleaveProfileBloc>(context);
    onLeaveProfileBloc.add(GetOnLeaveProfileEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(243, 246, 255, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Nghỉ phép',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: BlocBuilder<OnleaveProfileBloc, OnleaveProfileState>(
        builder: (context, state) {
          if (state is OnleaveProfileSuccess) {
            return Container(
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Colors.white,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                buildOnLeaveItem(Elusive.calendar, 'Tổng số ngày được hưởng',
                    state.onleaveProfile.dayEarn),
                const SizedBox(height: 10),
                buildOnLeaveItem(Elusive.calendar, 'Số ngày phép đã sử dụng',
                    state.onleaveProfile.dayBreak),
                const SizedBox(height: 10),
                buildOnLeaveItem(Elusive.calendar, 'Phép đang chờ duyệt',
                    state.onleaveProfile.pendingPermit),
                const SizedBox(height: 10),
                buildOnLeaveItem(
                    Elusive.calendar,
                    'Thưởng phép theo năm làm việc',
                    state.onleaveProfile.bonus),
                const SizedBox(height: 10),
                buildOnLeaveItem(Elusive.calendar, 'Số dư kỳ trước',
                    state.onleaveProfile.previousSurplus),
                const SizedBox(height: 10),
                buildOnLeaveItem(Elusive.calendar, 'Số ngày phép được ứng',
                    state.onleaveProfile.advance),
                const SizedBox(height: 10),
                buildOnLeaveItem(Elusive.calendar, 'Số ngày phép còn lại',
                    state.onleaveProfile.surplus),
              ]),
            );
          } else {
            return Loading();
          }
        },
      ),
    );
  }
}

Widget buildOnLeaveItem(IconData icon, String name, double day) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: [
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            name,
            style: const TextStyle(fontSize: 17, color: Colors.black54),
          ),
        ),
        Text(day.toString()),
        const SizedBox(width: 5),
        // const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey)
      ],
    ),
  );
}
