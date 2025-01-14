import 'package:flutter/material.dart';
import 'package:podvibes/services/profile_service.dart';
import 'package:podvibes/auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:podvibes/pages/settings.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Auth _auth = Auth();
  final ProfileService _profileService = ProfileService();
  late String username = 'Loading...';
  late String profileImageUrl = '';
  late List<dynamic> subscriptions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
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
            username = userDoc['username'] ?? 'No username';
            subscriptions = List.from(userDoc['subscriptions'] ?? []);
            profileImageUrl = userDoc['profileImageUrl'] ?? '';
            isLoading = false;
          });
        } else {
          setState(() {
            username = 'User not found';
            subscriptions = [];
            isLoading = false;
          });
        }
      } catch (e) {
        setState(() {
          username = 'Error loading user data: $e';
          subscriptions = [];
          isLoading = false;
        });
        debugPrint('Error fetching user data: $e');
      }
    } else {
      setState(() {
        username = 'No user logged in';
        subscriptions = [];
        isLoading = false;
      });
    }
  }

  Future<void> _pickAndUploadImage() async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _profileService.uploadProfilePicture(user.uid);
    _fetchUserData();  // Fetch updated user data after the upload
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: _pickAndUploadImage,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: profileImageUrl.isNotEmpty
                            ? NetworkImage(profileImageUrl)
                            : null,
                        child: profileImageUrl.isEmpty
                            ? const Icon(Icons.person, size: 50)
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Welcome $username',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Your Subscriptions:',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  subscriptions.isEmpty
                      ? const Text(
                          'No subscriptions yet',
                          style: TextStyle(fontSize: 16),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: subscriptions.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(subscriptions[index]),
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
    );
  }
}
