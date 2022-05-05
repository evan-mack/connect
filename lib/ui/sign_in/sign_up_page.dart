import 'package:connect/models/user_model.dart';
import 'package:connect/providers/firebase_auth_provider.dart';
import 'package:connect/routes.dart';
import 'package:connect/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailControllor = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Align(
          alignment: Alignment.center,
          child: _buildForm(context),
        ));
  }

  Widget _buildForm(BuildContext context) {
    final _auth = Provider.of<AuthProvider>(context, listen: false);
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              TextFormField(
                controller: _emailControllor,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Enter your email'),
              ),
              TextFormField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Enter a password'),
              ),
              _auth.status == Status.registering
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () async {
                        UserModel userModel =
                            await _auth.registerWithEmailAndPassword(
                                _emailControllor.text,
                                _passwordController.text);

                        if (userModel.email == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Sign Up Error'),
                            duration: Duration(seconds: 1),
                          ));
                        } else {
                          userModel.displayName = _firstNameController.text +
                              " " +
                              _lastNameController.text;
                          await FirestoreDatabase(uid: userModel.uid)
                              .addNewUser(userModel.toMap());
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              Routes.home, (Route<dynamic> route) => false);
                        }
                      },
                      child: Text('Sign Up'))
            ],
          ),
        ),
      ),
    );
  }
}
