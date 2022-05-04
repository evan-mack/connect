import 'package:connect/providers/firebase_auth_provider.dart';
import 'package:connect/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key, required this.title})
      : _preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);
  final String title;
  @override
  final Size _preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
            onPressed: () {
              final authProvider =
                  Provider.of<AuthProvider>(context, listen: false);
              authProvider.signOut();
              Navigator.pop(context);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.signIn, ModalRoute.withName(Routes.signIn));
            },
            icon: Icon(Icons.logout))
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => _preferredSize;
}
