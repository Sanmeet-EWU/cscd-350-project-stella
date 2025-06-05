import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({Key? key}) : super(key: key);

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  Future<String> uploadStoryImage(File imageFile, String userId) async {
    final storageRef = FirebaseStorage.instance;
    final imageRef = storageRef.ref().child(
      'stories/$userId/${DateTime.now().millisecondsSinceEpoch}.jpg',
    );
    await imageRef.putFile(imageFile);
    return await imageRef.getDownloadURL();
  }

  Future<void> addStoryToFirestore(String userId, String imageUrl) async {
    final storiesCollection = FirebaseFirestore.instance.collection('stories');
    await storiesCollection.add({
      'userId': userId,
      'imageUrl': imageUrl,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<Map<String, dynamic>>> get friendsStream {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return Stream.value([]);
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('friends')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) {
                final data = doc.data();
                data['id'] = doc.id;
                return data;
              }).toList(),
        );
  }

  Stream<List<Map<String, dynamic>>> getStoriesStream(
    List<String> friendsUserIds,
  ) {
    if (friendsUserIds.isEmpty) {
      return Stream.value([]);
    }
    return FirebaseFirestore.instance
        .collection('stories')
        .where('userId', whereIn: friendsUserIds)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) {
                final data = doc.data();
                data['id'] = doc.id;
                return data;
              }).toList(),
        );
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
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: friendsStream,
        builder: (context, friendsSnapshot) {
          if (friendsSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (friendsSnapshot.hasError) {
            return Center(child: Text('Error: ${friendsSnapshot.error}'));
          }
          if (!friendsSnapshot.hasData || friendsSnapshot.data!.isEmpty) {
            return const Center(child: Text("no friends found"));
          }

          final friends = friendsSnapshot.data!;
          final friendsUserIds = friends.map((f) => f['id'] as String).toList();

          //Add current user ID to see their own stories
          final currentUserId = FirebaseAuth.instance.currentUser!.uid;
          if(!friendsUserIds.contains(currentUserId)){
            friendsUserIds.add(currentUserId);
          }

          return StreamBuilder<List<Map<String, dynamic>>>(
            stream: getStoriesStream(friendsUserIds),
            builder: (context, snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapShot.hasError) {
                return Center(child: Text('Error: ${snapShot.error}'));
              }
              if (!snapShot.hasData || snapShot.data!.isEmpty) {
                return const Center(child: Text("no active stories"));
              }

              final stories = snapShot.data!;
              return ListView.builder(
                itemCount: stories.length,
                itemBuilder: (context, index) {
                  final story = stories[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        FutureBuilder<DocumentSnapshot>(
                          future:
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(story['userId'])
                                  .get(),
                          builder: (context, userSnapshot) {
                            if (userSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text('Loading...');
                            }
                            if (userSnapshot.hasError ||
                                !userSnapshot.hasData ||
                                !userSnapshot.data!.exists) {
                              return const Text('Unknown User');
                            }
                            final userData =
                                userSnapshot.data!.data()
                                    as Map<String, dynamic>;

                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  userData['profileImageUrl'] ??
                                      'https://www.pixelstalk.net/wp-content/uploads/2016/10/Blank-Wallpaper-HD.jpg',
                                ),
                              ),
                              title: Text(userData['username'] ?? 'user'),
                              subtitle: Text(
                                story['timestamp'] != null &&
                                        story['timestamp'] is Timestamp
                                    ? (story['timestamp'] as Timestamp)
                                        .toDate()
                                        .toString()
                                    : '',
                              ),
                            );
                          },
                        ),
                        Image.network(
                          story['imageUrl'] ?? '',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 300,
                          errorBuilder:
                              (context, error, stackTrace) => Image.network(
                                'https://static.vecteezy.com/system/resources/previews/036/280/651/original/default-avatar-profile-icon-social-media-user-image-gray-avatar-icon-blank-profile-silhouette-illustration-vector.jpg',
                              ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
