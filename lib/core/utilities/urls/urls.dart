class Urls {
  //static String mainUrl = 'https://veve-api.herokuapp.com/vmate';
  static String mainUrl = 'http://167.71.134.124';

  static String signUp = mainUrl + '/api/v1/account/public/users/signup/';
  static String verifyCode =
      mainUrl + '/api/v1/account/public/users/verify_code/';
  static String resendCode =
      mainUrl + '/api/v1/account/public/users/send_verification_code/';
  static String logIn = mainUrl + '/api/v1/account/public/users/signin/';

  static String userInfo = mainUrl + '/api/v1/account/public/users/profile/';
  static String updateUserInfo =
      mainUrl + '/api/v1/account/public/users/profile/';
  static String updateProfilePic =
      mainUrl + '/api/v1/account/public/users/upload_profile_image/';

  static String collectibles = mainUrl + '/collectibles';
  static String singleCollectible = mainUrl + '/collectible/';

  static String comics = mainUrl + '/comics';
  static String singleComic = mainUrl + '/comic/';
}
