import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../manager/classification.dart';

class ClassificationBar extends StatelessWidget {
  const ClassificationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final Uri url = Uri.parse('https://aqicn.org/scale/');
          launchUrl(url);
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: const Bar(),
        ),
      ),
    );
  }
}

class Bar extends StatelessWidget {
  const Bar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SquareBox(
          ratingColor[Rating.good]!,
        ),
        SquareBox(
          ratingColor[Rating.moderate]!,
        ),
        SquareBox(
          ratingColor[Rating.sensitive]!,
        ),
        SquareBox(
          ratingColor[Rating.unhealthy]!,
        ),
        SquareBox(
          ratingColor[Rating.very]!,
        ),
        SquareBox(
          ratingColor[Rating.hazardous]!,
        )
      ],
    );
  }
}

class SquareBox extends StatelessWidget {
  final Color color;

  const SquareBox(
    this.color, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(color: color),
        ),
      ),
    );
  }
}
