import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Last screen of display data.

//message display taken from firebase.
final _message = FirebaseFirestore.instance;
//user that were login or register.
late final user;
late User currentUser;
final loggedInUser = currentUser.email;

class ChatScreen extends StatefulWidget {
  static const String id = 'chartScreen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //Cleaning textfield after clicking send button
  final messageController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late String message;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    Firebase.initializeApp().whenComplete(
      () {
        print("Chat Screen Activated");
        setState(() {});
      },
    );
  }

  //current user email auth checking.
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          //Implement logout functionality
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
        //row for message display
        title: Row(
          children: <Widget>[
            Hero(
              tag: 'logoTag',
              child: Container(
                height: 40,
                width: 30,
                child: Image.asset('images/logo.png'),
              ),
            ),
            const Text('Chat')
          ],
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: _message
                    .collection("Chat_Data")
                    .orderBy('createdAt', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  List<MessageBubble> messageBubbles = [];
                  if (snapshot.hasData) {
                    final message =
                        (snapshot.data as QuerySnapshot).docs.reversed;
                    for (var chatData in message) {
                      final messageText = chatData['message'];
                      final messageSender = chatData['sender'];
                      //checking isMe that its logged in this device or not.
                      final messageBubble = MessageBubble(
                        sender: messageSender,
                        message: messageText,
                        isMe: loggedInUser == messageSender,
                      );
                      const TextStyle(color: Colors.green);
                      messageBubbles.add(messageBubble);
                    }
                  }
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      //displaying message as listview.
                      child: ListView(
                        reverse: true,
                        children: messageBubbles,
                      ),
                    ),
                  );
                },
              ),
              Container(
                //container decoration placed in the constant dart file.
                decoration: kMessageContainerDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        onChanged: (value) {
                          message = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        messageController.clear();
                        _message.collection('Chat_Data').add(
                          {
                            'sender': user.email,
                            'message': message,
                            //for arrangement of data datetime now is been used.
                            'createdAt': DateTime.now(),
                          },
                        );
                        print('current user is ${user.email}');
                      },
                      child: const Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//message bubble getting data from firebase as the other user's data.
class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {Key? key,
      required this.message,
      required this.sender,
      required this.isMe})
      : super(key: key);
  final bool isMe;

  final String message;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          sender,
          style: const TextStyle(color: Colors.black54, fontSize: 17),
        ),
        Material(
          borderRadius: isMe
              ? const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                )
              : const BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
          elevation: 5.0,
          //color change condition that if the user is logged in this device or not.
          color: isMe ? Colors.tealAccent : Colors.deepOrangeAccent,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
