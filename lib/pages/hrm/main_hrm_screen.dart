import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/color.dart';

import 'account/account_screen.dart';
import 'assign/assign_screen.dart';
import 'calendar/calendar_screen.dart';
import 'work/work_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainHRMScreen extends StatefulWidget {
  const MainHRMScreen({Key? key}) : super(key: key);

  @override
  State<MainHRMScreen> createState() => _MainHRMScreenState();
}

class _MainHRMScreenState extends State<MainHRMScreen> {
  int selectedIndex = 0;
  static const List<Widget> widgetOptions = <Widget>[
    WorkScreen(),
    // AssignScreen(),
    // CalendarScreen(),
    AccountScreen()
  ];
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FBF5),
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey[400],
        selectedFontSize: 12,
        unselectedFontSize: 12,

        selectedLabelStyle: const TextStyle(
          color: mainColor,
        ),
        unselectedLabelStyle: TextStyle(color: Colors.grey[400]),
        iconSize: 25,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_filled),
            label: AppLocalizations.of(context)!.work,
          ),
          // BottomNavigationBarItem(
          //   icon: const Icon(IconData(0xee2d, fontFamily: 'MaterialIcons')),
          //   label: AppLocalizations.of(context)!.assign,
          // ),
          // BottomNavigationBarItem(
          //   icon: const Icon(Icons.date_range),
          //   label: AppLocalizations.of(context)!.calendar,
          // ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            label: AppLocalizations.of(context)!.account,
          ),
        ],

        selectedItemColor: mainColor,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        //onTap: (){},
      ),
    );
  }
}
