import 'package:flutter/material.dart';

import '../pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          //logo
          Icon(Icons.music_note),
          //home tile
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage(),));
            },
          ),
        ],
      ),
    );
  }
}
