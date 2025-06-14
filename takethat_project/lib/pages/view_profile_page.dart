import 'package:cscd350_takethat/pages/home_page.dart';
import 'package:cscd350_takethat/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewProfilePage extends StatefulWidget {
  final String userId;
  const ViewProfilePage({super.key, required this.userId});

  @override
  State<ViewProfilePage> createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  bool? _isFriend;
  bool _loadingFriendStatus = true;

  @override
  void initState() {
    super.initState();
    _checkFriendStatus();
  }

  Future<void> _checkFriendStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;
    final doc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .collection('friends')
            .doc(widget.userId)
            .get();
    setState(() {
      _isFriend = doc.exists;
      _loadingFriendStatus = false;
    });
  }

  Future<void> _addFriend() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('friends')
        .doc(widget.userId)
        .set({'addedAt': FieldValue.serverTimestamp()});
    setState(() {
      _isFriend = true;
    });
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Friend added!')));
    }
  }

  Future<void> _removeFriend() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return;
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('friends')
        .doc(widget.userId)
        .delete();
    setState(() {
      _isFriend = false;
    });
    if (mounted) {
      // if widget is mounted show snackbar
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Friend removed!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final currentUserId = currentUser?.uid;

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

      body: FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance
                .collection('users')
                .doc(widget.userId)
                .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('User not found'));
          }
          final data = snapshot.data!.data() as Map<String, dynamic>;
          final photoUrl = (data['profilePhotoUrl'] ?? '').toString();
          final username = (data['username'] ?? 'No Name').toString();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                    //arrow back icon
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 30.0,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.all(150.0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        photoUrl.isNotEmpty
                            ? NetworkImage(photoUrl)
                            : const AssetImage('assets/default_avatar.png')
                                as ImageProvider,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  username,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 30),
                if (currentUserId != null && currentUserId != widget.userId)
                  _loadingFriendStatus
                      ? const CircularProgressIndicator()
                      : _isFriend!
                      ? ElevatedButton.icon(
                        onPressed: _removeFriend,
                        icon: const Icon(Icons.person_remove),
                        label: const Text('Remove Friend'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                      )
                      : ElevatedButton.icon(
                        onPressed: _addFriend,
                        icon: const Icon(Icons.person_add),
                        label: const Text('Add Friend'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                      ),

                const SizedBox(height: 30, width: 20),
                if (currentUserId != null && currentUserId == widget.userId)
                  _loadingFriendStatus
                      ? const CircularProgressIndicator()
                      : ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingPage(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.person_2_outlined),
                        label: const Text('Edit Profile'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
