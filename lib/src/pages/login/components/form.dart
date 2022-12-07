import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_hospital_admin/src/utils/my_dialog.dart';

import '../../../utils/app_theme.dart';
import '../../../utils/constants.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = new TextEditingController(text: "");
  TextEditingController _passwordController = new TextEditingController(text: "");
  bool isEnabledButton = true;

  @override
  void initState() {
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
                  style: TextStyle(color: AppColor.textPrimaryColor, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _usernameController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(suffixIcon: SizedBox(), hintText: "ชื่อผู้ใช้งาน"),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(suffixIcon: SizedBox(), hintText: "รหัสผ่าน"),
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
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              MyDialog.dialogCustom(context: context, title: "Error", msg: "ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง");

              return;
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text("${Constants.loginSignIn}"),
          ),
        ),
      );

  Future<void> login() async {
    // context.read<AuthBloc>().add(AuthEventCheckLogin(phone: _phoneController.text.trim()));
  }
}
