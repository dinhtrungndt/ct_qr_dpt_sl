import 'package:erp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../config/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageScreen extends StatefulWidget {
  LanguageScreen({Key? key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(243, 246, 255, 1),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            AppLocalizations.of(context)!.language,
            style: const TextStyle(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: Container(
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: Colors.white,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              buildLanguageItem('Tiếng việt',
                  AppLocalizations.of(context)!.language != 'Language', () {
                Locale newLocale = const Locale('vi');
                MyApp.setLocale(context, newLocale);
                EasyLoading.showSuccess("Đổi thành công");
              }),
              const SizedBox(height: 10),
              buildLanguageItem('English',
                  AppLocalizations.of(context)!.language == 'Language', () {
                Locale newLocale = const Locale('en');
                MyApp.setLocale(context, newLocale);
                EasyLoading.showSuccess("Change success");
              }),
              const SizedBox(height: 10),
            ])));
  }
}

Widget buildLanguageItem(String name, bool isChoose, VoidCallback func) {
  return InkWell(
    onTap: func,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(fontSize: 17, color: Colors.black54),
            ),
          ),
          isChoose
              ? const Icon(
                  Icons.check,
                  color: mainColor,
                )
              : Container(),
          const SizedBox(width: 5),
        ],
      ),
    ),
  );
}
