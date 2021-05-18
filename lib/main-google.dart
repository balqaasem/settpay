import 'package:app/app.dart';
import 'package:app/common/consts.dart';
import 'package:flutter/material.dart';
import 'package:sp_polkadot/sp_polkadot.dart';

import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init(get_storage_container);

  final _plugins = [
    PluginPolkadot(name: 'polkadot'),
    PluginPolkadot(),
  ];

  runApp(WalletApp(_plugins, BuildTargets.playStore));
}
