import 'package:flutter/material.dart';

abstract class SocialMediaGeneric {
  const SocialMediaGeneric(this.aspectRatio);

  final double aspectRatio;

  String get getHtml;
  String get pauseVideoScript;

  static String embedElementId = 'widget';

  static String scriptGenrator(scriptUrl) =>
      '<script type="text/javascript" src="$scriptUrl"></script>';
}
