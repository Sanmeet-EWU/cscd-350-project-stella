import 'package:flutter/material.dart';
import 'login_page.dart';
import 'recovery_password_pass.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

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
              left: 70,
              child: Text(
                'Forget Password',
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
            Positioned(bottom: 200, left: 0, right: 0,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          icon: Icon(Icons.email),
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
                          MaterialPageRoute(builder: (context) => const RecoveryPasswordPage()), //change this to the external
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.pink[50],
                        padding: const EdgeInsets.symmetric(horizontal: 57, vertical: 15),
                      ),
                      child: const Text('Send email'),
                    ),
                    const SizedBox(height: 15),
                    Positioned(
                      width: 350,
                      child: Padding(
                        padding: EdgeInsets.only(right: 32), // Add right padding
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginPage()),
                            );
                          },
                          child: Align(
                            alignment: Alignment(0,100),
                            child: Text(
                              'Already have account? Login',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ))

            // You can add more widgets below, like form or buttons
          ],
        ),
      ),
    );
  }
}


