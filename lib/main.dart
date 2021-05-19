import 'package:settpay/app.dart';
import 'package:settpay/common/consts.dart';
import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';

import 'package:sp_polkadot/sp_polkadot.dart';

void main() async {
  await GetStorage.init(get_storage_container);

  final _plugins = [
    PluginPolkadot(name: 'polkadot'),
    PluginPolkadot(),
  ];

  runApp(WalletApp(_plugins, BuildTargets.apk));
}
