import 'package:erp/config/color.dart';
import 'package:erp/pages/hrm/accountManager/change_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountManagerScreen extends StatelessWidget {
  const AccountManagerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),
      appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          title: Text(
            AppLocalizations.of(context)!.accountManage,
            style: const TextStyle(color: Colors.black),
          )),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 15),
          buildRequestManagementItem(context, 1, Icons.edit,
              AppLocalizations.of(context)!.changePassword, mainColor),
          Container(height: 1, color: Colors.grey[200]),
        ]),
      ),
    );
  }
}

Widget buildRequestManagementItem(
    BuildContext context, int id, IconData icon, String name, Color color) {
  return InkWell(
    onTap: () {
      if (id == 1) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ChangePasswordScreen()));
      }
    },
    child: Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 10, right: 15),
      height: 45,
      child: Row(children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 15),
        Expanded(
            child: Text(
          name,
          style: const TextStyle(fontSize: 16),
        )),
        SizedBox(
          height: 45,
          width: 45,
          child: Icon(Icons.arrow_forward_ios_rounded,
              size: 20, color: Colors.blueGrey[300]!),
        )
      ]),
    ),
  );
}
