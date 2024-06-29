import 'package:dbcrypt/dbcrypt.dart';
import 'package:erp/config/color.dart';
import 'package:erp/pages/hrm/account/bloc/account_bloc.dart';
import 'package:erp/pages/hrm/accountManager/bloc/account_manager_bloc.dart';
import 'package:erp/pages/hrm/branch/branch_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../model/hrm_model/company_model.dart';
import '../../../model/hrm_model/employee_model.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late AccountManagerBloc accountManagementBloc = AccountManagerBloc();

  @override
  void initState() {
    accountManagementBloc = BlocProvider.of<AccountManagerBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController oldPassword = TextEditingController();
    TextEditingController newPassword = TextEditingController();
    TextEditingController confirmPassword = TextEditingController();
    return BlocListener<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccess) {
          EasyLoading.showSuccess('Change password success');
        } else if (state is ChangePasswordFail) {
          EasyLoading.showError('Change password fail');
        } else if (state is WrongPassword) {
          EasyLoading.showError('Password incorrect');
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: blueBlack),
          elevation: 1,
          title: Text(AppLocalizations.of(context)!.changePassword,
              style: const TextStyle(color: blueBlack)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Text(AppLocalizations.of(context)!.oldPassword,
                    style: const TextStyle(color: blueGrey1)),
                const Text(
                  ' *',
                  style: TextStyle(color: Colors.red),
                )
              ],
            ),
            const SizedBox(height: 10),
            Container(
              color: const Color(0xFFF3F6FF),
              height: 50,
              width: double.infinity,
              child: TextFormField(
                controller: oldPassword,
                obscureText: true,
                cursorColor: backgroundColor,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 10),
                  hintText: AppLocalizations.of(context)!.enterText,
                  hintStyle: const TextStyle(color: blueGrey2),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(AppLocalizations.of(context)!.newPassword,
                    style: const TextStyle(color: blueGrey1)),
                const Text(
                  ' *',
                  style: TextStyle(color: Colors.red),
                )
              ],
            ),
            const SizedBox(height: 10),
            Container(
              color: const Color(0xFFF3F6FF),
              height: 50,
              width: double.infinity,
              child: TextFormField(
                controller: newPassword,
                cursorColor: backgroundColor,
                obscureText: true,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 10),
                  hintText: AppLocalizations.of(context)!.enterText,
                  hintStyle: const TextStyle(color: blueGrey2),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(AppLocalizations.of(context)!.confirmPassword,
                    style: const TextStyle(color: blueGrey1)),
                const Text(
                  ' *',
                  style: TextStyle(color: Colors.red),
                )
              ],
            ),
            const SizedBox(height: 10),
            Container(
              color: const Color(0xFFF3F6FF),
              height: 50,
              width: double.infinity,
              child: TextFormField(
                controller: confirmPassword,
                obscureText: true,
                cursorColor: backgroundColor,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 10),
                  hintText: AppLocalizations.of(context)!.enterText,
                  hintStyle: const TextStyle(color: blueGrey2),
                  border: InputBorder.none,
                ),
              ),
            ),
            const Expanded(child: SizedBox.shrink()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      side: const BorderSide(color: mainColor, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(AppLocalizations.of(context)!.update,
                        style: const TextStyle(fontSize: 18, color: mainColor)),
                    onPressed: () {
                      if (newPassword.text != confirmPassword.text) {
                        EasyLoading.showError('Confirm password incorrect');
                      } else {
                        DBCrypt dBCrypt = DBCrypt();
                        accountManagementBloc.add(ChangePasswordEvent(
                            oldPassword: oldPassword.text,
                            newPassword: newPassword.text,
                            saltValue: dBCrypt.gensaltWithRounds(10)));
                      }
                    }),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
