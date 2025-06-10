import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup_page.dart';
import 'forget_password_page.dart';
import 'home_page.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      print('Login error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login failed: $e')));
    }
  }

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
            Positioned(
              top: 85,
              left: 50,
              child: Text(
                    'Welcome',
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.white,
                          offset: Offset(5, 5),
                        ),
                      ],
                      fontSize: 40,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                  .animate()
                  .shimmer(duration: 1000.ms)
                  .slide(begin: const Offset(0, -0.2), duration: 600.ms),
            ),
            Positioned(
              top: 140,
              left: 50,
              child: Text(
                    'Back',
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.white,
                          offset: Offset(5, 5),
                        ),
                      ],
                      fontSize: 40,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                  .animate()
                  .shimmer(duration: 1000.ms)
                  .slide(begin: const Offset(0, -0.2), duration: 600.ms),
            ),
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        icon: Icon(Icons.email),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.0,
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.0,
                            color: Colors.pink,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        icon: Icon(Icons.lock),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.0,
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.0,
                            color: Colors.pink,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgetPasswordPage(),
                            ),
                          );
                        },
                        child: const Text(
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
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.pink[50],
                      padding: const EdgeInsets.symmetric(
                        horizontal: 57,
                        vertical: 15,
                      ),
                    ),
                    child: const Text('Log in'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 50,
                        child: Divider(color: Colors.black26, thickness: 1),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('or'),
                      ),
                      SizedBox(
                        width: 50,
                        child: Divider(color: Colors.black26, thickness: 1),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 55,
                        vertical: 15,
                      ),
                    ),
                    child: const Text('Sign up'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
