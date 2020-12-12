// import 'package:localstorage/localstorage.dart';
// import 'package:http/http.dart' as http;

// class AssetsCache {
//   static AssetsCache _singleton;
//   static String _cacheKey = 'networkAssets';
//   final LocalStorage _storage = LocalStorage(_cacheKey);
//   final Map<String, String> assets = Map();
//   static const cacheTime = 2 * 24 * 60 * 60 * 1000;
//   AssetsCache._();

//   factory AssetsCache() {
//     if (_singleton == null) {
//       _singleton = AssetsCache._();
//     }
//     return _singleton;
//   }

//   static String get cacheKey => _cacheKey;

//   Future<String> getAssets(String url) async {
//     if (assets.containsKey(url)) {
//       return assets[url];
//     }
//     await _storage.ready;
//     final res = _storage.getItem(url);
//     if (res != null &&
//         res['lastModified'] + cacheTime >
//             DateTime.now().millisecondsSinceEpoch) {
//       return res['data'];
//     }
//     final data = (await http.get(url)).body;
//     final Map<String, dynamic> obj = {
//       "lastModified": DateTime.now().millisecondsSinceEpoch,
//       "data": data
//     };
//     assets[url] = data;
//     _storage.ready.then((value) => _storage.setItem(url, obj));
//     return data;
//   }
// }
