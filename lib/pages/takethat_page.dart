import 'package:flutter/material.dart';
import 'camera_page.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset('assets/logo.png', height: 150)],
        ),
      ),

      body: Container(
        width: 30000,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/welcome_bg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: 40.0),
              child: Text(
                'Sweet',
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 50,
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            InkWell(
              child: Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Container(
                  width: 250,
                  height: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.orange, Colors.pink, Colors.orange],
                    ),
                  ),

                  child: Center(
                    child: Text(
                      'Take a Photo',
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CameraPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}