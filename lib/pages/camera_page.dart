import 'package:flutter/material.dart';
import 'home_page.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

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
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 310.0),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 30.0,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ), //change this to the external
                    );
                  },
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'camera',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  bottom: 40.0,
                  left: BorderSide.strokeAlignCenter,
                  right: BorderSide.strokeAlignCenter,
                ),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey,
                    ),
                    child: SizedBox(height: 400, width: 380),
                  ),
                ),
              ),

              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      color: Colors.grey,
                    ),
                    child: SizedBox(height: 100, width: 100),
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
