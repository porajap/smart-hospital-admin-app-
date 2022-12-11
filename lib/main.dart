import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smart_hospital_admin/src/pages/my_app.dart';

void main() async{
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}