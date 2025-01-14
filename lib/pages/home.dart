import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:podvibes/auth/auth.dart';
import 'package:podvibes/models/podcast_slider.dart';
import 'package:podvibes/models/podcast_details.dart';
import 'package:podvibes/models/search_board.dart';
import 'package:podvibes/objects/drawer.dart';
import 'package:podvibes/pages/other_page.dart';
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
  final service=ItunesService();
  String userId = Auth().currentUser?.uid??'Guest';

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

  @override
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
      drawer: AppDrawer(userId: userId,),
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
                          'Podcasts',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.amber, fontSize: 20),
                        ),
                        PodcastSlider(podcasts: podcasts.cast<Map<String, dynamic>>()),
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
                        padding: EdgeInsets.all(20), child: SearchBoard()
                        ),
                        ),
                        ),
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
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=>PodcastDetails(podcast: podcast,))
            );
          },
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
                    child: Image.network(podcast['artworkUrl600'] ?? '',
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
                        padding: const EdgeInsets.all(8),
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
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=>PodcastDetails(podcast: podcast,))
            );
          },
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
                    child: Image.network(podcast['artworkUrl600'] ?? '',
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
                        padding: const EdgeInsets.all(8),
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
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=>PodcastDetails(podcast: podcast,))
            );
          },
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
                    child: Image.network(podcast['artworkUrl600'] ?? '',
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
                        padding: const EdgeInsets.all(8),
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
      'Kids',
      'Gospel',
      'Sports',
      'Entertainment',
      'Health and Fitness',
      'Education',
    ];

    return ListView.builder(
      itemCount: topics.length,
      itemBuilder: (context, index) {
        final topic=topics[index];
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Card(
              color: Theme.of(context).colorScheme.primary,
              child: ListTile(
                  title: Text(topics[index],
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary)),
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder:(context)=>OthersSectionPage(topic:topic ))
                    );
                  }),
            ));
      },
    );
  }
}
