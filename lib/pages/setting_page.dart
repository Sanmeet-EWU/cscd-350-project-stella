import 'package:cscd350_takethat/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import '../main.dart'; // to access themeNotifier

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

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
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
            icon: const Icon(Icons.edit),
            label: const Text('Edit Profile'),
          ),
        ],
      ),
    );
  }
}
