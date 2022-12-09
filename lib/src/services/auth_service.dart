import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:smart_hospital_admin/src/services/preferences_service.dart';
import 'package:smart_hospital_admin/src/services/urls.dart';

import '../../main.dart';
import '../models/login/logged_model.dart';
import '../pages/my_app.dart';
import '../utils/constants.dart';
import 'custom_exception.dart';

class AuthService {
  final prefService = SharedPreferencesService();

  Future<bool> login({required String username, required String password}) async {
    LoggedModel _data = LoggedModel();

    try {
      var _response;

      final _url = Uri.parse('${AppUrl.login}');

      Map<String, dynamic> _body = {
        'username': username,
        'password': password,
      };

      _response = await http.post(_url, body: _body).timeout(
        Duration(seconds: 3),
        onTimeout: () {
          throw AuthenticationException(message: '${Constants.textInternetLost}');
        },
      );

      if (_response.statusCode != 200) {
        throw AuthenticationException(message: '${Constants.textLoginFailed}');
      }

      final _jsonResponse = json.decode(_response.body);

      _data = LoggedModel.fromJson(_jsonResponse);

      bool _error = _data.error ?? false;
      if(!_error){
        await prefService.setIsLoggedIn(isLogin: true);
        await prefService.setUserLoggedIn(data: _data);
      }

      return _error;
    } on SocketException {
      throw AuthenticationException(message: '${Constants.textInternetLost}');
    } on TimeoutException {
      throw AuthenticationException(message: '${Constants.textInternetLost}');
    } catch (err) {
      logger.e(err);
      return false;
    }
  }

  Future<void> logout() async {
    await prefService.setIsLoggedIn(isLogin: false);
    await prefService.clearDataUser();
    loggerNoStack.w("log out successfully");
    return await Future<void>.delayed(Duration(seconds: 1));
  }
}
