import 'package:connect/models/user_model.dart';
import 'package:connect/providers/firebase_auth_provider.dart';
import 'package:connect/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder(
      {Key? key, required this.builder, required this.databaseBuilder})
      : super(key: key);
  final Widget Function(BuildContext, AsyncSnapshot<UserModel>) builder;
  final FirestoreDatabase Function(BuildContext context, String uid)
      databaseBuilder;
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthProvider>(context, listen: false);
    return StreamBuilder<UserModel>(
      stream: authService.user,
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
        final UserModel? user = snapshot.data;
        print('auth widget builder ' + user!.uid);
        if (user != null) {
          //Any streams that require user data goes here
          return MultiProvider(
            providers: [
              Provider<UserModel>.value(
                value: user,
              ),
              Provider<FirestoreDatabase>(
                  create: (context) => databaseBuilder(context, user.uid))
            ],
            child: builder(context, snapshot),
          );
        }
        return builder(context, snapshot);
      },
    );
  }
}
