import 'package:connect/auth/auth_widget.dart';
import 'package:connect/auth/auth_widget_builder.dart';
import 'package:connect/providers/firebase_auth_provider.dart';
import 'package:connect/routes.dart';
import 'package:connect/services/firestore_database.dart';
import 'package:connect/ui/home/home_page.dart';
import 'package:connect/ui/sign_in/sign_in_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp(
    databaseBuilder: (_, uid) => FirestoreDatabase(uid: uid),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.databaseBuilder}) : super(key: key);
  final FirestoreDatabase Function(BuildContext context, String uid)
      databaseBuilder;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider(),
          ),
        ],
        child: AuthWidgetBuilder(
            databaseBuilder: databaseBuilder,
            builder: (context, userSnapshot) {
              return MaterialApp(
                routes: Routes.routes,
                home: Consumer<AuthProvider>(
                  builder: (_, authProviderRef, __) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.active) {
                      return userSnapshot.data == null
                          ? HomePage()
                          : SignInPage();
                    }
                    return Material(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              );
            }));
  }
}
