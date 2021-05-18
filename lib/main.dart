import 'package:settpay/app.dart';
import 'package:settpay/common/consts.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:get_storage/get_storage.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sp_polkadot/sp_polkadot.dart';

void main() async {
  await GetStorage.init(get_storage_container);

  final _plugins = [
    PluginPolkadot(name: 'polkadot'),
    PluginPolkadot(),
  ];

  runApp(WalletApp(_plugins, BuildTargets.apk));
}
