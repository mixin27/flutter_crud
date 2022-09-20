/// Application constants will be defined here.
class AppConsts {
  AppConsts._();

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

  static const String keyCode = "code";
  static const String keyMessage = "message";
  static const String keyData = "data";

  static _Endpoints get apiEndpoints => _Endpoints._();
  static _Status get status => _Status._();
  static _ApiError get apiErrors => _ApiError._();
}

class _Endpoints {
  _Endpoints._();

  // Auth
  final String userCreate = '/user/createUser';
  final String userLogin = '/user/loginuser';

  // Category
  final String category = '/category';

  // Post
  final String post = '/post';
}

class _Status {
  _Status._();

  final int ok = 200;
  final int created = 201;
  final int notModified = 304;
  final int badRequest = 400;
  final int unAuthorized = 401;
  final int forbidden = 403;
  final int notFound = 404;
  final int tooManyRequests = 429;
  final int internelServerError = 500;
  final int serviceUnavailable = 503;
}

class _ApiError {
  _ApiError._();

  final String unknown = 'Unknown Error';
  final String noInternet = 'No internet connection';
  final String badRequest =
      'Bad Request: Your request information is not corrected.';
  final String forbidden = 'Forbidden';
  final String tooManyRequests = 'Too many requests';
  final String unAuthorized = 'Unauthorized';
  final String internalServerError = 'Internal server error';
}
