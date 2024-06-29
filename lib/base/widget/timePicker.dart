import 'package:erp/config/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePickerWidget extends StatelessWidget {
  DateTime? state;
  VoidCallback onSelectTime;
  TimePickerWidget({Key? key, this.state, required this.onSelectTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectTime,
      child: Container(
          decoration: BoxDecoration(
              color: const Color(0xFFF3F6FF),
              borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 50,
          width: double.infinity,
          child: Row(
            children: [
              const Icon(Icons.access_time_rounded, color: blueGrey2),
              const SizedBox(width: 10),
              state == null
                  ? const Text(
                      '',
                      style: TextStyle(color: blueGrey2, fontSize: 16),
                    )
                  : Text(
                      DateFormat('Hms').format(state!),
                      style: const TextStyle(color: blueBlack, fontSize: 16),
                    ),
            ],
          )),
    );
  }
}
