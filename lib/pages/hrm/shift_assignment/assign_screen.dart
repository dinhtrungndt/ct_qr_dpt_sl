import 'package:erp/base/screen/choose_employee.dart';
import 'package:erp/base/widget/loading.dart';
import 'package:erp/method/hrm_method.dart';
import 'package:erp/model/login_model.dart';
import 'package:erp/pages/hrm/shift_assignment/bloc/shift_assignment_bloc.dart';
import 'package:erp/base/screen/choose_shift_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AssignScreen extends StatefulWidget {
  DateTime date;
  AssignScreen({super.key, required this.date});

  @override
  State<AssignScreen> createState() => _AssignScreenState();
}

class _AssignScreenState extends State<AssignScreen> {
  late ShiftAssignmentBloc shiftAssignmentBloc;

  @override
  void initState() {
    shiftAssignmentBloc = BlocProvider.of<ShiftAssignmentBloc>(context);
    shiftAssignmentBloc.add(ShiftAssignmentInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShiftAssignmentBloc, ShiftAssignmentState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: blueBlack),
            elevation: 1,
            title: Text(
              '${DateFormat('EEEE', AppLocalizations.of(context)!.languageCode).format(widget.date)}, ${DateFormat('dd/MM/yyyy').format(widget.date)}',
            ),
            actions: [
              InkWell(
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  alignment: Alignment.center,
                  child: Text(AppLocalizations.of(context)!.create,
                      style: const TextStyle(color: mainColor)),
                ),
                onTap: () {
                  shiftAssignmentBloc
                      .add(AddWorkPlanEvent(dateApply: widget.date));
                },
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: state.status == Status.loading
                ? const Loading()
                : SingleChildScrollView(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!.shift,
                          style: const TextStyle(color: blueGrey1)),
                      const SizedBox(height: 10),
                      Container(
                        alignment: Alignment.center,
                        child: InkWell(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF3F6FF),
                                  borderRadius: BorderRadius.circular(5)),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: 45,
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: state.shiftModel == null
                                          ? Text(
                                              AppLocalizations.of(context)!
                                                  .chooseShift,
                                              style: const TextStyle(
                                                  color: blueGrey2,
                                                  fontSize: 16))
                                          : Text(
                                              capitalize(
                                                  state.shiftModel!.title),
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: blueBlack,
                                                  fontSize: 16))),
                                  const Icon(Icons.arrow_forward_ios,
                                      color: blueGrey1, size: 22)
                                ],
                              )),
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChooseShiftScreen(
                                        listShiftModel: state.listShiftModel,
                                        screen: 'shift_assignment',
                                      )),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(AppLocalizations.of(context)!.employee,
                          style: const TextStyle(color: blueGrey1)),
                      const SizedBox(height: 10),
                      Container(
                        alignment: Alignment.center,
                        child: InkWell(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF3F6FF),
                                  borderRadius: BorderRadius.circular(5)),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: 45,
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: state.employeeID == null
                                          ? Text(
                                              AppLocalizations.of(context)!
                                                  .chooseEmployee,
                                              style: const TextStyle(
                                                  color: blueGrey2,
                                                  fontSize: 16))
                                          : Text(User.name,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: blueBlack,
                                                  fontSize: 16))),
                                  const Icon(Icons.arrow_forward_ios,
                                      color: blueGrey1, size: 22)
                                ],
                              )),
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ChooseEmployeeScreen(
                                          screen: 'shift_assignment')),
                            );
                          },
                        ),
                      ),
                    ],
                  )),
          ),
        );
      },
    );
  }

  Container textFieldMethod(BuildContext context, String hintText) {
    return Container(
      color: const Color(0xFFF3F6FF),
      height: 50,
      width: MediaQuery.of(context).size.width / 2 - 20,
      child: TextFormField(
        cursorColor: backgroundColor,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 15),
          hintText: hintText,
          hintStyle: const TextStyle(color: blueGrey2),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
