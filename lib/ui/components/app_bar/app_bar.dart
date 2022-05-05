import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect/models/user_model.dart';
import 'package:connect/providers/firebase_auth_provider.dart';
import 'package:connect/routes.dart';
import 'package:connect/services/firestore_database.dart';
import 'package:connect/ui/components/app_bar/status_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key})
      : _preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);
  @override
  final Size _preferredSize;
  @override
  Widget build(BuildContext context) {
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return AppBar(
      leading: Padding(
        padding: EdgeInsets.symmetric(vertical: 6),
        child: CircleAvatar(
          backgroundColor: Colors.deepPurple,
          radius: 16.0,
        ),
      ),
      title: StreamBuilder<UserModel>(
          stream: auth.user,
          builder:
              (BuildContext context, AsyncSnapshot<UserModel> authSnapshot) {
            final UserModel? user = authSnapshot.data;
            return FutureBuilder(
              future: firestoreDatabase.getCurrentUser(user!.uid),
              builder: ((context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text(data['displayName']), StatusBar()]);
                }
                return Text('Home');
              }),
            );
          }),
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
