import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

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
        title: Text(
          "Reproductor de K-pop",
          style: GoogleFonts.lilitaOne(fontSize: 24, color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: videoUrl.isEmpty
          ? Center(
              child: CircularProgressIndicator(color: Colors.purple),
            )
          : Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFF6EC7), Color(0xFF8A2BE2)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Título:",
                      style: GoogleFonts.notoSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      songName,
                      style: GoogleFonts.notoSans(
                        fontSize: 18,
                        color: Colors.yellowAccent,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Artista/Grupo:",
                      style: GoogleFonts.notoSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      artist,
                      style: GoogleFonts.notoSans(
                        fontSize: 18,
                        color: Colors.yellowAccent,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: obtenerCancionAleatoria,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purpleAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          "Obtener otra canción",
                          style: GoogleFonts.notoSans(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
