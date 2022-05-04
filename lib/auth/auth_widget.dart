import 'package:connect/providers/firebase_auth_provider.dart';
import 'package:connect/routes.dart';
import 'package:connect/ui/home/home_page.dart';
import 'package:connect/ui/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key? key, required this.userSnapshot}) : super(key: key);
  final AsyncSnapshot userSnapshot;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: Routes.routes,
      home: Consumer<AuthProvider>(
        builder: (_, authProviderRef, __) {
          if (userSnapshot.connectionState == ConnectionState.active) {
            return userSnapshot.data == null ? HomePage() : SignInPage();
          }
          return Material(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
