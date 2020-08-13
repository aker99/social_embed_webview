import 'dart:convert';

String htmlToURI(String code) {
  return Uri.dataFromString(code,
          mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
      .toString();
}
