class Urls {
  //static String mainUrl = 'https://veve-api.herokuapp.com/vmate';
  static String mainUrl = 'http://167.71.134.124';

  static String signUp = mainUrl + '/api/v1/account/public/users/signup/';
  static String verifyCode =
      mainUrl + '/api/v1/account/public/users/verify_code/';
  static String resendCode =
      mainUrl + '/api/v1/account/public/users/send_verification_code/';
  static String forgotPass =
      mainUrl + '/api/v1/account/public/users/forget_password/';
  static String logIn = mainUrl + '/api/v1/account/public/users/signin/';

  static String userInfo = mainUrl + '/api/v1/account/public/users/profile/';
  static String updateUserInfo =
      mainUrl + '/api/v1/account/public/users/profile/';
  static String updateProfilePic =
      mainUrl + '/api/v1/account/public/users/upload_profile_image/';

  static String comic = mainUrl + '/api/v1/veve/public/products/?type=1&limit=20&offset=';

  static String singleProduct = mainUrl + '/api/v1/veve/public/products/';

  static String commonStorage = mainUrl + '/api/v1/veve/public/common-storage/';

  static String checkWishlist = mainUrl +
      '/api/v1/veve/public/common-storage/check_duplicate/?type=1&product_id=';

  static String checkSet = mainUrl +
      '/api/v1/veve/public/common-storage/check_duplicate/?type=0&product_id=';

  static String vaultStats = mainUrl +
      '/api/v1/veve/public/common-storage/vaul'
          't_stats/';

  static String news = mainUrl + '/api/v1/home/public/news/';

  static String singleComic = mainUrl + '/comic/';
}
