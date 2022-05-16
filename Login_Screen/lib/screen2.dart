import 'dart:ui';
import 'package:flutter/material.dart';
import 'screen3.dart';

class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            // Image as a texture in it
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

            //Centered Content of the page
            Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 40,
                    ),
                    // Logo of that app
                    Container(
                      width: 93,
                      height: 31,
                      child: Image.asset('images/Logo.png'),
                    ),
                    //Whitespace Box
                    const SizedBox(
                      height: 40,
                    ),
                    //First Container: Bold first Line.
                    Container(
                      height: 150,
                      width: 304,
                      child: const Text(
                        'The Right Address For Shopping Anyday',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Popp',
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                    ),

                    //Space between first container and Second.
                    const SizedBox(
                      height: 15,
                    ),

                    //Second Container as of regular text.
                    Container(
                      width: 221,
                      height: 60,
                      child: const Text(
                        'It is now very easy to reach the best quality among all the products on the internet!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF666666),
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 60,
                    ),
                    // Text button of next.
                    Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: const Color(0xFF000DAE),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Screen3(),
                            ),
                          );
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //Login container as for line.
                    Container(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
