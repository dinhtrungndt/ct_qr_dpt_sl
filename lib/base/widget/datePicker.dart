import 'package:erp/config/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatelessWidget {
  DateTime? state;
  DateTime? dateChange;
  String placeHolder;
  VoidCallback? onClickDone;
  DatePickerWidget(
      {Key? key,
      this.state,
      this.dateChange,
      this.placeHolder = '',
      this.onClickDone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10),
                      Text(AppLocalizations.of(context)!.select,
                          style: const TextStyle(fontSize: 20)),
                      SizedBox(
                        height: 200,
                        child: CupertinoDatePicker(
                          initialDateTime:
                              (state == null) ? DateTime.now() : state,
                          onDateTimeChanged: (value) {
                            dateChange = value;
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
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    padding: EdgeInsets.zero,
                                    side: const BorderSide(
                                        color: mainColor, width: 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  child: Text(
                                      AppLocalizations.of(context)!.cancel,
                                      style: const TextStyle(
                                          fontSize: 17, color: mainColor)),
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
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor: mainColor),
                                  onPressed: onClickDone,
                                  child: Text(
                                    AppLocalizations.of(context)!.done,
                                    style: const TextStyle(
                                        fontSize: 17, color: Colors.white),
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
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
                child: state == null
                    ? Text(
                        placeHolder,
                        style: const TextStyle(color: blueGrey2, fontSize: 16),
                      )
                    : Text(
                        DateFormat('dd/MM/yyyy').format(state!),
                        style: const TextStyle(color: blueBlack, fontSize: 16),
                      ),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                color: blueGrey1,
                size: 30,
              )
            ],
          )),
    );
  }
}
