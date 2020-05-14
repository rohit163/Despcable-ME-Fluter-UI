import 'package:despicable_me/models/character.dart';
import 'package:despicable_me/pages/character_detail.dart';
import 'package:despicable_me/styleguide.dart';
import 'package:flutter/material.dart';

class CharacterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 350),
            pageBuilder: (context, _, __) =>
                CharacterDetailScreen(character: characters[0]),
          ),
        );
      },
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: CharacterCardClipper(),
              child: Hero(
                tag: "backgorund-${characters[0].name}",
                child: Container(
                  height: 0.6 * screenHeight,
                  width: 0.9 * screenWidth,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: characters[0].colors,
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, -1.2),
            child: Hero(
              tag: "image-{$characters[0].name}",
              child: Image.asset(
                characters[0].imagePath,
                height: screenHeight * 0.55,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 48.0, bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Hero(
                  tag: "name-${characters[0].name}",
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      child: Text(
                        characters[0].name,
                        style: AppTheme.heading,
                      ),
                    ),
                  ),
                ),
                Text(
                  "Tap to Read more",
                  style: AppTheme.subHeading,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CharacterCardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path clippedPath = Path();
    double curvedDistance = 40;

    clippedPath.moveTo(0, size.height * 0.4);
    clippedPath.lineTo(0, size.height - curvedDistance);
    clippedPath.quadraticBezierTo(
        1, size.height - 1, 0 + curvedDistance, size.height);

    clippedPath.lineTo(size.width - curvedDistance, size.height);
    clippedPath.quadraticBezierTo(size.width + 1, size.height - 1, size.width,
        size.height - curvedDistance);

    clippedPath.lineTo(size.width, 0 + curvedDistance);
    clippedPath.quadraticBezierTo(size.width - 1, 0,
        size.width - curvedDistance - 5, 0 + curvedDistance / 3);

    clippedPath.lineTo(curvedDistance, size.height * 0.29);
    clippedPath.quadraticBezierTo(
        1, (size.height * 0.30) + 10, 0, size.height * 0.4);
    return clippedPath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
