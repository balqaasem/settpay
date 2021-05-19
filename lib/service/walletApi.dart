import 'dart:convert';

import 'package:get_storage/get_storage.dart' show GetStorage;

import 'package:http/http.dart' show Response, get;

class WalletApi {
  // ignore: todo
  // TODO: Replace endpoint with specialised settpay endpoint
  static const String _endpoint = 'https://polkadot.js.org/apps';

  static const String _jsCodeStorageKey = 'js_service_';
  static const String _jsCodeStorageVersionKey = 'js_service_version_';

  static Future<Map> getLatestVersion() async {
    try {
      Response res = await get('$_endpoint/versions.json');
      // ignore: unnecessary_null_comparison
      if (res == null) {
        return null;
      } else {
        return jsonDecode(utf8.decode(res.bodyBytes)) as Map;
      }
    } catch (err) {
      print(err);
      return null;
    }
  }

  static Future<Map> fetchPolkadotJSVersion() async {
    try {
      Response res = await get('$_endpoint/jsCodeVersions.json');
      // ignore: unnecessary_null_comparison
      if (res == null) {
        return null;
      } else {
        return Map.of(jsonDecode(res.body));
      }
    } catch (err) {
      print(err);
      return null;
    }
  }

  static Future<String> fetchPolkadotJSCode(String networkName) async {
    try {
      Response res = await get('$_endpoint/js_service/$networkName.js');
      // ignore: unnecessary_null_comparison
      if (res == null || res.statusCode != 200) {
        return null;
      } else {
        return utf8.decode(res.bodyBytes);
      }
    } catch (err) {
      print(err);
      return null;
    }
  }

  static int getPolkadotJSVersion(
    GetStorage jsStorage,
    String networkName,
    int appJSVersion,
  ) {
    final String version =
        jsStorage.read('$_jsCodeStorageVersionKey$networkName');
    if (version != null) {
      final updatedVersion = int.parse(version);
      return updatedVersion > appJSVersion ? updatedVersion : appJSVersion;
    }
    // default version
    return appJSVersion;
  }

  static String getPolkadotJSCode(
    GetStorage jsStorage,
    String networkName,
  ) {
    final String jsCode = jsStorage.read('$_jsCodeStorageKey$networkName');
    return jsCode;
  }

  static void setPolkadotJSCode(
    GetStorage jsStorage,
    String networkName,
    String code,
    int version,
  ) {
    jsStorage.write('$_jsCodeStorageKey$networkName', code);
    jsStorage.write(
        '$_jsCodeStorageVersionKey$networkName', version.toString());
  }

  static Future<List> getAnnouncements() async {
    try {
      Response res = await get('$_endpoint/announce.json');
      if (res == null) {
        return null;
      } else {
        return jsonDecode(utf8.decode(res.bodyBytes));
      }
    } catch (err) {
      print(err);
      return null;
    }
  }

  static Future<Map> getTokenPrice(String network) async {
    final url = 'https://${network.toLowerCase()}.subscan.io/api/scan/token';
    try {
      Response res = await get(url);
      if (res == null) {
        return null;
      } else {
        return jsonDecode(utf8.decode(res.bodyBytes));
      }
    } catch (err) {
      print(err);
      return null;
    }
  }
}
