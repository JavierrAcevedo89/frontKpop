import 'package:flutter/material.dart';
import 'songscreen.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inicio',
          style: GoogleFonts.lilitaOne(fontSize: 24, color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFF6EC7), Color(0xFF8A2BE2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purpleAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SongScreen()),
              );
            },
            child: Text(
              'Ver Canción Aleatoria',
              style: GoogleFonts.notoSans(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
