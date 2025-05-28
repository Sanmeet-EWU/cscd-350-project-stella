import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _photoUrlController = TextEditingController();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final doc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
    if (doc.exists) {
      setState(() {
        _bioController.text = doc.data()?['bio'] ?? '';
        _photoUrlController.text = doc.data()?['profilePhotoUrl'] ?? '';
      });
    }
  }

  Future<void> _updateProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    setState(() => _loading = true);
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'bio': _bioController.text.trim(),
      'profilePhotoUrl': _photoUrlController.text.trim(),
      'username': user.displayName ?? user.email ?? 'User',
    }, SetOptions(merge: true));
    setState(() => _loading = false);
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Profile updated!')));
    }
  }

  @override
  void dispose() {
    _bioController.dispose();
    _photoUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final photoUrl = _photoUrlController.text.trim();
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body:
          _loading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          photoUrl.isNotEmpty
                              ? NetworkImage(photoUrl)
                              : const AssetImage('assets/default_avatar.png')
                                  as ImageProvider,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _photoUrlController,
                      decoration: const InputDecoration(
                        labelText: 'Profile Photo URL',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _bioController,
                      decoration: const InputDecoration(
                        labelText: 'Bio',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _updateProfile,
                      child: const Text('Save Changes'),
                    ),
                  ],
                ),
              ),
    );
  }
}
