import 'package:flutter/material.dart';
import 'userposts.dart';


class StoryPage extends StatelessWidget {
  final List people = [
    'Sam',
    'Amy',
    'Nigel',
    'Super',
    'Walk'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        // title: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset('assets/logo.png', height: 150)],
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: people.length,
              itemBuilder: (context, index) {
                return UsersPosts(
                    name: people[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}