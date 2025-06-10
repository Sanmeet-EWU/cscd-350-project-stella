import 'package:flutter/material.dart';
import 'login_page.dart';

class RecoveryPasswordPage extends StatelessWidget {
  const RecoveryPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            const Positioned(
              top: 250,
              left: 50,
              child: Text(
                'Recovery Password',
                style: TextStyle(
                  shadows: [
                    Shadow(blurRadius: 10.0,
                      color: Colors.white,
                      offset: Offset(5, 5),
                    ),
                  ],
                  fontSize: 35,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
           Positioned(bottom: 100, left: 0, right: 0,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Reset Code',
                          icon: Icon(Icons.code),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 1.0, color: Colors.grey), // normal underline
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 1.0, color: Colors.pink), // underline when focused
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'New Password',
                          icon: Icon(Icons.password),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 1.0, color: Colors.grey), // normal underline
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 1.0, color: Colors.pink), // underline when focused
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          icon: Icon(Icons.password),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 1.0, color: Colors.grey), // normal underline
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 1.0, color: Colors.pink), // underline when focused
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()), //change this to the external
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.pink[50],
                        padding: const EdgeInsets.symmetric(horizontal: 57, vertical: 15),
                      ),
                      child: const Text('Confirm'),
                    ),
                    const SizedBox(height: 15),

                  ],
                ))

            // You can add more widgets below, like form or buttons
          ],
        ),
      ),
    );
  }
}


