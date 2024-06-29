import 'package:erp/base/widget/timePicker.dart';
import 'package:erp/config/color.dart';
import 'package:erp/model/hrm_model/shift_model.dart';
import 'package:erp/pages/hrm/shift/bloc/shift_bloc.dart';
import 'package:erp/pages/hrm/shift/shift_screen.dart';
import 'package:erp/widget/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditShiftScreen extends StatefulWidget {
  ShiftModel? shiftModel;
  EditShiftScreen({super.key, this.shiftModel});

  @override
  State<EditShiftScreen> createState() => _EditShiftScreenState();
}

class _EditShiftScreenState extends State<EditShiftScreen> {
  List day = [false, false, false, false, false, false, false];
  late ShiftBloc shiftBloc;
  TextEditingController codeController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    shiftBloc = BlocProvider.of<ShiftBloc>(context);
    if (widget.shiftModel != null) {
      codeController.text = widget.shiftModel?.code ?? '';
      titleController.text = widget.shiftModel?.title ?? '';
      shiftBloc.add(EditShiftEvent(model: widget.shiftModel!));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShiftBloc, ShiftState>(
        listener: (context, state) {
          if (state.sendStatus == ShiftStatus.lack) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return closeDialog(
                      context, 'Thông báo', 'Vui lòng điền đầy đủ thông tin');
                });
          } else if (state.sendStatus == ShiftStatus.failure) {
            EasyLoading.showError('Save fail');
          } else if (state.sendStatus == ShiftStatus.success) {
            EasyLoading.showSuccess('Save success');
            shiftBloc.add(ResetStateEvent());
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              AppLocalizations.of(context)!.shift,
              style: const TextStyle(color: Colors.black),
            ),
            iconTheme: const IconThemeData(color: Colors.black),
            elevation: 0,
            actions: [
              InkWell(
                child: Center(
                    child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Text(
                          AppLocalizations.of(context)!.save,
                          style: const TextStyle(color: mainColor),
                        ))),
                onTap: () {
                  shiftBloc.add(SendShiftEvent(
                      id: widget.shiftModel?.id,
                      code: codeController.text,
                      title: titleController.text));
                },
              )
            ],
          ),
          body: BlocBuilder<ShiftBloc, ShiftState>(
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.shiftCode,
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                const Text(' *',
                                    style: TextStyle(color: Colors.red))
                              ],
                            ),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                  color: backgroundColor.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(5)),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: 50,
                              width: double.infinity,
                              child: TextFormField(
                                controller: codeController,
                                cursorColor: backgroundColor,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  hintText:
                                      AppLocalizations.of(context)!.enterText,
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.shiftName,
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                const Text(' *',
                                    style: TextStyle(color: Colors.red))
                              ],
                            ),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                  color: backgroundColor.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(5)),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: 50,
                              width: double.infinity,
                              child: TextFormField(
                                controller: titleController,
                                cursorColor: backgroundColor,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  hintText:
                                      AppLocalizations.of(context)!.enterText,
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Container(
                              decoration: BoxDecoration(
                                  color: mainColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(5)),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: 50,
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppLocalizations.of(context)!.workTime,
                                style: TextStyle(
                                    color: blueBlack.withOpacity(0.7)),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.start,
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                const Text(' *',
                                    style: TextStyle(color: Colors.red))
                              ],
                            ),
                            const SizedBox(height: 10),
                            TimePickerWidget(
                              state: state.fromTime,
                              onSelectTime: () async {
                                final TimeOfDay? timeOfDay =
                                    await showTimePicker(
                                  initialEntryMode: TimePickerEntryMode.input,
                                  context: context,
                                  initialTime: state.fromTime == null
                                      ? TimeOfDay.now()
                                      : TimeOfDay.fromDateTime(state.fromTime!),
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
                                  shiftBloc.add(ChooseFromTimeEvent(
                                      fromTime: DateTime(2023, 01, 01,
                                          timeOfDay.hour, timeOfDay.minute)));
                                }
                              },
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.end,
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                const Text(' *',
                                    style: TextStyle(color: Colors.red))
                              ],
                            ),
                            const SizedBox(height: 10),
                            TimePickerWidget(
                              state: state.toTime,
                              onSelectTime: () async {
                                final TimeOfDay? timeOfDay =
                                    await showTimePicker(
                                  initialEntryMode: TimePickerEntryMode.input,
                                  context: context,
                                  initialTime: state.toTime == null
                                      ? TimeOfDay.now()
                                      : TimeOfDay.fromDateTime(state.toTime!),
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
                                  shiftBloc.add(ChooseToTimeEvent(
                                      toTime: DateTime(2023, 01, 01,
                                          timeOfDay.hour, timeOfDay.minute)));
                                }
                              },
                            ),
                            const SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                  color: mainColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(5)),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: 50,
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppLocalizations.of(context)!.breakTime,
                                style: TextStyle(
                                    color: blueBlack.withOpacity(0.7)),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(AppLocalizations.of(context)!.startBreak,
                                style: TextStyle(color: Colors.grey[600])),
                            const SizedBox(height: 10),
                            TimePickerWidget(
                              state: state.startBreak,
                              onSelectTime: () async {
                                final TimeOfDay? timeOfDay =
                                    await showTimePicker(
                                  initialEntryMode: TimePickerEntryMode.input,
                                  context: context,
                                  initialTime: state.startBreak == null
                                      ? TimeOfDay.now()
                                      : TimeOfDay.fromDateTime(
                                          state.startBreak!),
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
                                  shiftBloc.add(ChooseStartBreakEvent(
                                      startBreak: DateTime(2023, 01, 01,
                                          timeOfDay.hour, timeOfDay.minute)));
                                }
                              },
                            ),
                            const SizedBox(height: 20),
                            Text(AppLocalizations.of(context)!.endBreak,
                                style: TextStyle(color: Colors.grey[600])),
                            const SizedBox(height: 10),
                            TimePickerWidget(
                              state: state.endBreak,
                              onSelectTime: () async {
                                final TimeOfDay? timeOfDay =
                                    await showTimePicker(
                                  initialEntryMode: TimePickerEntryMode.input,
                                  context: context,
                                  initialTime: state.endBreak == null
                                      ? TimeOfDay.now()
                                      : TimeOfDay.fromDateTime(state.endBreak!),
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
                                  shiftBloc.add(ChooseEndBreakEvent(
                                      endBreak: DateTime(2023, 01, 01,
                                          timeOfDay.hour, timeOfDay.minute)));
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
