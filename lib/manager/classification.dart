import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../main.dart';

enum Rating { onUpdate, good, moderate, sensitive, unhealthy, very, hazardous }

Map<Rating, Color> ratingColor = {
  Rating.onUpdate: Colors.white,
  Rating.good: const Color(0xff009966),
  Rating.moderate: const Color(0xffFFDE33),
  Rating.sensitive: const Color(0xffFF9933),
  Rating.unhealthy: const Color(0xffCC0033),
  Rating.very: const Color(0xff660099),
  Rating.hazardous: const Color(0xff7E0023),
};

Map<Rating, String> ratingName = {
  Rating.onUpdate: 'On Update',
  Rating.good: 'Good',
  Rating.moderate: 'Moderate',
  Rating.sensitive: 'Unhealthy for Sensitive Groups',
  Rating.unhealthy: 'Unhealthy',
  Rating.very: 'Very Unhealthy',
  Rating.hazardous: 'Hazardous',
};

Map<String, Rating> ratingEnum = {
  'On Update': Rating.onUpdate,
  'Good': Rating.good,
  'Moderate': Rating.moderate,
  'Unhealthy for Sensitive Groups': Rating.sensitive,
  'Unhealthy': Rating.unhealthy,
  'Very Unhealthy': Rating.very,
  'Hazardous': Rating.hazardous,
};

String getRatingName(int score) {
  if (isGood(score)) {
    return ratingName[Rating.good]!.tr();
  } else if (isModerate(score)) {
    return ratingName[Rating.moderate]!.tr();
  } else if (isSensitive(score)) {
    return ratingName[Rating.sensitive]!.tr();
  } else if (isUnhealthy(score)) {
    return ratingName[Rating.unhealthy]!.tr();
  } else if (isVery(score)) {
    return ratingName[Rating.very]!.tr();
  } else {
    return ratingName[Rating.hazardous]!.tr();
  }
}

Rating getRatingEnum(int score) {
  if (isGood(score)) {
    return Rating.good;
  } else if (isModerate(score)) {
    return Rating.moderate;
  } else if (isSensitive(score)) {
    return Rating.sensitive;
  } else if (isUnhealthy(score)) {
    return Rating.unhealthy;
  } else if (isVery(score)) {
    return Rating.very;
  } else {
    return Rating.hazardous;
  }
}

Color getRatingColor(int score) {
  if (isGood(score)) {
    return ratingColor[Rating.good]!;
  } else if (isModerate(score)) {
    return ratingColor[Rating.moderate]!;
  } else if (isSensitive(score)) {
    return ratingColor[Rating.sensitive]!;
  } else if (isUnhealthy(score)) {
    return ratingColor[Rating.unhealthy]!;
  } else if (isVery(score)) {
    return ratingColor[Rating.very]!;
  } else {
    return ratingColor[Rating.hazardous]!;
  }
}

bool isGood(int score) {
  return score.isBetween(0, 50);
}

bool isModerate(int score) {
  return score.isBetween(51, 100);
}

bool isSensitive(int score) {
  return score.isBetween(101, 150);
}

bool isUnhealthy(int score) {
  return score.isBetween(151, 200);
}

bool isVery(int score) {
  return score.isBetween(201, 300);
}
