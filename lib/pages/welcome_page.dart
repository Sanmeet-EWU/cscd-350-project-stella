import 'package:cscd350_takethat/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'signup_page.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'setting_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/welcome_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Animated Logo Image
              Image.asset('assets/logo.png', width: 300, height: 300)
                  .animate()
                  .fadeIn(duration: 1000.ms)
                  .slide(begin: const Offset(0, -0.2), duration: 1000.ms),
              const SizedBox(height: 30),
              // Animated Sign Up Button
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
                  )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slide(begin: const Offset(0.5, 0.2), duration: 1000.ms),
              const SizedBox(height: 20),
              // Animated Log In Button
              ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 57,
                        vertical: 15,
                      ),
                    ),
                    child: const Text('Log in'),
                  )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slide(begin: const Offset(-0.5, 0.2), duration: 1000.ms),
            ],
          ),
        ),
      ),
    );
  }
}
