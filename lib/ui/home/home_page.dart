import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect/models/user_model.dart';
import 'package:connect/providers/firebase_auth_provider.dart';
import 'package:connect/routes.dart';
import 'package:connect/services/firestore_database.dart';
import 'package:connect/ui/components/app_bar/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);
    final auth = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
