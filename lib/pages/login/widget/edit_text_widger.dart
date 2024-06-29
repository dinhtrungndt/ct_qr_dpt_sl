import 'package:flutter/material.dart';

class EditTextWidget extends StatelessWidget {
  final String? title;
  final bool? isPassword;
  final TextEditingController? controller;
  final String? placeHolder;
  const EditTextWidget(
      {Key? key,
      this.title,
      this.isPassword,
      this.controller,
      this.placeHolder = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
              controller: controller,
              obscureText: isPassword!,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: placeHolder,
                  hintStyle: const TextStyle(color: Colors.black26),
                  fillColor: const Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }
}
