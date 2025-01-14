import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:podvibes/auth/auth.dart';
import 'package:podvibes/pages/home.dart';
import 'package:podvibes/pages/profile_page.dart';
import 'package:podvibes/pages/settings.dart';
import 'package:podvibes/services/profile_service.dart';

class AppDrawer extends StatefulWidget {
  final String userId;

  const AppDrawer({super.key, required this.userId});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final ProfileService profileService = ProfileService();
  final Auth _auth = Auth();
  String username='Guest';
  String email='No email';
  bool isLoading=true;

  void logout() async {
    await Auth().signOut();
  }

  Future<void> _fetchUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            username = userDoc['username'] ?? 'Guest';
            email=userDoc['email']??'No email';
            isLoading = false;
          });
        } else {
          setState(() {
            username = 'User not found';
            isLoading = false;
          });
        }
      } catch (e) {
        setState(() {
          username = 'Error loading user data';
          isLoading = false;
        });
        debugPrint('Error fetching user data: $e');
      }
    } else {
      setState(() {
        username = 'Guest';
        isLoading = false;
      });
    }
  }

  @override
  void initState(){
    super.initState();
    _fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(username),
            accountEmail: Text(email),
            currentAccountPicture: FutureBuilder<String?>(
                future: profileService.fetchProfilePicture(widget.userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final profilePicture = snapshot.data;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfilePage()));
                    },
                    child: CircleAvatar(
                      backgroundImage: profilePicture != null
                          ? NetworkImage(profilePicture)
                          : null,
                      child: profilePicture != null
                          ? const Icon(Icons.person)
                          : null,
                    ),
                  );
                }),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              logout();
            },
          )
        ],
      )),
    );
  }
}
