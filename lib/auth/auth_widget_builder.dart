import 'package:connect/models/user_model.dart';
import 'package:connect/providers/firebase_auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({Key? key, required this.builder}) : super(key: key);
  final Widget Function(BuildContext, AsyncSnapshot<UserModel>) builder;
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthProvider>(context, listen: false);
    return StreamBuilder<UserModel>(
      stream: authService.user,
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
        final UserModel? user = snapshot.data;
        if (user != null) {
          //Any streams that require user data goes here
          return MultiProvider(
            providers: [
              Provider<UserModel>.value(
                value: user,
              )
            ],
            child: builder(context, snapshot),
          );
        }
        return builder(context, snapshot);
      },
    );
  }
}
