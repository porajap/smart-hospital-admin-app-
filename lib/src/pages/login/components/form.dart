import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_hospital_admin/src/pages/my_app.dart';
import 'package:smart_hospital_admin/src/services/preferences_service.dart';
import 'package:smart_hospital_admin/src/utils/my_dialog.dart';

import '../../../services/auth_service.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/constants.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController =
      new TextEditingController(text: "");
  TextEditingController _passwordController =
      new TextEditingController(text: "");
  bool isEnabledButton = true;
  bool isShowPassword = false;

  @override
  void initState() {
    checkIsLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 50),
            Container(
              child: Image.asset(
                "${Constants.imageUrl}/logo.png",
                width: 180,
              ),
            ),
            SizedBox(height: 50),
            Column(
              children: [
                Text(
                  "ลงชื่อเข้าใช้บัญชีของคุณเพื่อดำเนินการต่อ",
                  style: TextStyle(
                      color: AppColor.textPrimaryColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _usernameController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      suffixIcon: SizedBox(), hintText: "ชื่อผู้ใช้งาน"),
                  validator: (value) {
                    if (value == null || value.length == 0) {
                      return '';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.phone,
                  obscureText: !isShowPassword,
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: (){
                        isShowPassword = !isShowPassword;

                        setState(() {

                        });
                      },
                      child: isShowPassword
                          ? Icon(Icons.visibility_outlined)
                          : Icon(Icons.visibility_off_outlined),
                    ),
                    hintText: "รหัสผ่าน",
                  ),
                  validator: (value) {
                    if (value == null || value.length == 0) {
                      return '';
                    }

                    return null;
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            buildButton(),
          ],
        ),
      ),
    );
  }

  Widget buildButton() => Container(
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: () async {
            if (!_formKey.currentState!.validate()) {
              MyDialog.dialogCustom(
                  context: context,
                  title: "Error",
                  msg: "กรุณากรอกข้อมูลให้ครบถ้วน");

              return;
            }

            await login();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text("${Constants.loginSignIn}"),
          ),
        ),
      );

  final authService = AuthService();
  final pref = SharedPreferencesService();

  late final bool isLogin;

  Future<void> login() async {
    BotToast.showLoading();

    bool _result = await authService.login(
      username: _usernameController.text.trim(),
      password: _passwordController.text.trim(),
    );
    BotToast.closeAllLoading();

    if (!_result) {
      Navigator.pushReplacementNamed(context, '/dashboard');
      return;
    }

    MyDialog.dialogCustom(
        context: context,
        title: "Error",
        msg: "username or password is invalid");
  }

  Future<void> checkIsLogin() async {
    BotToast.showLoading();
    isLogin = await pref.getIsLoggedIn();
    BotToast.closeAllLoading();

    if (isLogin) {
      Navigator.pushReplacementNamed(context, '/dashboard');
      return;
    }
  }
}
