import 'package:flutter/material.dart';
import 'screen2.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Screen1(),
      ),
    ),
  );
}

class Screen1 extends StatefulWidget {
  const Screen1({Key? key}) : super(key: key);
  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // Background Image is in it and first Container
      child: Stack(
        children: [
          Positioned(
            right: -50,
            width: 465,
            child: Image.asset("images/Texture.png"),
          ),
          Positioned(
              child: Container(
            padding: const EdgeInsets.fromLTRB(10, 220, 0, 0),
            //Centered Content of the page
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
                          color: Colors.black,
                          fontSize: 32,
                          decoration: TextDecoration.none),
                    ),
                  ),

                  //Space between first container and Second.
                  const SizedBox(
                    height: 30,
                  ),

                  //Second Container as of regular text.
                  Container(
                    width: 221,
                    height: 60,
                    child: const Text(
                      'It is now very easy to reach the best quality among all the products on the internet!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),

                  // Text button of next.
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Container(
                      height: 40,
                      width: 128,
                      decoration: const BoxDecoration(
                        color: Color(0xFF000DAE),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Screen2(),
                            ),
                          );
                        },
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  //Divider container as for line.
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: const Divider(
                      color: Colors.blue,
                      thickness: 1,
                      indent: 100,
                      endIndent: 100,
                    ),
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
