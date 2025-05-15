import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'forget_password_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
              top: 85,
              left: 50,
              child: Text(
                'Welcome',
                style: TextStyle(
                  shadows: [
                    Shadow(blurRadius: 10.0,
                      color: Colors.white,
                      offset: Offset(5, 5),
                    ),
                  ],
                  fontSize: 40,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),

            ),
            const Positioned(
              top: 140,
              left: 50,
              child: Text(
                'Back',
                style: TextStyle(
                  shadows: [
                    Shadow(blurRadius: 10.0,
                      color: Colors.white,
                      offset: Offset(5, 5),
                    ),
                  ],
                  fontSize: 40,
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
                          hintText: 'Username',
                          icon: Icon(Icons.person),
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
                          hintText: 'Password',
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
                    const SizedBox(height: 15),
                    Positioned(
                      width: 350,
                      child: Padding(
                        padding: EdgeInsets.only(right: 32), // Add right padding
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ForgetPasswordPage()),
                            );
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forget password?',
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
                      child: const Text('Log in'),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(
                          width: 50, // adjust this width as needed
                          child: Divider(
                            color: Colors.black26,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text('or'),
                        ),
                        SizedBox(
                          width: 50,
                          child: Divider(
                            color: Colors.black26,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),

                    // Signup Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignupPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
                      ),
                      child: const Text('Sign up'),
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
