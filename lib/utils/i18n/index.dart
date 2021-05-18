import 'package:settpay/utils/i18n/en/account.dart';
import 'package:settpay/utils/i18n/en/assets.dart';
import 'package:settpay/utils/i18n/en/profile.dart';
import 'package:settpay/utils/i18n/zh/account.dart';
import 'package:settpay/utils/i18n/zh/assets.dart';
import 'package:settpay/utils/i18n/zh/profile.dart';

const Map<String, Map<String, Map<String, String>>> i18n_full_dic_app = {
  'en': {
    'account': enAccount,
    'assets': enAssets,
    'profile': enProfile,
    'public': enPublic,
  },
  'zh': {
    'account': zhAccount,
    'assets': zhAssets,
    'profile': zhProfile,
    'public': zhPublic,
  }
};
