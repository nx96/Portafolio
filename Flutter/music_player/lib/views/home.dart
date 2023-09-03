import 'package:flutter/material.dart';
import 'package:music_player/consts/colors.dart';
import 'package:music_player/consts/text_style.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgDarkColor,
      appBar: AppBar(
        backgroundColor: bgColor,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: whiteColor,
                ))
          ],
          leading: Icon(Icons.sort_rounded, color: whiteColor),
          title: Text("Nx Player", style: ourStyle(family: bold, size: 18))),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 50,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
                tileColor: bgColor,
                title: Text(
                  "Music name",
                  style: ourStyle(family: regular, size: 15),
                ),
                subtitle: Text(
                  "Artist name",
                  style: ourStyle(family: bold, size: 12),
                ),
                leading: const Icon(
                  Icons.music_note,
                  color: whiteColor,
                  size: 32,
                ),
                trailing:
                    const Icon(Icons.play_arrow, color: whiteColor, size: 26),
              ),
            );
          },
        ),
      ),
    );
  }
}
