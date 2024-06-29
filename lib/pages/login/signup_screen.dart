import 'package:erp/config/mythemes.dart';
import 'package:erp/pages/login/bloc/login_bloc.dart';
import 'package:erp/pages/login/login_page.dart';
import 'package:erp/pages/login/widget/bezier_container.dart';
import 'package:erp/pages/login/widget/edit_text_widger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:dbcrypt/dbcrypt.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:quickalert/quickalert.dart';

import 'login_screen.dart';
import 'widget/divider_widget.dart';
import 'widget/button_widget.dart';
import 'widget/title_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController attendCodeController = TextEditingController();
  late LoginBloc loginBloc;
  @override
  initState() {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: mainColor2, fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        EditTextWidget(
            title: "Email", isPassword: false, controller: userNameController),
        EditTextWidget(
            title: "Password",
            isPassword: true,
            controller: passwordController),
        EditTextWidget(
            title: "Full name", isPassword: false, controller: nameController),
        EditTextWidget(
            title: "Code", isPassword: false, controller: codeController),
        EditTextWidget(
            title: "Attend Code",
            isPassword: false,
            controller: attendCodeController),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              text:
                  'Sign up successfully. You can log in with the account ${userNameController.text}',
            );
          } else if (state is SignUpFail) {
            EasyLoading.showInfo('${state.message} already exists !');
          }
        },
        child: Scaffold(
            body: SizedBox(
          height: height,
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
                            if (userNameController.text.trim() == "" ||
                                passwordController.text.trim() == "" ||
                                nameController.text.trim() == "" ||
                                codeController.text.trim() == "" ||
                                attendCodeController.text.trim() == "") {
                              EasyLoading.showInfo(
                                  'Please enter full information');
                              return;
                            }
                            // DBCrypt dBCrypt = DBCrypt();
                            // loginBloc.add(SignUpEvent(
                            //     userNameController.text,
                            //     passwordController.text,
                            //     dBCrypt.gensaltWithRounds(10),
                            //     nameController.text,
                            //     codeController.text,
                            //     attendCodeController.text));
                            signUp(
                                emailController.text, passwordController.text);
                            return;
                          },
                          child: ButtonWidget(text: 'Register')),
                      const DividerWidget(),
                      //_facebookButton(),
                      SizedBox(height: height * .055),
                      _createAccountLabel(),
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
                              builder: (context) => const LoginPage()));
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
                                  fontSize: 12, fontWeight: FontWeight.w500))
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        )),
      ),
    );
  }
}

Future signUp(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    print(e);
  }
}
