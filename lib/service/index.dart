import 'package:settpay/common/consts.dart';
import 'package:settpay/service/apiAccount.dart';
import 'package:settpay/service/apiAssets.dart';
import 'package:settpay/store/index.dart';
import 'package:settpay_sdk/api/subscan.dart' show SubScanApi;
import 'package:settpay_sdk/plugin/index.dart';
import 'package:settpay_sdk/storage/keyring.dart';

class AppService {
  AppService(this.plugin, this.keyring, this.store, this.buildTarget);

  final SettPayPlugin plugin;
  final Keyring keyring;
  final AppStore store;
  final BuildTargets buildTarget;

  final subScan = SubScanApi();

  ApiAccount _account;
  ApiAssets _assets;

  ApiAccount get account => _account;
  ApiAssets get assets => _assets;

  void init() {
    _account = ApiAccount(this);
    _assets = ApiAssets(this);
  }
}
