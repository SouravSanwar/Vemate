class Urls {
  static String mainUrl = 'https://market.vemate.com';

  //static String mainUrl = 'http://167.71.134.124';

  static String signUp = mainUrl + '/api/v1/account/public/users/signup/';
  static String verifyCode =
      mainUrl + '/api/v1/account/public/users/verify_code/';
  static String resendCode =
      mainUrl + '/api/v1/account/public/users/send_verification_code/';
  static String forgotPass =
      mainUrl + '/api/v1/account/public/users/forget_password/';
  static String logIn = mainUrl + '/api/v1/account/public/users/signin/';
  static String logInWith2FA =
      mainUrl + '/api/v1/account/public/users/two_factor_auth_login/';

  static String userInfo = mainUrl + '/api/v1/account/public/users/profile/';
  static String updateUserInfo =
      mainUrl + '/api/v1/account/public/users/profile/';
  static String updateProfilePic =
      mainUrl + '/api/v1/account/public/users/upload_profile_image/';
  static String check2FA =
      mainUrl + '/api/v1/account/public/users/enable_disable_2fa/';

  static String comic =
      mainUrl + '/api/v1/veve/public/products/?type=1&limit=20&offset=';

  static String brand =
      mainUrl + '/api/v1/veve/public/brands/?limit=20&offset=';

  static String singleProduct = mainUrl + '/api/v1/veve/public/products/';

  static String commonStorage = mainUrl + '/api/v1/veve/public/common-storage/';

  static String checkWishlist = mainUrl +
      '/api/v1/veve/public/common-storage/check_duplicate/?type=1&product_id=';

  static String checkSet = mainUrl +
      '/api/v1/veve/public/common-storage/check_duplicate/?type=0&product_id=';

  static String vaultStats =
      mainUrl + '/api/v1/veve/public/common-storage/vault_stats';

  static String news = mainUrl + '/api/v1/home/public/news/';

  static String appUpdate = mainUrl + '/api/v1/veve/public/app-updater/';

  static String creteAlert = mainUrl + '/api/v1/veve/public/alerts/';

  //static String alertList = mainUrl + '/api/v1/veve/public/alerts?&limit=20&offset=';
  static String alertList = mainUrl + '/api/v1/veve/public/alerts/';
  static String notificationList = mainUrl + '/api/v1/veve/public/notifications/';
}
