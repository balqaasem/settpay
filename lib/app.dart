import 'package:settpay/common/components/willPopScopWrapper.dart';
import 'package:settpay/common/consts.dart';
import 'package:settpay/screens/account/create/backupAccountPage.dart';
import 'package:settpay/screens/account/create/createAccountPage.dart';
import 'package:settpay/screens/account/createAccountEntryPage.dart';
import 'package:settpay/screens/account/import/importAccountPage.dart';
import 'package:settpay/screens/assets/asset/assetPage.dart';
import 'package:settpay/screens/assets/transfer/detailPage.dart';
import 'package:settpay/screens/assets/transfer/transferPage.dart';
import 'package:settpay/screens/homePage.dart';
import 'package:settpay/screens/networkSelectPage.dart';
import 'package:settpay/screens/profile/aboutPage.dart';
import 'package:settpay/screens/profile/account/accountManagePage.dart';
import 'package:settpay/screens/profile/account/changeNamePage.dart';
import 'package:settpay/screens/profile/account/changePasswordPage.dart';
import 'package:settpay/screens/profile/account/exportAccountPage.dart';
import 'package:settpay/screens/profile/account/exportResultPage.dart';
import 'package:settpay/screens/profile/contacts/contactPage.dart';
import 'package:settpay/screens/profile/contacts/contactsPage.dart';
import 'package:settpay/screens/profile/recovery/createRecoveryPage.dart';
import 'package:settpay/screens/profile/recovery/friendListPage.dart';
import 'package:settpay/screens/profile/recovery/initiateRecoveryPage.dart';
import 'package:settpay/screens/profile/recovery/recoveryProofPage.dart';
import 'package:settpay/screens/profile/recovery/recoverySettingPage.dart';
import 'package:settpay/screens/profile/recovery/recoveryStatePage.dart';
import 'package:settpay/screens/profile/recovery/vouchRecoveryPage.dart';
import 'package:settpay/screens/profile/settings/remoteNodeListPage.dart';
import 'package:settpay/screens/profile/settings/settingsPage.dart';
import 'package:settpay/screens/profile/account/signPage.dart';
import 'package:settpay/screens/walletConnect/walletConnectSignPage.dart';
import 'package:settpay/screens/walletConnect/wcPairingConfirmPage.dart';
import 'package:settpay/screens/walletConnect/wcSessionsPage.dart';
import 'package:settpay/service/index.dart';
import 'package:settpay/service/walletApi.dart';
import 'package:settpay/store/index.dart';
import 'package:settpay/utils/UI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_storage/get_storage.dart';

import 'package:settpay_sdk/settpay_api/types/networkParams.dart';
import 'package:settpay_sdk/settpay_api/types/walletConnect/pairingData.dart';
import 'package:settpay_sdk/settpay_api/types/walletConnect/payloadData.dart';
import 'package:settpay_sdk/plugin/index.dart';
import 'package:settpay_sdk/storage/keyring.dart';
import 'package:settpay_sdk/utils/i18n.dart';
import 'package:settpay_ui/screens/accountListPage.dart';
import 'package:settpay_ui/screens/accountQrCodePage.dart';
import 'package:settpay_ui/screens/qrSenderPage.dart';
import 'package:settpay_ui/screens/qrSignerPage.dart';
import 'package:settpay_ui/screens/scanPage.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:settpay_ui/screens/txConfirmPage.dart';

const get_storage_container = 'configuration';

class WalletApp extends StatefulWidget {
  WalletApp(this.plugins, this.buildTarget);
  final List<SettPayPlugin> plugins;
  final BuildTargets buildTarget;
  @override
  _WalletAppState createState() => _WalletAppState();
}

class _WalletAppState extends State<WalletApp> {
  Keyring _keyring;

  AppStore _store;
  AppService _service;

  ThemeData _theme;

  Locale _locale;

  NetworkParams _connectedNode;

  ThemeData _getAppTheme(MaterialColor color, {Color secondaryColor}) {
    return ThemeData(
      primarySwatch: color,
      accentColor: secondaryColor,
      textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 24,
          ),
          headline2: TextStyle(
            fontSize: 22,
          ),
          headline3: TextStyle(
            fontSize: 20,
          ),
          headline4: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          button: TextStyle(
            color: Colors.white,
            fontSize: 18,
          )),
    );
  }

  void _changeLang(String code) {
    _service.store.settings.setLocalCode(code);

    Locale res;
    switch (code) {
      case 'zh':
        res = const Locale('zh', '');
        break;
      case 'en':
        res = const Locale('en', '');
        break;
      default:
        res = null;
    }
    setState(() {
      _locale = res;
    });
  }

  void _initWalletConnect() {
    _service.plugin.sdk.api.walletConnect.initClient((WCPairingData proposal) {
      print('get wc pairing');
      _handleWCPairing(proposal);
    }, (WCPairedData session) {
      print('get wc session');
      _service.store.account.createWCSession(session);
      _service.store.account.setWCPairing(false);
    }, (WCPayloadData payload) {
      print('get wc payload');
      _handleWCPayload(payload);
    });
  }

  // Todo: Add `Setheum` Adress and replace with `polkadot:polkadot`
  Future<void> _handleWCPairing(WCPairingData pairingReq) async {
    final approved = await Navigator.of(context)
        .pushNamed(WCPairingConfirmPage.route, arguments: pairingReq);
    final address = _service.keyring.current.address;
    if (approved ?? false) {
      _service.store.account.setWCPairing(true);
      await _service.plugin.sdk.api.walletConnect
          .approvePairing(pairingReq, '$address@polkadot:polkadot');
      print('wallet connect alive');
    } else {
      _service.plugin.sdk.api.walletConnect.rejectPairing(pairingReq);
    }
  }

  Future<void> _handleWCPayload(WCPayloadData payload) async {
    final res = await Navigator.of(context)
        .pushNamed(WalletConnectSignPage.route, arguments: payload);
    if (res == null) {
      print('user rejected signing');
      await _service.plugin.sdk.api.walletConnect
          .payloadRespond(payload, error: {
        'code': -32000,
        'message': "User rejected JSON-RPC request",
      });
    } else {
      print('user signed payload:');
      print(res);
      // await _service.plugin.sdk.api.walletConnect
      //     .payloadRespond(payload, response: );
    }
  }

  Future<void> _startPlugin() async {
    // _initWalletConnect();

    _service.assets.fetchMarketPrice();

    setState(() {
      _connectedNode = null;
    });
    final connected = await _service.plugin.start(_keyring);
    setState(() {
      _connectedNode = connected;
    });
  }

  Future<void> _changeNetwork(SettPayPlugin network) async {
    _keyring.setSS58(network.basic.ss58);

    setState(() {
      _theme = _getAppTheme(
        network.basic.primaryColor,
        secondaryColor: network.basic.gradientColor,
      );
    });
    _store.settings.setNetwork(network.basic.name);

    final useLocalJS = WalletApi.getPolkadotJSVersion(
          _store.storage,
          network.basic.name,
          network.basic.jsCodeVersion,
        ) >
        network.basic.jsCodeVersion;

    // we reuse the existing webView instance when we start a new plugin.
    await network.beforeStart(
      _keyring,
      webView: _service.plugin.sdk.webView,
      jsCode: useLocalJS
          ? WalletApi.getPolkadotJSCode(_store.storage, network.basic.name)
          : null,
    );

    final service = AppService(network, _keyring, _store, widget.buildTarget);
    service.init();
    setState(() {
      _service = service;
    });

    _startPlugin();
  }

  // If we are not a parachain, as in a solo chain then change this to `_changeToNeom()` and call `Neom`
  Future<void> _changeToKusamaForNeom() async {
    final name = 'kusama';
    await _changeNetwork(
        widget.plugins.firstWhere((e) => e.basic.name == name));
    _service.store.assets.loadCache(_keyring.current, name);
  }

  Future<void> _changeNode(NetworkParams node) async {
    if (_connectedNode != null) {
      setState(() {
        _connectedNode = null;
      });
    }
    _service.plugin.sdk.api.account.unsubscribeBalance();
    final connected = await _service.plugin.start(_keyring, nodes: [node]);
    setState(() {
      _connectedNode = connected;
    });
  }

  Future<void> _checkUpdate(BuildContext context) async {
    final versions = await WalletApi.getLatestVersion();
    AppUI.checkUpdate(context, versions, widget.buildTarget, autoCheck: true);
  }

  Future<void> _checkJSCodeUpdate(BuildContext context, SettPayPlugin plugin,
      {bool needReload = true}) async {
    // check js code update
    final jsVersions = await WalletApi.fetchPolkadotJSVersion();
    if (jsVersions == null) return;

    final network = plugin.basic.name;
    final version = jsVersions[network];
    final versionMin = jsVersions['$network-min'];
    final currentVersion = WalletApi.getPolkadotJSVersion(
      _store.storage,
      network,
      plugin.basic.jsCodeVersion,
    );
    print('js update: $network $currentVersion $version $versionMin');
    final bool needUpdate = await AppUI.checkJSCodeUpdate(
        context, _store.storage, currentVersion, version, versionMin, network);
    if (needUpdate) {
      final res =
          await AppUI.updateJSCode(context, _store.storage, network, version);
      if (needReload && res) {
        _changeNetwork(plugin);
      }
    }
  }

  Future<int> _startApp(BuildContext context) async {
    if (_keyring == null) {
      _keyring = Keyring();
      await _keyring.init();

      final storage = GetStorage(get_storage_container);
      final store = AppStore(storage);
      await store.init();

      _showGuide(context, storage);

      final pluginIndex = widget.plugins
          .indexWhere((e) => e.basic.name == store.settings.network);
      final service = AppService(
          widget.plugins[pluginIndex > -1 ? pluginIndex : 0],
          _keyring,
          store,
          widget.buildTarget);
      service.init();
      setState(() {
        _store = store;
        _service = service;
        _theme = _getAppTheme(
          service.plugin.basic.primaryColor,
          secondaryColor: service.plugin.basic.gradientColor,
        );
      });

      if (store.settings.localeCode.isNotEmpty) {
        _changeLang(store.settings.localeCode);
      } else {
        _changeLang(Localizations.localeOf(context).toString());
      }

      _checkUpdate(context);
      await _checkJSCodeUpdate(context, service.plugin, needReload: false);

      final useLocalJS = WalletApi.getPolkadotJSVersion(
            _store.storage,
            service.plugin.basic.name,
            service.plugin.basic.jsCodeVersion,
          ) >
          service.plugin.basic.jsCodeVersion;

      await service.plugin.beforeStart(
        _keyring,
        jsCode: useLocalJS
            ? WalletApi.getPolkadotJSCode(
                _store.storage, service.plugin.basic.name)
            : null,
      );

      _startPlugin();
    }

    return _keyring.allAccounts.length;
  }

  Map<String, Widget Function(BuildContext)> _getRoutes() {
    final pluginPages = _service != null && _service.plugin != null
        ? _service.plugin.getRoutes(_keyring)
        : {};
    return {
      /// pages of plugin
      ...pluginPages,

      /// basic pages
      HomePage.route: (_) => WillPopScopWrapper(
            Observer(
              builder: (BuildContext context) {
                final balance = _service?.plugin?.balances?.native;
                final networkName = _service?.plugin?.networkState?.name;
                return FutureBuilder<int>(
                  future: _startApp(context),
                  builder: (_, AsyncSnapshot<int> snapshot) {
                    if (snapshot.hasData && _service != null) {
                      return snapshot.data > 0
                          ? HomePage(
                              _service,
                              _connectedNode,
                              // If we are not a parachain, as in a solo chain then change this to `_changeToNeom()` and call `Neom`
                              _checkJSCodeUpdate,
                              _changeToKusamaForNeom)
                          : CreateAccountEntryPage();
                    } else {
                      return Container(color: Theme.of(context).canvasColor);
                    }
                  },
                );
              },
            ),
          ),
      TxConfirmPage.route: (_) => TxConfirmPage(
          _service.plugin, _keyring, _service.account.getPassword),
      QrSenderPage.route: (_) => QrSenderPage(_service.plugin, _keyring),
      QrSignerPage.route: (_) => QrSignerPage(_service.plugin, _keyring),
      ScanPage.route: (_) => ScanPage(_service.plugin, _keyring),
      AccountListPage.route: (_) => AccountListPage(_service.plugin, _keyring),
      AccountQrCodePage.route: (_) =>
          AccountQrCodePage(_service.plugin, _keyring),
      NetworkSelectPage.route: (_) =>
          NetworkSelectPage(_service, widget.plugins, _changeNetwork),
      WCPairingConfirmPage.route: (_) => WCPairingConfirmPage(_service),
      WCSessionsPage.route: (_) => WCSessionsPage(_service),
      WalletConnectSignPage.route: (_) =>
          WalletConnectSignPage(_service, _service.account.getPassword),

      /// account
      CreateAccountEntryPage.route: (_) => CreateAccountEntryPage(),
      CreateAccountPage.route: (_) => CreateAccountPage(_service),
      BackupAccountPage.route: (_) => BackupAccountPage(_service),
      ImportAccountPage.route: (_) => ImportAccountPage(_service),

      /// assets
      AssetPage.route: (_) => AssetPage(_service),
      TransferDetailPage.route: (_) => TransferDetailPage(_service),
      TransferPage.route: (_) => TransferPage(_service),

      /// profile
      SignMessagePage.route: (_) => SignMessagePage(_service),
      ContactsPage.route: (_) => ContactsPage(_service),
      ContactPage.route: (_) => ContactPage(_service),
      AboutPage.route: (_) => AboutPage(_service),
      AccountManagePage.route: (_) => AccountManagePage(_service),
      ChangeNamePage.route: (_) => ChangeNamePage(_service),
      ChangePasswordPage.route: (_) => ChangePasswordPage(_service),
      ExportAccountPage.route: (_) => ExportAccountPage(_service),
      ExportResultPage.route: (_) => ExportResultPage(),
      SettingsPage.route: (_) =>
          SettingsPage(_service, _changeLang, _changeNode),
      RemoteNodeListPage.route: (_) =>
          RemoteNodeListPage(_service, _changeNode),
      CreateRecoveryPage.route: (_) => CreateRecoveryPage(_service),
      FriendListPage.route: (_) => FriendListPage(_service),
      RecoverySettingPage.route: (_) => RecoverySettingPage(_service),
      RecoveryStatePage.route: (_) => RecoveryStatePage(_service),
      RecoveryProofPage.route: (_) => RecoveryProofPage(_service),
      InitiateRecoveryPage.route: (_) => InitiateRecoveryPage(_service),
      VouchRecoveryPage.route: (_) => VouchRecoveryPage(_service),
    };
  }

  @override
  Widget build(_) {
    return MaterialApp(
      title: 'SettPay',
      theme: _theme ??
          _getAppTheme(
            widget.plugins[0].basic.primaryColor,
            secondaryColor: widget.plugins[0].basic.gradientColor,
          ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizationsDelegate(_locale ?? Locale('en', '')),
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('zh', ''),
      ],
      initialRoute: HomePage.route,
      routes: _getRoutes(),
    );
  }
}
