import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/color.dart';

class ChooseDateDialog extends StatefulWidget {
  ChooseDateDialog({Key? key, this.state, this.fieldDateChange, this.callBack})
      : super(key: key);
  DateTime? state;
  DateTime? fieldDateChange;
  VoidCallback? callBack;

  @override
  State<ChooseDateDialog> createState() => _ChooseDateDialogState();
}

class _ChooseDateDialogState extends State<ChooseDateDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        const Text('Chọn', style: TextStyle(fontSize: 20)),
        SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            initialDateTime:
                (widget.state == null) ? DateTime.now() : widget.state,
            onDateTimeChanged: (value) {
              widget.fieldDateChange = value;
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
                      side: BorderSide(color: mainColor, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text('HỦY',
                        style: TextStyle(fontSize: 17, color: mainColor)),
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
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: mainColor),
                    onPressed: () {
                      Navigator.pop(context);
                      widget.callBack;
                      // onLeaveBloc.add(ChooseExpirationDateEvent(
                      //     expirationDate: expirationDateChange));
                    },
                    child: const Text(
                      "XONG",
                      style: TextStyle(fontSize: 17),
                    )),
              ),
            ),
          ]),
        ),
      ],
    ));
  }
}
