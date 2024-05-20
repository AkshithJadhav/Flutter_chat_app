import 'package:flutter/material.dart';
import '../services/auth/auth_service.dart';
import '../pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    //get auth service
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          //icon
          Center(
            child: DrawerHeader(
                child: Icon(
              Icons.message,
              color: Theme.of(context).colorScheme.primary,
              size: 40,
            )),
          ),
          //home tile
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: ListTile(
              title: const Text('H O M E'),
              leading: const Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          //settings tile
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: ListTile(
              title: const Text('S E T T I N G S'),
              leading: const Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);
                //go to settings page
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ));
              },
            ),
          ),
          const Spacer(flex: 1),
          //log out
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 20),
            child: ListTile(
              title: const Text('L O G  O U T'),
              leading: const Icon(Icons.logout_rounded),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
