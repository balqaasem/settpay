import 'package:app/app.dart';
import 'package:app/common/consts.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sp_polkadot/sp_polkadot.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init(get_storage_container);

  final _plugins = [
    PluginPolkadot(name: 'polkadot'),
    PluginPolkadot(),
  ];

  runApp(WalletApp(_plugins, BuildTargets.playStore));
}
