import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    print("🔥 Firebase initialized successfully");
  } catch (e) {
    print("❌ Firebase initialization failed: $e");
  }
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Test',
      theme: ThemeData(useMaterial3: false), 
      home: FirestoreTestPage(),
    );
  }
}


class FirestoreTestPage extends StatelessWidget {
  const FirestoreTestPage({super.key});

  Future<void> _addTestUser() async {
    await FirebaseFirestore.instance.collection('users').add({
      'username': 'brayden',
      'email': 'brayden@example.com',
      'createdAt': Timestamp.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firestore Test')),
      body: Center(
        child: ElevatedButton(
          onPressed: _addTestUser,
          child: const Text('Add Test User'),
        ),
      ),
    );
  }
}

