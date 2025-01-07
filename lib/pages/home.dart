import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:podvibes/auth/auth.dart';
import 'package:podvibes/models/new_podcasts.dart';
import 'package:podvibes/models/podcast_player.dart';
import 'package:podvibes/models/search_board.dart';
import 'package:podvibes/pages/profile.dart';
import 'package:podvibes/pages/settings.dart';
import 'package:podvibes/services/itunes_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedSection = 'Technology';
  bool isSearchBoardVisible = false;
  List<dynamic> podcasts = [];
  bool isLoading = false;
  String category = '';

  void logout() {
    Auth().signOut();
  }

  @override
  void initState() {
    super.initState();
    _loadPodcasts(selectedSection);
  }

  void _loadPodcasts(String category) async {
    setState(() {
      isLoading = true;
    });

    try {
      final service = ItunesService();
      final results = await service.fetchPodcasts(category);
      setState(() {
        podcasts = results;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to load podcasts: $e')));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                IconButton(
                    icon: Icon(
                        isSearchBoardVisible ? Icons.close : Icons.search,
                        color: Theme.of(context).colorScheme.inversePrimary),
                    onPressed: () {
                      setState(() {
                        isSearchBoardVisible = !isSearchBoardVisible;
                      });
                    })
              ],
            ),
          ),
        ],
      ),
      drawer: SafeArea(
        child: Drawer(
            backgroundColor: Theme.of(context).colorScheme.surface,
            child: ListView(padding: const EdgeInsets.all(10), children: [
              DrawerHeader(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Theme.of(context).colorScheme.primary),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage()));
                  },
                  child: Hero(
                    tag: 'profile picture',
                    child: Container(
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage('assets/author2.png'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text('Welcome User')),
                  ),
                ),
              ),
              //Home
              ListTile(
                  leading: Icon(Icons.home,
                      color: Theme.of(context).colorScheme.inversePrimary),
                  title: Text('Home',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary)),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Home()));
                  }),
              //Downloads
              ListTile(
                  leading: Icon(Icons.download,
                      color: Theme.of(context).colorScheme.inversePrimary),
                  title: Text('Downloads',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary)),
                  onTap: () {}),
              //Settings
              ListTile(
                  leading: Icon(Icons.settings,
                      color: Theme.of(context).colorScheme.inversePrimary),
                  title: Text('Settings',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsPage()));
                  }),
              //Subscriptions
              ListTile(
                  leading: Icon(Icons.subscriptions,
                      color: Theme.of(context).colorScheme.inversePrimary),
                  title: Text('Subscriptions',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary)),
                  onTap: () {}),
              //History
              ListTile(
                  leading: Icon(Icons.history,
                      color: Theme.of(context).colorScheme.inversePrimary),
                  title: Text('History',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary)),
                  onTap: () {}),
              //Favorites
              ListTile(
                  leading: Icon(Icons.favorite,
                      color: Theme.of(context).colorScheme.inversePrimary),
                  title: Text('Favorites',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary)),
                  onTap: () {}),
              //Logout
              ListTile(
                  leading: Icon(Icons.logout,
                      color: Theme.of(context).colorScheme.inversePrimary),
                  title: Text('Log out',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary)),
                  onTap: () {
                    logout();
                  })
            ])),
      ),
      body: Stack(
        children: [
          Container(
            color: Theme.of(context).colorScheme.surface,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                      ),
                      image: DecorationImage(
                          image: const AssetImage('assets/bg_home.png'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.8),
                              BlendMode.dstATop)),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'New Podcasts',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        NewPodcast(
                            image: 'assets/cat.png',
                            hoverText: 'Cats',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PodcastPlayer()));
                            }),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                //Main section
                const SizedBox(height: 10),
                const SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  _buildSectionToggle('Technology'),
                  const SizedBox(width: 20),
                  _buildSectionToggle('History'),
                  const SizedBox(width: 20),
                  _buildSectionToggle('Science'),
                  const SizedBox(width: 20),
                  _buildSectionToggle('Others'),
                ]),
                const SizedBox(height: 20),
                //Section content
                Expanded(child: _buildSectionContent()),
              ],
            ),
          ),
          //Searchboard handler
          if (isSearchBoardVisible)
            Positioned(
                top: 0,
                left: 0,
                bottom: 0,
                right: 0,
                child: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const Padding(
                        padding: EdgeInsets.all(20), child: SearchBoard()))),
        ],
      ),
    );
  }

  //Widget to create toggeable section
  Widget _buildSectionToggle(String section) {
    bool isSelected = selectedSection == section;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSection = section;
        });
        _loadPodcasts(section);
      },
      child: Text(section,
          style: TextStyle(
              color: isSelected
                  ? Colors.amber
                  : Theme.of(context).colorScheme.inversePrimary,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: isSelected ? 18 : 16)),
    );
  }

  //Widget for the section content
  Widget _buildSectionContent() {
    switch (selectedSection) {
      case 'Technology':
        return _buildTechnologySection();
      case 'History':
        return _buildHistorySection();
      case 'Science':
        return _buildScienceSection();
      case 'Others':
        return _buildTopicsList();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildTechnologySection() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (podcasts.isEmpty) {
      return const Center(child: Text('No podcats found'));
    }

    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            ),
      itemCount: podcasts.length,
      itemBuilder: (context, index) {
        final podcast = podcasts[index];
        return GestureDetector(
          onTap: () {},
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 5,
            color: Theme.of(context).colorScheme.primary,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(podcast['artworkUrl100'] ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                              color: Colors.grey[300],
                              child: const Icon(FontAwesomeIcons.podcast,
                                  size: 50, color: Colors.grey),
                            )),
                  ),
                  //Text
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.black.withOpacity(0.6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              podcast['collectionName'] ?? 'Unknown Podcast',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              podcast['artistName'] ?? 'Unknown Author',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildScienceSection() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (podcasts.isEmpty) {
      return const Center(child: Text('No podcasts found'));
    }

    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            ),
      itemCount: podcasts.length,
      itemBuilder: (context, index) {
        final podcast = podcasts[index];
        return GestureDetector(
          onTap: () {},
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 5,
            color: Theme.of(context).colorScheme.primary,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(podcast['artworkUrl100'] ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                              color: Colors.grey[300],
                              child: const Icon(FontAwesomeIcons.podcast,
                                  size: 50, color: Colors.grey),
                            )),
                  ),
                  //Text
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.black.withOpacity(0.6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              podcast['collectionName'] ?? 'Unknown Podcast',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              podcast['artistName'] ?? 'Unknown Author',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHistorySection() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (podcasts.isEmpty) {
      return const Center(child: Text('No podcasts found'));
    }

    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            ),
      itemCount: podcasts.length,
      itemBuilder: (context, index) {
        final podcast = podcasts[index];
        return GestureDetector(
          onTap: () {},
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 5,
            color: Theme.of(context).colorScheme.primary,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(podcast['artworkUrl100'] ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                              color: Colors.grey[300],
                              child: const Icon(FontAwesomeIcons.podcast,
                                  size: 50, color: Colors.grey),
                            )),
                  ),
                  //Text
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.black.withOpacity(0.6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              podcast['collectionName'] ?? 'Unknown Podcast',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              podcast['artistName'] ?? 'Unknown Author',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopicsList() {
    final topics = [
      'Lifestyle',
      'Science',
      'Technology',
      'Business',
      'History',
      'News',
      'Sports',
      'Entertainment',
      'Health and Fitness',
      'Education'
    ];

    return ListView.builder(
      itemCount: topics.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Card(
              color: Theme.of(context).colorScheme.primary,
              child: ListTile(
                  title: Text(topics[index],
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary)),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Selected topics: ${topics[index]}')));
                  }),
            ));
      },
    );
  }
}
