import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'userposts.dart';

class StoryPage extends StatelessWidget {
  final List people = ['Sam', 'Amy', 'Nigel', 'Super', 'Walk'];

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

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
          if (currentUser != null)
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('photos')
                  .where('userId', isEqualTo: currentUser.uid)
                  .orderBy('timestamp', descending: true)
                  .limit(1)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  print('Firestore error: ${snapshot.error}');
                  return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text("Error loading photo."),
                   );
                  }


                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  final doc = snapshot.data!.docs.first;
                  final data = doc.data() as Map<String, dynamic>;
                  final photoUrl = data['photoUrl'] as String?;

                  if (photoUrl != null && photoUrl.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Image.network(photoUrl, height: 200),
                    );
                  }
                }

                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text("No photo available."),
                );
              },
            ),

          // UsersPosts List
          Expanded(
            child: ListView.builder(
              itemCount: people.length,
              itemBuilder: (context, index) {
                return UsersPosts(name: people[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
