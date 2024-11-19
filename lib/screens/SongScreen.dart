import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SongScreen extends StatefulWidget {
  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  String videoUrl = "";
  String artist = "";
  String songName = "";
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    obtenerCancionAleatoria();
  }

  Future<void> obtenerCancionAleatoria() async {
    const String endpoint = "http://kpopMovilesDos.somee.com/api/Canciones/ObtenerCancionAleatoria";

    try {
      final response = await http.get(Uri.parse(endpoint));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final data = jsonResponse['data'][0];

        setState(() {
          artist = data['Artist'];
          songName = data['Song Name'];
          videoUrl = data['Video'];
        });

        final videoID = YoutubePlayer.convertUrlToId(videoUrl);
        setState(() {
            _controller = YoutubePlayerController(
              initialVideoId: videoID!,
              flags: const YoutubePlayerFlags(
                autoPlay: false,
              ),
            );
          });
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video"),
      ),
      body: videoUrl.isEmpty
          ? Center(child: CircularProgressIndicator()) 
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Song: $songName",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ], 
            ),
    );
  }
}
