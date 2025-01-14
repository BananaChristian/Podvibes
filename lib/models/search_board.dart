import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:podvibes/models/podcast_details.dart';
import 'package:podvibes/objects/fields.dart';
import 'package:podvibes/services/itunes_service.dart';

class SearchBoard extends StatefulWidget {
  const SearchBoard({super.key});

  @override
  State<SearchBoard> createState() => _SearchBoardState();
}

class _SearchBoardState extends State<SearchBoard> {
  final TextEditingController searchController = TextEditingController();
  List<dynamic> results = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  void _loadResults() async {
    final query = searchController.text.trim();
    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a search')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });
    try {
      final service = ItunesService();
      final loadResults = await service.fetchPodcasts(query);
      setState(() {
        results = loadResults;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load podcasts: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Theme.of(context).colorScheme.primary,
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            //Search bar
            Fields(
                color: Theme.of(context).colorScheme.inversePrimary,
                hintText: 'Search anything',
                obscureText: false,
                controller: searchController,
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.inversePrimary,
                )),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Search button
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                  onPressed: _loadResults,
                  child: const Text('Search'),
                ),
                //Clearing the search bar
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                  onPressed: () {
                    setState(() {
                      searchController.clear();
                    });
                  },
                  child: const Text('Clear'),
                ),
              ],
            ),
            //Results
            Expanded(child: _buildResultsSection())
          ]),
        ),
      ),
    );
  }

  Widget _buildResultsSection() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (results.isEmpty) {
      return const Center(child: Text('No results found'));
    }

    return ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final result = results[index];
          return Card(
            color: Theme.of(context).colorScheme.primary,
            child: ListTile(
                leading: result['artworkUrl100'] != null
                    ? Image.network(result['artworkUrl100'])
                    : const Icon(FontAwesomeIcons.podcast, size: 50),
                title: Text(result['collectionName'] ?? "Unknown Podcast",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(
                  result['artistName'] ?? 'Unknown Author',
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PodcastDetails(podcast: result))
                  );
                }),
          );
        });
  }
}
