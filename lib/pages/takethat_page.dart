import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  File? _imageFile;



Future<void> _takePhoto() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.camera);

  if (pickedFile != null) {
    setState(() {
      _imageFile = File(pickedFile.path);
    });

    // Step 1: Upload to Firebase Storage
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_photos')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

      await storageRef.putFile(_imageFile!);
      final downloadURL = await storageRef.getDownloadURL();

      print('Photo uploaded. Download URL: $downloadURL');

      // Step 2 Save download URL and metadata to database Add in extra feilds if you want
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('photos').add({
          'userId': user.uid,
          'photoUrl': downloadURL,
          'timestamp': FieldValue.serverTimestamp(),
          // add extra feilds here to store in database
        });
        print('Metadata saved to Firestore.');
      } else {
        print('No user is signed in.');
      }

    } catch (e) {
      print('Upload or Firestore write failed: $e');
    }
  }
}



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
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/welcome_bg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sweet',
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 50,
                color: Colors.black,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            if (_imageFile != null)
              Image.file(_imageFile!, height: 250)
            else
              const Text('No photo taken yet.', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 40),
            InkWell(
              onTap: _takePhoto,
              child: Container(
                width: 250,
                height: 75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.orange, Colors.pink, Colors.orange],
                  ),
                ),
                child: const Center(
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
          ],
        ),
      ),
    );
  }
}
