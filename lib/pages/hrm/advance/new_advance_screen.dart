import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:intl/intl.dart';
import '../../../config/color.dart';
import '../../../method/hrm_method.dart';
import '../../../widget/dialog.dart';
import '../request_management/bloc/request_management_bloc.dart';
import 'bloc/advance_bloc.dart';
import 'chosse_advance_kind_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewAdvanceScreen extends StatefulWidget {
  const NewAdvanceScreen({super.key});

  @override
  State<NewAdvanceScreen> createState() => _NewAdvanceScreenState();
}

class _NewAdvanceScreenState extends State<NewAdvanceScreen> {
  TextEditingController noteController = TextEditingController();
  TextEditingController moneyController = TextEditingController();
  DateTime fromDateChange = DateTime.now();
  DateTime toDateChange = DateTime.now();
  late AdvanceBloc advanceBloc;
  static const _locale = 'vi';
  String _formatNumber(String s) {
    if (s.isEmpty) return s;
    return NumberFormat.decimalPattern(_locale).format(int.parse(s));
  }

  @override
  void initState() {
    advanceBloc = BlocProvider.of<AdvanceBloc>(context);
    advanceBloc.add(InitialAdvanceEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocListener<AdvanceBloc, AdvanceState>(
        listener: (context, state) {
          if (state.sendStatus == SendAdvanceStatus.failure) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return closeDialog(context, 'Thông báo', state.error);
                });
          } else if (state.sendStatus == SendAdvanceStatus.success) {
            Navigator.pop(context);
            EasyLoading.showSuccess('Đã gửi yêu cầu thành công');
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
              title: const Text('Tạm ứng', style: TextStyle(color: blueBlack)),
              actions: [
                InkWell(
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.create,
                      style: const TextStyle(color: mainColor, fontSize: 16),
                    ),
                  ),
                  onTap: () {
                    advanceBloc.add(SendAdvanceEvent(
                        money: moneyController.text,
                        note: noteController.text));
                  },
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: BlocBuilder<AdvanceBloc, AdvanceState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context)!.advanceType,
                              style: const TextStyle(color: blueGrey1)),
                          const SizedBox(height: 5),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChooseAdvanceKindScreen(
                                            listAdvanceKindModel:
                                                state.listAdvanceKindModel,
                                          )));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xFFF3F6FF),
                                    borderRadius: BorderRadius.circular(5)),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                                      child: state.advanceKindModel == null
                                          ? Text(
                                              AppLocalizations.of(context)!
                                                  .advanceType,
                                              style: const TextStyle(
                                                  color: blueGrey2,
                                                  fontSize: 16),
                                            )
                                          : Text(
                                              capitalize(
                                                  state.advanceKindModel!.name),
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
                          const SizedBox(height: 10),
                          Text(AppLocalizations.of(context)!.startDate,
                              style: const TextStyle(color: blueGrey1)),
                          const SizedBox(height: 5),
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                        child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(height: 10),
                                        Text(
                                            AppLocalizations.of(context)!
                                                .select,
                                            style:
                                                const TextStyle(fontSize: 20)),
                                        SizedBox(
                                          height: 200,
                                          child: CupertinoDatePicker(
                                            initialDateTime:
                                                (state.fromDate == null)
                                                    ? DateTime.now()
                                                    : state.fromDate,
                                            onDateTimeChanged: (value) {
                                              fromDateChange = value;
                                            },
                                            mode: CupertinoDatePickerMode.date,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(children: [
                                            Expanded(
                                              child: SizedBox(
                                                height: 50,
                                                child: OutlinedButton(
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.white,
                                                      padding: EdgeInsets.zero,
                                                      side: const BorderSide(
                                                          color: mainColor,
                                                          width: 1),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                    child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .cancel,
                                                        style: const TextStyle(
                                                            fontSize: 17,
                                                            color: mainColor)),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    }),
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            Expanded(
                                              child: SizedBox(
                                                height: 50,
                                                child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        elevation: 0.0,
                                                        shadowColor:
                                                            Colors.transparent,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        backgroundColor:
                                                            mainColor),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      advanceBloc.add(
                                                          ChooseAdvanceFromDateEvent(
                                                              fromDate:
                                                                  fromDateChange));
                                                    },
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .done,
                                                      style: const TextStyle(
                                                          fontSize: 17),
                                                    )),
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ],
                                    ));
                                  });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xFFF3F6FF),
                                    borderRadius: BorderRadius.circular(5)),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 50,
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    const Icon(Icons.date_range,
                                        color: blueGrey2),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: state.fromDate == null
                                          ? Text(
                                              AppLocalizations.of(context)!
                                                  .startDate,
                                              style: const TextStyle(
                                                  color: blueGrey2,
                                                  fontSize: 16))
                                          : Text(
                                              DateFormat('dd/MM/yyyy')
                                                  .format(state.fromDate!),
                                              style: const TextStyle(
                                                  color: blueBlack,
                                                  fontSize: 16)),
                                    ),
                                    const Icon(Icons.keyboard_arrow_down,
                                        color: blueGrey1, size: 30)
                                  ],
                                )),
                          ),
                          const SizedBox(height: 10),
                          Text(AppLocalizations.of(context)!.endDate,
                              style: const TextStyle(color: blueGrey1)),
                          const SizedBox(height: 5),
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                        child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(height: 10),
                                        Text(
                                            AppLocalizations.of(context)!
                                                .select,
                                            style:
                                                const TextStyle(fontSize: 20)),
                                        SizedBox(
                                          height: 200,
                                          child: CupertinoDatePicker(
                                            initialDateTime:
                                                state.toDate == null
                                                    ? DateTime.now()
                                                    : state.toDate!,
                                            onDateTimeChanged: (value) {
                                              toDateChange = value;
                                            },
                                            mode: CupertinoDatePickerMode.date,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(children: [
                                            Expanded(
                                              child: SizedBox(
                                                height: 50,
                                                child: OutlinedButton(
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.white,
                                                      padding: EdgeInsets.zero,
                                                      side: const BorderSide(
                                                          color: mainColor,
                                                          width: 1),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                    child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .cancel,
                                                        style: const TextStyle(
                                                            fontSize: 17,
                                                            color: mainColor)),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    }),
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            Expanded(
                                              child: SizedBox(
                                                height: 50,
                                                child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        elevation: 0.0,
                                                        shadowColor:
                                                            Colors.transparent,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        backgroundColor:
                                                            mainColor),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      advanceBloc.add(
                                                          ChooseAdvanceToDateEvent(
                                                              toDate:
                                                                  toDateChange));
                                                    },
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .done,
                                                      style: const TextStyle(
                                                          fontSize: 17),
                                                    )),
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ],
                                    ));
                                  });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xFFF3F6FF),
                                    borderRadius: BorderRadius.circular(5)),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 50,
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.date_range,
                                      color: blueGrey2,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: state.toDate == null
                                          ? Text(
                                              AppLocalizations.of(context)!
                                                  .endDate,
                                              style: const TextStyle(
                                                  color: blueGrey2,
                                                  fontSize: 16),
                                            )
                                          : Text(
                                              DateFormat('dd/MM/yyyy')
                                                  .format(state.toDate!),
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
                          const SizedBox(height: 10),
                          Text(AppLocalizations.of(context)!.amount,
                              style: const TextStyle(color: blueGrey1)),
                          const SizedBox(height: 5),
                          Container(
                            decoration: BoxDecoration(
                                color: const Color(0xFFF3F6FF),
                                borderRadius: BorderRadius.circular(5)),
                            height: 50,
                            child: TextFormField(
                              controller: moneyController,
                              cursorColor: blueBlack,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                  color: blueBlack, fontSize: 16),
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 15, top: 5),
                                hintText: '',
                                hintStyle:
                                    TextStyle(color: blueGrey2, fontSize: 16),
                                border: InputBorder.none,
                              ),
                              onChanged: (string) {
                                string =
                                    _formatNumber(string.replaceAll('.', ''));
                                moneyController.value = TextEditingValue(
                                  text: string,
                                  selection: TextSelection.collapsed(
                                      offset: string.length),
                                );
                              },
                              inputFormatters: [
                                // CurrencyInputFormatter(),
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9.]'))
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(AppLocalizations.of(context)!.note,
                                  style: const TextStyle(color: blueGrey1)),
                              const Text(
                                '*',
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
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
                },
              ),
            )),
      ),
    );
  }
}
