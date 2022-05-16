// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/screens/welcome_screen.dart';
import 'package:flutter_chat/screens/login_screen.dart';
import 'package:flutter_chat/screens/registration_screen.dart';
import 'package:flutter_chat/screens/chat_screen.dart';
import 'package:flutter_chat/screens/contact_screen.dart';

void main() async {
  //Initialization of firebase:
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const FlashChat());
}

//First class
class FlashChat extends StatelessWidget {
  const FlashChat({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Colors.black54),
        ),
      ),
      // Routes for all screens.
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        'loginScreen': (context) => const LoginScreen(),
        'registrationScreen': (context) => const RegistrationScreen(),
        'chatScreen': (context) => const ChatScreen(),
        'contactScreen': (context) => const ContactScreen(),
      },
    );
  }
}
