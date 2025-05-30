import 'package:flutter/material.dart';

class HeroWidget extends StatelessWidget {

  const HeroWidget({super.key, required this.title,
  this.nextPage,
  });

  final String title;
  final Widget? nextPage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: nextPage != null ? (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return nextPage!;
            },
          ),
        );
      } :null,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Hero(
            tag: 'hero1',
            child: AspectRatio(
              aspectRatio: 2500/1080,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset('assets/images/wallpaper.png',
                fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          FittedBox(
            child: Text(
              'Streams of Inspiration',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: (Colors.white70),
                fontSize: 50.0,
                letterSpacing: 10.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
