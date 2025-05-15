import 'package:flutter/material.dart';
import 'login_page.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/signup_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            const Positioned(
              top: 85,
              left: 50,
              child: Text(
                'Create',
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
                  'Account',
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
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 30),
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
                      padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
                    ),
                    child: const Text('Sign up'),
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
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 57, vertical: 15),
                      ),
                      child: const Text('Log in'),
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
