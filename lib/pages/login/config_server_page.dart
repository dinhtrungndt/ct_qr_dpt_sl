import 'package:erp/pages/login/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:universal_io/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widget/dialog.dart';
import 'bloc/login_bloc.dart';
import 'widget/bezier_container.dart';
import 'widget/edit_text_widger.dart';
import 'widget/button_widget.dart';
import 'widget/title_widget.dart';

class ConfigServerPage extends StatefulWidget {
  const ConfigServerPage({Key? key}) : super(key: key);
  @override
  ConfigServerPageState createState() => ConfigServerPageState();
}

class ConfigServerPageState extends State<ConfigServerPage> {
  late LoginBloc loginBloc;
  TextEditingController urlController = TextEditingController();
  TextEditingController serverController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Color gradientTop = const Color(0xFF4AB35E);
  Color gradientBottom = const Color(0xFF4AB35E);
  //Color mainColor = const Color(0xFF0181cc);
  Color mainColor = const Color(0xFF4AB35E);
  Color underlineColor = const Color(0xFFCCCCCC);

  @override
  void initState() {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    getUser();
    passwordController.text = '';
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getUser() async {
    if (Platform.isAndroid) {
      SharedPreferencesAndroid.registerWith();
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    serverController.text = prefs.getString('server') ?? '';
  }

  saveServerName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('server', serverController.text);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is VerifyServerFail) {
              EasyLoading.showError(
                  AppLocalizations.of(context)!.serverInvalid);
            } else if (state is VerifyServerWaiting) {
              FocusScope.of(context).unfocus();
              showProgressDialog(context);
            } else if (state is VerifyServerSuccess) {
              saveServerName();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            }
          },
          child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: Platform.isIOS
                  ? SystemUiOverlayStyle.light
                  : const SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.light),
              child: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        top: -height * .15,
                        right: -MediaQuery.of(context).size.width * .4,
                        child: const BezierContainer()),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: height * .18),
                            const TitleWidget(),
                            const SizedBox(height: 50),
                            _serverWidget(),
                            const SizedBox(height: 20),
                            GestureDetector(
                                onTap: () {
                                  loginBloc.add(
                                      VerifyServer(url: serverController.text));
                                },
                                child: ButtonWidget(
                                  text: 'GO',
                                  widget: const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }

  Widget _serverWidget() {
    return Column(
      children: <Widget>[
        EditTextWidget(
          title: "Server",
          isPassword: false,
          controller: serverController,
        ),
      ],
    );
  }
}
