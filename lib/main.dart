import 'package:erp/pages/hrm/account/bloc/account_bloc.dart';
import 'package:erp/pages/hrm/accountManager/bloc/account_manager_bloc.dart';
import 'package:erp/pages/hrm/onleave_profile/bloc/onleave_profile_bloc.dart';
import 'package:erp/pages/hrm/organization/bloc/organization_bloc.dart';
import 'package:erp/pages/hrm/overtime/bloc/overtime_bloc.dart';
import 'package:erp/pages/hrm/position/bloc/position_bloc.dart';
import 'package:erp/pages/hrm/shift/bloc/shift_bloc.dart';
import 'package:erp/pages/hrm/shift_assignment/bloc/shift_assignment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';
import 'pages/hrm/advance/bloc/advance_bloc.dart';
import 'pages/hrm/branch/bloc/branch_bloc.dart';
import 'pages/hrm/check_in_out.dart/bloc/check_in_out_bloc.dart';
import 'pages/hrm/location/bloc/location_bloc.dart';
import 'pages/hrm/on_leave/bloc/on_leave_bloc.dart';
import 'pages/hrm/region/bloc/region_bloc.dart';
import 'pages/hrm/request_management/bloc/request_management_bloc.dart';
import 'pages/hrm/salary/bloc/salary_calculate_bloc.dart';
import 'pages/hrm/shift_calendar/bloc/shift_calendar_bloc.dart';
import 'pages/hrm/timekeeping/bloc/timekeeping_bloc.dart';
import 'pages/hrm/timekeeping_offset/bloc/timekeeping_offset_bloc.dart';
import 'pages/hrm/work/bloc/work_bloc.dart';
import 'pages/login/bloc/login_bloc.dart';
import 'pages/splash/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.changeLanguage(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final LocalStorage storage = LocalStorage('setting');
  Locale? _locale = const Locale('vi');

  changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (BuildContext context) => LoginBloc()),
        BlocProvider<TimekeepingBloc>(
            create: (BuildContext context) => TimekeepingBloc()),
        BlocProvider<ShiftCalendarBloc>(
            create: (BuildContext context) => ShiftCalendarBloc()),
        BlocProvider<TimekeepingOffsetBloc>(
            create: (BuildContext context) => TimekeepingOffsetBloc()),
        BlocProvider<OnLeaveBloc>(
            create: (BuildContext context) => OnLeaveBloc()),
        BlocProvider<AdvanceBloc>(
            create: (BuildContext context) => AdvanceBloc()),
        BlocProvider<RequestManagementBloc>(
            create: (BuildContext context) => RequestManagementBloc()),
        BlocProvider<SalaryCalculateBloc>(
            create: (BuildContext context) => SalaryCalculateBloc()),
        BlocProvider<RegionBloc>(
            create: (BuildContext context) => RegionBloc()),
        BlocProvider<BranchBloc>(
            create: (BuildContext context) => BranchBloc()),
        BlocProvider<LocationBloc>(
            create: (BuildContext context) => LocationBloc()),
        BlocProvider<CheckInOutBloc>(
            create: (BuildContext context) => CheckInOutBloc()),
        BlocProvider<WorkBloc>(create: (BuildContext context) => WorkBloc()),
        BlocProvider<AccountBloc>(
            create: (BuildContext context) => AccountBloc()),
        BlocProvider<OnleaveProfileBloc>(
            create: (BuildContext context) => OnleaveProfileBloc()),
        BlocProvider<OvertimeBloc>(
            create: (BuildContext context) => OvertimeBloc()),
        BlocProvider<OrganizationBloc>(
            create: (BuildContext context) => OrganizationBloc()),
        BlocProvider<PositionBloc>(
            create: (BuildContext context) => PositionBloc()),
        BlocProvider<LoginBloc>(create: (BuildContext context) => LoginBloc()),
        BlocProvider<ShiftBloc>(create: (BuildContext context) => ShiftBloc()),
        BlocProvider<ShiftAssignmentBloc>(
            create: (BuildContext context) => ShiftAssignmentBloc()),
        BlocProvider<AccountManagerBloc>(
            create: (BuildContext context) => AccountManagerBloc()),
      ],
      child: MaterialApp(
        title: 'CRM',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        theme: ThemeData(
            //fontFamily: 'Gilroy',
            fontFamily: 'Be VietNam',
            primarySwatch: Colors.blue,
            useMaterial3: true),
        home: const SplashScreen(),
        locale: _locale,
        supportedLocales: const [
          Locale('vi', 'VN'),
          Locale('en', 'US'),
        ],
        builder: EasyLoading.init(),
      ),
    );
  }
}
