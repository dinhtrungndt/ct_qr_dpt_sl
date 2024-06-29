import 'package:erp/config/mythemes.dart';
import 'package:erp/pages/login/config_server_page.dart';
import 'package:erp/pages/login/signup_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';
import 'package:universal_io/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../model/hrm_model/employee_model.dart';
import '../../model/login_model.dart';
import '../../widget/dialog.dart';
import '../hrm/main_hrm_screen.dart';
import 'bloc/login_bloc.dart';
import 'widget/bezier_container.dart';
import 'widget/divider_widget.dart';
import 'widget/edit_text_widger.dart';
import 'widget/button_widget.dart';
import 'widget/title_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  late LoginBloc loginBloc;
  TextEditingController urlController = TextEditingController();
  TextEditingController emailController = TextEditingController();
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
    emailController.text = prefs.getString('user') ?? '';
  }

  saveUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginError) {
              print(1);
              Navigator.pop(context);
              EasyLoading.showError(state.errorMessage);
            } else if (state is LoginWaiting) {
              print(2);
              FocusScope.of(context).unfocus();
              showProgressDialog(context);
            } else if (state is LoginSuccess) {
              Navigator.pop(context);
              User.name = state.loginData.profile['name'];
              User.no_ = state.loginData.profile['userName'];
              User.site = state.loginData.profile['site'];
              User.token = state.loginData.accessToken;
              UserModel.id =
                  int.parse(state.loginData.profile['id'].toString());
              saveUser();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MainHRMScreen()),
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
                            _emailPasswordWidget(),
                            const SizedBox(height: 20),
                            GestureDetector(
                                onTap: () {
                                  if (emailController.text.trim() == '' ||
                                      passwordController.text.trim() == '') {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Vui lòng điền thông tin đăng nhập",
                                        toastLength: Toast.LENGTH_LONG,
                                        backgroundColor: Colors.red[300],
                                        textColor: Colors.white,
                                        fontSize: 13);
                                    return;
                                  }
                                  User.site = 'KIA';
                                  String password =
                                      convertPassword(passwordController.text);
                                  loginBloc.add(Login(emailController.text,
                                      password, User.site, ''));
                                },
                                child: ButtonWidget(text: 'Login')),
                            // const DividerWidget(),
                            SizedBox(height: height * .055),
                            // _createAccountLabel(),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        top: 40,
                        left: 0,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ConfigServerPage()));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 0, top: 10, bottom: 10),
                                  child: const Icon(Icons.keyboard_arrow_left,
                                      color: Colors.black),
                                ),
                                const Text('Back',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                          ),
                        )),
                    //const Positioned(top: 40, left: 0, child: BackButtonWidget()),
                  ],
                ),
              )),
        ));
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        // EditTextWidget(
        //   title: "URL",
        //   isPassword: false,
        //   controller: urlController,
        //   placeHolder: 'https://www.example.com',
        // ),
        EditTextWidget(
          title: "Username",
          isPassword: false,
          controller: emailController,
        ),
        EditTextWidget(
          title: "Password",
          isPassword: true,
          controller: passwordController,
        ),
      ],
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SignUpScreen()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: mainColor2, fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  String convertPassword(String s) {
    return s;
    // String pw = "";
    // List<int> bytes = utf8.encode(s);
    // bytes = sha1.convert(bytes).bytes;
    // for (var item in bytes) {
    //   pw += item.toString();
    // }
    // return pw;
  }
}
