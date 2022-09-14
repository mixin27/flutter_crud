/// Application constants will be defined here.
class AppConsts {
  AppConsts._();

  static const String abbrOrganization = 'SBS';
  static const String organization = 'Systematic Business Solution Co.,Ltd.';
  static const String author = 'Kyaw Zayar Tun';

  static const double containerRadius = 8;
  static const double buttonRadius = 8;

  // Fonts
  static const String mainFont = 'Roboto';
  static const String mainFontMM = pyidaungsuFont;

  static const String pyidaungsuFont = 'Pyidaungsu';

  // SharedPreference Keys
  static const String prefsDarkMode = 'is_dark_mode';

  // APIs response keys
  static const String responseInfo = 'ResponseInfo';
  static const String responseData = 'ResponseData';

  static _Endpoints get apiEndpoints => _Endpoints._();
  static _ApiError get apiErrors => _ApiError._();
}

class _Endpoints {
  _Endpoints._();

  // final String login = '/DoLogin';
}

class _ApiError {
  _ApiError._();

  final String unknown = 'Unknown Error';
  final String noInternet = 'No internet connection';
}
