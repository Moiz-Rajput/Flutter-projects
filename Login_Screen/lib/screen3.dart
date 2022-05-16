import 'dart:ui';
import 'package:flutter/material.dart';
import 'main.dart';

class Screen3 extends StatefulWidget {
  const Screen3({Key? key}) : super(key: key);
  @override
  _Screen3State createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Positioned(
              right: -50,
              width: 465,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: const Image(
                    image: AssetImage("images/Texture.png"),
                    fit: BoxFit.fitWidth),
              ),
            ),

            //Main Container for data on screen3
            Container(
              //Centered Content of the page
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 93,
                      height: 31,
                      child: Image.asset('images/Logo.png'),
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    // First Container: Bold first Line.
                    Container(
                      height: 48,
                      width: 239,
                      child: const Text(
                        'Lets Register.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Popp',
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                    ),

                    //Second Container as of regular text.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Do you have an account?',
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(10, 30)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Login',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 56,
                      width: 300,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5),
                      child: const TextField(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'SSPro',
                          color: Colors.grey,
                        ),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.black)),
                          hintText: 'First Name',
                          border: InputBorder.none,
                        ),
                        // InputDecoration.collapsed(hintText: 'First Name'),
                      ),
                    ),

                    Container(
                      height: 56,
                      width: 300,
                      child: const TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '|',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    Container(
                      height: 56,
                      width: 300,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5),
                      child: const TextField(
                        style: TextStyle(
                          fontFamily: 'SSPro',
                          color: Color(0xFF000759),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.black)),
                          hintText: 'moguzbulbul@gmail.com',
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    Container(
                      height: 56,
                      width: 300,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5),
                      child: const TextField(
                        style: TextStyle(
                          fontFamily: 'SSPro',
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.black)),
                          hintText: 'Phone or Mail',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),

                    // Text button of Register
                    Container(
                      height: 56,
                      width: 340,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: const Color(0xFF000DAE),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Screen1(),
                            ),
                          );
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Popp',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 140,
                          height: 40,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: Container(
                              height: 16,
                              width: 16,
                              child: Image.asset(
                                'images/facebook.png',
                              ),
                            ),
                            label: const Text(
                              'Facebook',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              shape: const RoundedRectangleBorder(
                                  side:
                                      BorderSide(color: Colors.grey, width: 1)),
                              primary: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Container(
                          width: 140,
                          height: 40,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: Container(
                                height: 16,
                                width: 16,
                                child: Image.asset('images/gmail icon.png')),
                            label: const Text(
                              'Gmail',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              shape: const RoundedRectangleBorder(
                                  side:
                                      BorderSide(color: Colors.grey, width: 1)),
                              primary: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
