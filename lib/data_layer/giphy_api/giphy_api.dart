import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'giphy_model.dart';

class GiphyApi {
  final http.Client client;

  GiphyApi({http.Client? client}) : client = client ?? http.Client();

  String? _search;

  int _offset = 0;

  final int _limit = 20;

  static const imgBar =
      'https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif';

  Future<List<GiphyModel>> getGifs() async {
    final Uri uri = _buildUri();

    final response = await client.get(uri);

    if (response.statusCode != 200) return throw GifLoadingException();

    final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

    if (!jsonData.containsKey('data')) throw GifNotFoundFailure();

    final List gifList = jsonData['data'];

    if (gifList.isEmpty) throw GifNotFoundFailure();

    final List<GiphyModel> gifs =
        gifList.map((json) => GiphyModel.fromJson(json)).toList();

    return gifs;
  }

  void search(String? text) {
    _search = text;
    _offset = 0;
  }

  void loadMoreGifs() {
    _offset += _limit;
  }

  Uri _buildUri() {
    const apiKey = 'tYc77xALD3DXpJcJ8dhAb5hv9bDts8lw';

    const baseUrl = 'https://api.giphy.com/v1/gifs';

    String url;

    final bool isSearchEmpty = _search == null || _search == '';

    if (isSearchEmpty) {
      url =
          '$baseUrl/trending?api_key=$apiKey&limit=$_limit&offset=$_offset&rating=g';
    } else {
      url =
          '$baseUrl/search?api_key=$apiKey&q=$_search&limit=$_limit&offset=$_offset&rating=g&lang=en';
    }

    return Uri.parse(url);
  }
}

class GifLoadingException implements Exception {}

class GifNotFoundFailure implements Exception {}

final Map<String, dynamic> apiResponse = {
  "data": [
    {
      "title": "Gif 1",
      "images": {
        "fixed_height": {"url": "https://example.com/gif1.gif"}
      }
    },
  ]
};
