import 'package:flutter/material.dart';

import '../Services/api service.dart';

class GiphyPage extends StatefulWidget {
  const GiphyPage({super.key});

  @override
  State<GiphyPage> createState() => _GiphyPageState();
}

class _GiphyPageState extends State<GiphyPage> {
  final ApiService _giphyApiService = ApiService();
  List<dynamic> _gifs = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    fetchTrending();
    super.initState();
  }

  void fetchTrending() async {
    final gifs = await _giphyApiService.fetchTrendingGifs();
    setState(() {
      _gifs = gifs;
    });
  }

  void searchGifs(String query) async {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
      });
      fetchTrending();
      return;
    }

    setState(() {
      _isSearching = true;
    });

    final gifs = await _giphyApiService.searchGifs(query);
    setState(() {
      _gifs = gifs;
    });

    debugPrint('found gif: $gifs');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giphy Gif'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                  hintText: 'Search GIF', suffixIcon: Icon(Icons.search)),
              onChanged: (value) => searchGifs(value),
            ),
          ),
          Expanded(
            child: _gifs.isEmpty
                ? Center(child: CircularProgressIndicator())
                : GridView.builder(
                    padding: EdgeInsets.all(8),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: _gifs.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        _gifs[index]["images"]["original"]["url"],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
