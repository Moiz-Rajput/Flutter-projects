import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//message display taken from firebase.
final _message = FirebaseFirestore.instance;
//user that were login or register.
late final user;
late User currentUser;
final loggedInUser = currentUser.email;
final _auth = FirebaseAuth.instance;
late String message;

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

void getCurrentUser() async {
  user = await _auth.currentUser;
  try {
    if (user != null) {
      currentUser = user;
      print("email is : ${currentUser.email}");
    }
  } catch (e) {
    print(e);
  }
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: _message.collection("Chat_Data").snapshots(),
            builder: (context, snapshot) {
              List<SenderContact> messageBubbles = [];
              if (snapshot.hasData) {
                final message = (snapshot.data as QuerySnapshot).docs.reversed;
                for (var chatData in message) {
                  final messageSender = chatData['sender'];
                  //checking isMe that its logged in this device or not.
                  final senderData = SenderContact(
                    sender: messageSender,
                  );
                  const TextStyle(color: Colors.green);
                  messageBubbles.add(senderData);
                }
              } else {
                print('error occured');
              }
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  //displaying message as listview.
                  child: ListView(
                    children: messageBubbles,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SenderContact extends StatelessWidget {
  const SenderContact({required this.sender});
  final String sender;

  @override
  Widget build(BuildContext context) {
    print('sender is $sender');
    return Column(
      children: [
        Text(
          sender,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ],
    );
  }
}
