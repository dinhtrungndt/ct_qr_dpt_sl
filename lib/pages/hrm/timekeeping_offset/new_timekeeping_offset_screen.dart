import 'package:erp/base/widget/datePicker.dart';
import 'package:erp/base/widget/loading.dart';
import 'package:erp/base/widget/timePicker.dart';
import 'package:erp/model/hrm_model/request_management_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:fluttericon/entypo_icons.dart';

import '../../../config/color.dart';
import '../../../method/hrm_method.dart';
import '../../../widget/dialog.dart';
import '../request_management/bloc/request_management_bloc.dart';
import 'bloc/timekeeping_offset_bloc.dart';
import '../../../base/screen/choose_shift_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewTimekeepingOffsetScreen extends StatefulWidget {
  TimekeepingOffsetRequestModel? timekeepingOffsetModel;
  NewTimekeepingOffsetScreen({super.key, this.timekeepingOffsetModel});

  @override
  State<NewTimekeepingOffsetScreen> createState() =>
      _NewTimekeepingOffsetScreenState();
}

class _NewTimekeepingOffsetScreenState
    extends State<NewTimekeepingOffsetScreen> {
  TextEditingController noteController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  late TimekeepingOffsetBloc timekeepingBloc;
  DateTime applyDateChange = DateTime.now();
  @override
  void initState() {
    if (widget.timekeepingOffsetModel?.id != null) {
      noteController.text = widget.timekeepingOffsetModel!.note;
      reasonController.text = widget.timekeepingOffsetModel!.reason;
    }
    timekeepingBloc = BlocProvider.of<TimekeepingOffsetBloc>(context);
    timekeepingBloc.add(InitialTimekeepingOffsetEvent(
        timekeepingOffsetModel: widget.timekeepingOffsetModel));
    super.initState();
  }

  @override
  void dispose() {
    noteController.dispose();
    reasonController.dispose();
    super.dispose();
  }

  TimeOfDay fromTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocListener<TimekeepingOffsetBloc, TimekeepingOffsetState>(
        listener: (context, state) {
          if (state.sendStatus == SendTimekeepingOffsetStatus.lack) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return closeDialog(
                      context, 'Thông báo', 'Vui lòng điền đầy đủ thông tin');
                });
          } else if (state.sendStatus == SendTimekeepingOffsetStatus.failure) {
            EasyLoading.showError('Gửi yêu cầu thất bại');
          } else if (state.sendStatus == SendTimekeepingOffsetStatus.success) {
            Navigator.pop(context);
            EasyLoading.showSuccess('Gửi yêu cầu thành công');
            BlocProvider.of<RequestManagementBloc>(context)
                .add(RequestManagementLoadEvent());
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: blueBlack),
            elevation: 0,
            title: Text(AppLocalizations.of(context)!.timekeepingOffset,
                style: const TextStyle(color: blueBlack)),
            actions: [
              InkWell(
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  alignment: Alignment.center,
                  child: Text(AppLocalizations.of(context)!.create,
                      style: const TextStyle(color: mainColor, fontSize: 16)),
                ),
                onTap: () {
                  timekeepingBloc.add(SendTimekeepingOffsetEvent(
                      id: widget.timekeepingOffsetModel?.id!,
                      reason: reasonController.text,
                      note: noteController.text));
                },
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: BlocBuilder<TimekeepingOffsetBloc, TimekeepingOffsetState>(
                builder: (context, state) {
              return state.sendStatus == SendTimekeepingOffsetStatus.loading
                  ? const Loading()
                  : SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(AppLocalizations.of(context)!.shift,
                                    style: const TextStyle(color: blueGrey1)),
                                const Text(
                                  ' *',
                                  style: TextStyle(color: Colors.red),
                                )
                              ],
                            ),
                            const SizedBox(height: 5),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChooseShiftScreen(
                                            listShiftModel:
                                                state.listShiftModel,
                                            screen: 'timekeeping_offset',
                                          )),
                                );
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFF3F6FF),
                                      borderRadius: BorderRadius.circular(5)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  height: 50,
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Icon(
                                        Entypo.layout,
                                        color: blueGrey2,
                                        size: 25,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: state.shiftModel == null
                                            ? Text(
                                                AppLocalizations.of(context)!
                                                    .shift,
                                                style: const TextStyle(
                                                    color: blueGrey2,
                                                    fontSize: 16),
                                              )
                                            : Text(
                                                capitalize(
                                                    state.shiftModel!.title),
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: blueBlack,
                                                    fontSize: 16),
                                              ),
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: blueGrey1,
                                        size: 30,
                                      )
                                    ],
                                  )),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Text(AppLocalizations.of(context)!.applyDate,
                                    style: const TextStyle(color: blueGrey1)),
                                const Text(
                                  ' *',
                                  style: TextStyle(color: Colors.red),
                                )
                              ],
                            ),
                            const SizedBox(height: 5),
                            DatePickerWidget(
                                state: state.applyDate,
                                dateChange: applyDateChange,
                                placeHolder:
                                    AppLocalizations.of(context)!.applyDate,
                                onClickDone: () {
                                  Navigator.pop(context);
                                  timekeepingBloc.add(ChooseApplyDateEvent(
                                      applyDate: applyDateChange));
                                }),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Text(AppLocalizations.of(context)!.timeStart,
                                    style: const TextStyle(color: blueGrey1)),
                                const Text(
                                  ' *',
                                  style: TextStyle(color: Colors.red),
                                )
                              ],
                            ),
                            const SizedBox(height: 5),
                            TimePickerWidget(
                              state: state.fromTime,
                              onSelectTime: () async {
                                final TimeOfDay? timeOfDay =
                                    await showTimePicker(
                                  initialEntryMode: TimePickerEntryMode.input,
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context)!.copyWith(
                                          alwaysUse24HourFormat: true),
                                      child: child!,
                                    );
                                  },
                                );
                                if (timeOfDay != null) {
                                  timekeepingBloc.add(ChooseFromTimeEvent(
                                      fromTime: DateTime(2023, 01, 01,
                                          timeOfDay.hour, timeOfDay.minute)));
                                }
                              },
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Text(AppLocalizations.of(context)!.timeEnd,
                                    style: const TextStyle(color: blueGrey1)),
                                const Text(
                                  ' *',
                                  style: TextStyle(color: Colors.red),
                                )
                              ],
                            ),
                            const SizedBox(height: 5),
                            TimePickerWidget(
                              state: state.toTime,
                              onSelectTime: () async {
                                final TimeOfDay? timeOfDay =
                                    await showTimePicker(
                                  initialEntryMode: TimePickerEntryMode.input,
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context)!.copyWith(
                                          alwaysUse24HourFormat: true),
                                      child: child!,
                                    );
                                  },
                                );
                                if (timeOfDay != null) {
                                  timekeepingBloc.add(ChooseToTimeEvent(
                                      toTime: DateTime(2023, 01, 01,
                                          timeOfDay.hour, timeOfDay.minute)));
                                }
                              },
                            ),
                            const SizedBox(height: 15),
                            Text(AppLocalizations.of(context)!.reason,
                                style: const TextStyle(color: blueGrey1)),
                            const SizedBox(height: 5),
                            Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF3F6FF),
                                  borderRadius: BorderRadius.circular(5)),
                              height: 50,
                              alignment: Alignment.center,
                              child: TextFormField(
                                controller: reasonController,
                                cursorColor: blueBlack,
                                style: const TextStyle(
                                    color: blueBlack, fontSize: 16),
                                keyboardType: TextInputType.text,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(left: 15),
                                  hintText: '',
                                  hintStyle:
                                      TextStyle(color: blueGrey2, fontSize: 16),
                                  border: InputBorder.none,
                                ),
                                inputFormatters: [],
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(AppLocalizations.of(context)!.note,
                                style: const TextStyle(color: blueGrey1)),
                            const SizedBox(height: 5),
                            Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF3F6FF),
                                  borderRadius: BorderRadius.circular(5)),
                              height: 100,
                              child: TextFormField(
                                controller: noteController,
                                cursorColor: blueBlack,
                                style: const TextStyle(
                                    color: blueBlack, fontSize: 16),
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: 15, top: 5),
                                  hintText: '',
                                  hintStyle:
                                      TextStyle(color: blueGrey2, fontSize: 16),
                                  border: InputBorder.none,
                                ),
                                inputFormatters: [],
                              ),
                            ),
                          ]),
                    );
            }),
          ),
        ),
      ),
    );
  }
}
