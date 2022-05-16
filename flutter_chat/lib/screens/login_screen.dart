import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';

//Login screen where the user login an existing account.
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //boolean to track the loading time.
  bool loading = false;
  // firebase authentication initialization
  final _auth = FirebaseAuth.instance;
  //email and password as a string
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //loading tracking as from modal progress hud
      body: ModalProgressHUD(
        inAsyncCall: loading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          //Logo and all the fields for the contents.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //The Logo animation came from welcome screen to login screen
              Hero(
                tag: 'logoTag',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              //email textfield
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.black),
                  onChanged: (value) {
                    email = value;
                  },
                  //decoration for email field placed in constant library file.
                  decoration: kEmailFieldDecoration),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  //  password field decoration placed in library file of constants.
                  decoration: kPasswordFieldDecoration),
              const SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.lightBlueAccent,
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () async {
                      setState(
                        () {
                          loading = true;
                        },
                      );
                      try {
                        //logging authentication check

                        final loginUser =
                            await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                        if (loginUser != null) {
                          Navigator.pushNamed(context, 'contactScreen');
                        }
                      } on FirebaseAuthException catch (error) {
                        //firebase authentication errors checking and displaying
                        Fluttertoast.showToast(
                            msg: "${error.message}",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 7,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                      setState(
                        () {
                          loading = false;
                        },
                      );
                      print(email);
                      print(password);
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: const Text(
                      'Log In',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
