import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../constants.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool loading = false;
  final _auth = FirebaseAuth.instance;
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
          //main body as column items.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //Animation of logo to make it small or big from welcome screen onwards.
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
              //Text fields for email.
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                  onChanged: (value) {
                    //Do something with the user input.
                    email = value;
                  },
                  //  decoration for the email field
                  decoration: kEmailFieldDecoration),
              const SizedBox(
                height: 8.0,
              ),
              // password fields for password
              TextField(
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                  //  field decoration for password place in constant dart file
                  decoration: kPasswordFieldDecoration),
              const SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.blueAccent,
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () async {
                      setState(
                        () {
                          loading = true;
                        },
                      );
                      //email and password checking and logging in authentication.
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (newUser != null) {
                          Navigator.pushNamed(context, 'chatScreen');
                        }
                      } on FirebaseAuthException catch (error) {
                        //Error message display
                        Fluttertoast.showToast(
                            msg: "${error.message}",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 7,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);

                        if (error.toString() == 'firebase_auth/invalid-email') {
                          print("invalid Email address");
                        }
                      } catch (error) {
                        print('Generic Errors has occured');
                      }
                      setState(() {
                        loading = false;
                      });
                      //Implement registration functionality.
                      print(email);
                      print(password);
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
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
