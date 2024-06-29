import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoScreen extends StatefulWidget {
  AppInfoScreen({Key? key});

  @override
  State<AppInfoScreen> createState() => _AppInfoScreenState();
}

class _AppInfoScreenState extends State<AppInfoScreen> {
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
            AppLocalizations.of(context)!.appInfo,
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
              const SizedBox(height: 5),
              buildItem(AppLocalizations.of(context)!.applicationName,
                  'HRM Solution'),
              const SizedBox(height: 15),
              buildItem(AppLocalizations.of(context)!.version, ''),
              const SizedBox(height: 5),
            ])));
  }
}

Widget buildItem(String name, String value) {
  return Row(
    children: [
      const SizedBox(width: 5),
      Expanded(
        child: Text(
          name,
          style: const TextStyle(fontSize: 17, color: Colors.black54),
        ),
      ),
      Expanded(
        child: Text(
          value,
          style: const TextStyle(fontSize: 17, color: Colors.black87),
          textAlign: TextAlign.right,
        ),
      ),
      const SizedBox(width: 5),
    ],
  );
}
