// ignore_for_file: prefer_const_constructors

import 'package:connect/providers/firebase_auth_provider.dart';
import 'package:connect/routes.dart';
import 'package:connect/services/firestore_database.dart';
import 'package:connect/ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Align(
        alignment: Alignment.center,
        child: _buildForm(context),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget _buildForm(BuildContext context) {
    final _auth = Provider.of<AuthProvider>(context, listen: false);

    return Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email), labelText: 'Email'),
              ),
              TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock), labelText: 'Password')),
              _auth.status == Status.authenticating
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        bool status = await _auth.signInWithEmailAndPassword(
                            emailController.text, passwordController.text);

                        if (!status) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Log in Error"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Log in Successful"),
                            duration: Duration(seconds: 2),
                          ));
                          Navigator.of(context)
                              .pushReplacementNamed(Routes.home);
                        }
                      },
                      child: Text('Log In')),
              TextButton(
                  onPressed: () =>
                      {Navigator.of(context).pushNamed(Routes.signUp)},
                  child: Text('Need an account?')),
              TextButton(
                  onPressed: () =>
                      PasswordResetDialog(context, emailController.text),
                  child: Text('Forgot Password?'))
            ],
          ),
        )));
  }
}

Future<dynamic> PasswordResetDialog(BuildContext context, String email) {
  final _auth = Provider.of<AuthProvider>(context, listen: false);
  final emailController = TextEditingController();
  emailController.text = email;
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            scrollable: true,
            content: Form(
                child: Column(
              children: [
                Text('Send an email to reset your password'),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: "Email"),
                ),
                ElevatedButton(
                    onPressed: () {
                      _auth.sendPasswordResetEmail(emailController.text);
                    },
                    child: Text('Reset Password'))
              ],
            )));
      });
}
