import 'package:erp/model/login_model.dart';
import 'package:erp/pages/hrm/accountManager/account_manager_screen.dart';
import 'package:erp/pages/hrm/accountManager/change_password_screen.dart';
import 'package:erp/pages/hrm/appInfo_screen.dart';
import 'package:erp/pages/hrm/language_screen.dart';
import 'package:erp/pages/login/config_server_page.dart';
import 'package:erp/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import '../../../config/color.dart';
import '../../../method/hrm_method.dart';
import '../kpi_screen.dart';
import '../management_setting_screen.dart';
import '../onleave_profile/on_leave_profile_screen.dart';
import '../report_screen.dart';
import '../salary/salary_caculate_screen.dart';
import '../warning_setting_screen.dart';
import 'edit_account_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          height: 10,
          color: Colors.white,
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          child: Column(
            children: [
              _buildAppbar(context),
              const SizedBox(height: 10),
              buildInfo('Quản lý', '+84888888888'),
            ],
          ),
        ),
        const SizedBox(height: 15),
        _buildActionItem(context, 1, Icons.settings, mainColor,
            AppLocalizations.of(context)!.settingManage, true),
        // _buildActionItem(context, 2, Icons.signal_cellular_alt_sharp, mainColor,
        //     AppLocalizations.of(context)!.report, true),
        _buildActionItem(context, 3, Icons.date_range, mainColor,
            AppLocalizations.of(context)!.permissionManage, true),
        // _buildActionItem(context, 4, Icons.description_rounded, mainColor,
        //     AppLocalizations.of(context)!.payslip, true),
        // _buildActionItem(context, 5, Entypo.trophy, mainColor,
        //     AppLocalizations.of(context)!.kpiManage, true),
        const SizedBox(height: 15),
        buildLanguage(context),
        // _buildActionItem(context, 6, Icons.notifications, Colors.blue,
        //     AppLocalizations.of(context)!.alarmSetting, true),
        // _buildActionItem(context, 7, Icons.business_center_outlined,
        //     Colors.blue, AppLocalizations.of(context)!.changeBusiness, true),
        _buildActionItem(context, 8, Icons.account_circle, Colors.blue,
            AppLocalizations.of(context)!.accountManage, true),
        const SizedBox(height: 15),
        _buildActionItem(
            context,
            9,
            Icons.info,
            const Color.fromARGB(255, 223, 69, 58),
            AppLocalizations.of(context)!.appInfo,
            true),
        // _buildActionItem(
        //     context,
        //     10,
        //     Icons.refresh,
        //     const Color.fromARGB(255, 234, 73, 61),
        //     AppLocalizations.of(context)!.appUpdate,
        //     false),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: 50,
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red, width: 1),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ConfigServerPage()));
              },
              child: Text(AppLocalizations.of(context)!.logOut,
                  style: const TextStyle(color: Colors.red, fontSize: 22)),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ]),
    );
  }
}

Widget _buildAppbar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              // color: backgroundColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10)),
          // child: const Icon(Icons.qr_code),
        ),
        InkWell(
            child: Text(AppLocalizations.of(context)!.edit,
                style: const TextStyle(fontSize: 18, color: blueBlack)),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EditAccountScreen()))),
      ],
    ),
  );
}

Widget buildInfo(String position, String phone) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(25)),
        child: Center(
            child: Text(
          acronymName(User.name),
          style: const TextStyle(fontSize: 40, color: Colors.white),
        )),
      ),
      const SizedBox(height: 10),
      Text(User.name, style: const TextStyle(fontSize: 17, color: blueBlack)),
      const SizedBox(height: 10),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(position, style: const TextStyle(color: backgroundColor)),
          const SizedBox(width: 10),
          Text(phone, style: const TextStyle(color: backgroundColor)),
        ],
      )
    ],
  );
}

Widget buildAdvertisement() {
  return Container(
    height: 150,
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 15),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
        color: mainColor, borderRadius: BorderRadius.circular(10)),
    child: Row(
      children: [
        const Expanded(
          flex: 1,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Nâng cấp tài khoản Tanca',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                Text('Miễn phí với 5 nhân viên',
                    style: TextStyle(fontSize: 12, color: Colors.white))
              ]),
        ),
        Expanded(
          flex: 1,
          child: Container(
            decoration: const BoxDecoration(
                // image: DecorationImage(
                //   image: AssetImage('assets/images/office.png'),
                //   fit: BoxFit.cover,
                // ),
                ),
          ),
        )
      ],
    ),
  );
}

Widget _buildActionItem(BuildContext context, int id, IconData icon,
    Color color, String name, bool isNotMore) {
  return InkWell(
    onTap: () {
      if (id == 1) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ManagementSettingScreen()));
      } else if (id == 2) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ReportScreen()));
      } else if (id == 3) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const OnLeaveProfileScreen()));
      } else if (id == 4) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SalaryCalculateScreen()));
      } else if (id == 5) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const KPIScreen()));
      } else if (id == 6) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const WarningSettingScreen()));
      } else if (id == 8) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AccountManagerScreen()));
      } else if (id == 9) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AppInfoScreen()));
      }
    },
    child: Container(
      height: 55,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: color,
          ),
          const SizedBox(width: 15),
          Text(
            name,
            style: const TextStyle(fontSize: 17),
          ),
          const Expanded(child: SizedBox.shrink()),
          isNotMore
              ? const SizedBox(
                  height: 40,
                  width: 40,
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 18,
                    color: Colors.grey,
                  ),
                )
              : const SizedBox(width: 15),
        ],
      ),
    ),
  );
}

Widget buildLanguage(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LanguageScreen()));
    },
    child: Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          const Icon(
            Icons.language,
            size: 20,
            color: Colors.blue,
          ),
          const SizedBox(width: 15),
          Text(AppLocalizations.of(context)!.language,
              style: const TextStyle(fontSize: 17)),
          const Expanded(child: SizedBox.shrink()),
          Text(
            AppLocalizations.of(context)!.language == "Language"
                ? "English"
                : "Tiếng việt",
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(
            height: 40,
            width: 40,
            child: Icon(
              Icons.arrow_forward_ios_outlined,
              size: 18,
              color: Colors.grey,
            ),
          )
        ],
      ),
    ),
  );
}
