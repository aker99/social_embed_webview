import 'dart:convert';

import 'package:flutter/material.dart';

String htmlToURI(String code) {
  return Uri.dataFromString(code,
          mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
      .toString();
}

String colorToHtmlRGBA(Color c) {
  return 'rgba(${c.red},${c.green},${c.blue},${c.alpha / 255})';
}
