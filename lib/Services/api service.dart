import 'dart:convert';

import 'package:http/http.dart' as http;

final apiKey = "cBgV6meDZnknZANwUp9FTguZb8jc96RP";

class ApiService {
  final trendingurl = "https://api.giphy"
      ".com/v1/gifs/trending?api_key=$apiKey&limit=10";
  // final searchUrl =
  //     "https://api.giphy.com/v1/gifs/search?api_key=$apiKey&limit=$10&q=${Uri
  //     .encodeComponent(query)}";

  // Fetch Trending GIFs
  Future<List<dynamic>> fetchTrendingGifs({int limit = 10}) async {
    try {
      final response = await http.get(
        Uri.parse(trendingurl),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] as List<dynamic>; // Extract the list of GIFs
      }
    } catch (e) {
      print("Error fetching trending GIFs: $e");
    }
    return [];
  }

  // // Search for GIFs
  // Future<List<dynamic>> searchGifs(String query, {int limit = 10}) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse(searchUrl),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       return data['data'] as List<dynamic>; // Extract the list of GIFs
  //     }
  //   } catch (e) {
  //     print("Error searching GIFs: $e");
  //   }
  //   return [];
  // }

  Future<List<dynamic>> searchGifs(String query, {int limit = 10}) async {
    try {
      final url =
          "https://api.giphy.com/v1/gifs/search?api_key=$apiKey&limit=$limit&q=${Uri.encodeComponent(query)}";
      print("Fetching GIFs from: $url"); // Debugging URL

      final response = await http.get(Uri.parse(url));

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}"); // Debugging response

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] as List<dynamic>;
      }
    } catch (e) {
      print("Error searching GIFs: $e");
    }
    return [];
  }
}
