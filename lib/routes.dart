import 'package:connect/ui/home/home_page.dart';
import 'package:connect/ui/sign_in/sign_in_page.dart';
import 'package:connect/ui/sign_in/sign_up_page.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  static const String home = '/home';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';

  static final routes = <String, WidgetBuilder>{
    home: (BuildContext context) => HomePage(),
    signIn: (BuildContext context) => SignInPage(),
    signUp: (BuildContext context) => SignUpPage()
  };
}
