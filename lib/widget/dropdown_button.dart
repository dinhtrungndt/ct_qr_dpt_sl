import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton(
      {Key? key,
      this.height = 50,
      this.width = double.infinity,
      this.hintText = '',
      this.fontSize = 15,
      this.radius = 4,
      this.textColor= Colors.black,
      required this.color,
      required this.currentValue,
      required this.items,
      required this.changed})
      : super(key: key);
  final Color color;
  final Color textColor;
  final String hintText;
  final Object? currentValue;
  final List<DropdownMenuItem<Object>> items;
  final double height;
  final double width;
  final double fontSize;
  final double radius;
  final Function(Object) changed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: DropdownButton(
          underline: const SizedBox.shrink(),
          value: currentValue,
          icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey,size: 20,),
          style: TextStyle(color: textColor, fontSize: fontSize),
          isExpanded: true,
          hint: Text(hintText,
              style:
                  TextStyle(color: textColor.withOpacity(0.6), fontSize: fontSize)),
          onChanged: (newValue) {
            if (newValue != null) changed(newValue);
          },
          items: items),
    );
  }
}
