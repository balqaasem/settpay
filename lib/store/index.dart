import 'package:settpay/store/account.dart';
import 'package:settpay/store/assets.dart';
import 'package:settpay/store/settings.dart';
import 'package:mobx/mobx.dart';
import 'package:get_storage/get_storage.dart';

class AppStore {
  AppStore(this.storage);

  final GetStorage storage;

  AccountStore account;
  SettingsStore settings;
  AssetsStore assets;

  @action
  Future<void> init() async {
    settings = SettingsStore(storage);
    await settings.init();
    account = AccountStore(storage);
    assets = AssetsStore(storage);
  }
}
