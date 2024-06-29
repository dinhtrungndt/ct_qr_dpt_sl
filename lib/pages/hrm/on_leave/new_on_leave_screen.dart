import 'package:erp/base/widget/datePicker.dart';
import 'package:erp/model/hrm_model/request_management_model.dart';
import 'package:erp/pages/hrm/request_management/request_management_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:quickalert/quickalert.dart';

import '../../../config/color.dart';
import '../../../method/hrm_method.dart';
import '../../../widget/dialog.dart';
import 'bloc/on_leave_bloc.dart';
import 'chosse_on_leave_kind_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewOnLeaveScreen extends StatefulWidget {
  OnLeaveRequestModel? onleaveRequestModel;
  NewOnLeaveScreen({super.key, this.onleaveRequestModel});

  @override
  State<NewOnLeaveScreen> createState() => _NewOnLeaveScreenState();
}

class _NewOnLeaveScreenState extends State<NewOnLeaveScreen> {
  TextEditingController noteController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  late OnLeaveBloc onLeaveBloc;
  DateTime expirationDateChange = DateTime.now();
  DateTime fromDateChange = DateTime.now();
  DateTime toDateChange = DateTime.now();
  @override
  void initState() {
    if (widget.onleaveRequestModel != null) {
      qtyController.text = widget.onleaveRequestModel!.qty.toString();
      noteController.text = widget.onleaveRequestModel!.note ?? "";
    }
    onLeaveBloc = BlocProvider.of<OnLeaveBloc>(context);
    onLeaveBloc.add(InitialOnLeaveEvent(model: widget.onleaveRequestModel));
    super.initState();
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: BlocListener<OnLeaveBloc, OnLeaveState>(
          listener: (context, state) {
            if (state.sendStatus == SendOnLeaveStatus.failure) {
              if (state.error == '4') {
                onLeaveBloc.add(ConfirmAdvanceOnLeaveEvent(
                    id: widget.onleaveRequestModel!.id,
                    note: noteController.text,
                    qty: double.parse(qtyController.text)));

                return;
              } else {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return closeDialog(
                          context, 'Thông báo', getMessage(state.error));
                    });
              }
            } else if (state.sendStatus == SendOnLeaveStatus.success) {
              EasyLoading.showSuccess('Gửi yêu cầu thành công');
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RequestManagementScreen()),
              );
            }
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: blueBlack),
              elevation: 0,
              title: Text(AppLocalizations.of(context)!.onleave,
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
                    if (qtyController.text == null ||
                        qtyController.text.trim() == "") {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return closeDialog(
                                context,
                                AppLocalizations.of(context)!.notification,
                                'Vui lòng chọn số lượng');
                          });
                      return;
                    }
                    onLeaveBloc.add(SendOnLeaveEvent(
                        id: widget.onleaveRequestModel?.id,
                        note: noteController.text,
                        qty: double.parse(qtyController.text)));
                  },
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: BlocBuilder<OnLeaveBloc, OnLeaveState>(
                builder: (context, state) {
                  return state.sendStatus == SendOnLeaveStatus.loading
                      ? const Center(
                          child: CircularProgressIndicator(color: mainColor))
                      : SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                        AppLocalizations.of(context)!
                                            .permissionType,
                                        style:
                                            const TextStyle(color: blueGrey1)),
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
                                            builder: (context) =>
                                                ChooseOnLeaveKindScreen(
                                                  listOnLeaveKindModel: state
                                                      .listOnLeaveKindModel,
                                                )));
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFF3F6FF),
                                          borderRadius:
                                              BorderRadius.circular(5)),
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
                                            child:
                                                state.onLeaveKindModel == null
                                                    ? Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .permissionType,
                                                        style: const TextStyle(
                                                            color: blueGrey2,
                                                            fontSize: 16),
                                                      )
                                                    : Text(
                                                        capitalize(state
                                                            .onLeaveKindModel!
                                                            .name),
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
                                    Text(
                                        AppLocalizations.of(context)!
                                            .expiryDate,
                                        style:
                                            const TextStyle(color: blueGrey1)),
                                    const Text(
                                      ' *',
                                      style: TextStyle(color: Colors.red),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 5),
                                DatePickerWidget(
                                  state: state.expirationDate,
                                  dateChange: expirationDateChange,
                                  placeHolder:
                                      AppLocalizations.of(context)!.expiryDate,
                                  onClickDone: () {
                                    Navigator.pop(context);
                                    onLeaveBloc.add(ChooseExpirationDateEvent(
                                        expirationDate: expirationDateChange));
                                  },
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    Text(
                                        AppLocalizations.of(context)!.startDate,
                                        style:
                                            const TextStyle(color: blueGrey1)),
                                    const Text(
                                      ' *',
                                      style: TextStyle(color: Colors.red),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 5),
                                DatePickerWidget(
                                  state: state.fromDate,
                                  dateChange: fromDateChange,
                                  placeHolder:
                                      AppLocalizations.of(context)!.startDate,
                                  onClickDone: () {
                                    Navigator.pop(context);
                                    onLeaveBloc.add(ChooseFromDateEvent(
                                        fromDate: fromDateChange));
                                  },
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    Text(AppLocalizations.of(context)!.endDate,
                                        style:
                                            const TextStyle(color: blueGrey1)),
                                    const Text(
                                      ' *',
                                      style: TextStyle(color: Colors.red),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 5),
                                DatePickerWidget(
                                    state: state.toDate,
                                    dateChange: toDateChange,
                                    placeHolder:
                                        AppLocalizations.of(context)!.endDate,
                                    onClickDone: () {
                                      Navigator.pop(context);
                                      onLeaveBloc.add(ChooseToDateEvent(
                                          toDate: toDateChange));
                                    }),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    Text(AppLocalizations.of(context)!.qty,
                                        style:
                                            const TextStyle(color: blueGrey1)),
                                    const Text(
                                      ' *',
                                      style: TextStyle(color: Colors.red),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 5),
                                InkWell(
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFF3F6FF),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      height: 50,
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.numbers_outlined,
                                            color: blueGrey2,
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: TextFormField(
                                              controller: qtyController,
                                              keyboardType: const TextInputType
                                                  .numberWithOptions(
                                                  decimal: true),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                const SizedBox(height: 15),
                                Text(AppLocalizations.of(context)!.note,
                                    style: TextStyle(color: blueGrey1)),
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
                                      hintStyle: TextStyle(
                                          color: blueGrey2, fontSize: 16),
                                      border: InputBorder.none,
                                    ),
                                    inputFormatters: [],
                                  ),
                                ),
                              ]),
                        );
                },
              ),
            ),
          ),
        ));
  }
}

String getMessage(String error) {
  if (error == '1') {
    return 'Vui lòng điền đầy đủ thông tin';
  } else if (error == '2') {
    return 'Ngày bắt đầu không được lớn hơn ngày kết thúc';
  } else if (error == '3') {
    return 'Bạn đã hết phép';
  }
  return 'Phép của bạn đã hết. Bạn có muốn ứng phép ?';
}
