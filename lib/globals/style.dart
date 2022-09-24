import 'package:flutter/material.dart';

EdgeInsets appPading() {
  return const EdgeInsets.only(
    left: 28,
    right: 28,
    top: 50,
    bottom: 50,
  );
}

final double test = appPading().right + appPading().left;

const Color mainColor = Color(0xff70DEC0);

RoundedRectangleBorder dialogShape() => const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(16.0)),
    side: BorderSide(color: mainColor, width: 1.0));

TextStyle titleStyle() => const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: mainColor,
    );

TextStyle carouselTitleStyle() => const TextStyle(
      color: Color(0xFF5B3FA4),
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );

TextStyle whiteTitleStyle() => const TextStyle(
    fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white);

TextStyle smallTitleStyle() => const TextStyle(
      fontSize: 26,
      color: mainColor,
    );

EdgeInsetsGeometry buttonPadding() =>
    const EdgeInsets.only(top: 8, bottom: 8, right: 24, left: 24);

TextStyle purpleTitleStyle() => const TextStyle(
      fontSize: 26,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    );

TextStyle textStyle() =>
    TextStyle(fontSize: 20, color: Colors.black.withOpacity(0.6));

TextStyle textBoldStyle() => TextStyle(
      fontSize: 20,
      color: Colors.black.withOpacity(0.6),
      fontWeight: FontWeight.bold,
    );

TextStyle placeHolderStyle() => TextStyle(
      fontSize: 20,
      color: Colors.black.withOpacity(0.25),
    );

TextStyle textLinkStyle() => const TextStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
      fontSize: 20,
    );

TextStyle textWhiteButtonStyle() => const TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.normal,
    );

TextStyle textLinkStyle2() => const TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );

DecorationImage lightBackgroud() => DecorationImage(
      image: const AssetImage('assets/images/v1015-101a.jpg'),
      fit: BoxFit.fitHeight,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.37), BlendMode.dstATop),
    );

DecorationImage darkBackgroud() => const DecorationImage(
      image: AssetImage('assets/images/v1015-101a.png'),
      fit: BoxFit.fitHeight,
    );
