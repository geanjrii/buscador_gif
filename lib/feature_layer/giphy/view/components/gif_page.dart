import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class GifPage extends StatelessWidget {
  final String title;
  final String imgUrl;
  const GifPage._({
    required this.title,
    required this.imgUrl,
  });

  static MaterialPageRoute router(String title, String imgUrl) {
    return MaterialPageRoute(
        builder: (context) => GifPage._(title: title, imgUrl: imgUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              Share.share(imgUrl);
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(imgUrl),
      ),
    );
  }
}
