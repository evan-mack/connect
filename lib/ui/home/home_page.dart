import 'package:connect/providers/firebase_auth_provider.dart';
import 'package:connect/ui/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  _signOut(BuildContext context) async {
    try {
      final _auth = Provider.of<AuthProvider>(context, listen: false);
      await _auth.signOut();
      print('signed out');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Home'),
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
