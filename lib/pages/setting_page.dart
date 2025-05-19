import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true, // optional: centers the title
        backgroundColor: Colors.purple[50],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Change Name'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  String newName = '';
                  return AlertDialog(
                    title: const Text('Change Name'),
                    content: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Enter new name',
                      ),
                      onChanged: (value) {
                        newName = value;
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle saving the new name here
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Name changed to $newName')),
                          );
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.password),
            title: const Text('Change Password'),
          ),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('Theme'),
          )
        ],
      ),
    );
  }
}
