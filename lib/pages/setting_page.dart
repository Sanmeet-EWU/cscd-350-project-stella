import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'login_page.dart';
import '../main.dart'; // to access themeNotifier

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  Future<void> uploadProfilePicture() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (pickedFile == null) {
      return;
    }
    final file = File(pickedFile.path);
    final ref = FirebaseStorage.instance
        .ref()
        .child('profile_photo')
        .child('${currentUser.uid}.jpg');
    await ref.putFile(file);
    final photoUrl = await ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .update({'profilePhotoUrl': photoUrl});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Change Name'),
            onTap: () {
              String newName = '';
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text('Change Name'),
                      content: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Enter new name',
                        ),
                        onChanged: (value) => newName = value,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Name changed to $newName'),
                              ),
                            );
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_camera),
            title: const Text('Change Profile Picture'),
            onTap: () {
              uploadProfilePicture();
            },
          ),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: themeNotifier.value == ThemeMode.dark,
              onChanged: (bool value) {
                themeNotifier.value = value ? ThemeMode.dark : ThemeMode.light;
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
