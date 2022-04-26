class ProfileModel {
  ProfileModel({
      this.id, 
      this.profileImage, 
      this.verificationId, 
      this.lastLogin, 
      this.isSuperuser, 
      this.nickname, 
      this.email, 
      this.gender, 
      this.birthYear, 
      this.presentAddress, 
      this.permanentAddress, 
      this.city, 
      this.postCode, 
      this.country, 
      this.fcmDeviceId, 
      this.isEmailVerified, 
      this.joinDate, 
      this.isActive, 
      this.fa,
      this.isStaff,});

  ProfileModel.fromJson(dynamic json) {
    id = json['id'];
    profileImage = json['profile_image'] != null ? ProfileImage.fromJson(json['profile_image']) : null;
    verificationId = json['verification_id'] != null ? VerificationId.fromJson(json['verification_id']) : null;
    lastLogin = json['last_login'];
    isSuperuser = json['is_superuser'];
    nickname = json['nickname'];
    email = json['email'];
    gender = json['gender'];
    birthYear = json['birth_year'];
    presentAddress = json['present_address'];
    permanentAddress = json['permanent_address'];
    city = json['city'];
    postCode = json['post_code'];
    country = json['country'];
    fcmDeviceId = json['fcm_device_id'];
    isEmailVerified = json['is_email_verified'];
    joinDate = json['join_date'];
    isActive = json['is_active'];
    fa = json['is_2fa'];
    isStaff = json['is_staff'];
  }
  int? id;
  ProfileImage? profileImage;
  VerificationId? verificationId;
  String? lastLogin;
  bool? isSuperuser;
  String? nickname;
  String? email;
  int? gender;
  int? birthYear;
  dynamic presentAddress;
  dynamic permanentAddress;
  dynamic city;
  dynamic postCode;
  dynamic country;
  String? fcmDeviceId;
  bool? isEmailVerified;
  String? joinDate;
  bool? isActive;
  bool? fa;
  bool? isStaff;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (profileImage != null) {
      map['profile_image'] = profileImage?.toJson();
    }
    if (verificationId != null) {
      map['verification_id'] = verificationId?.toJson();
    }
    map['last_login'] = lastLogin;
    map['is_superuser'] = isSuperuser;
    map['nickname'] = nickname;
    map['email'] = email;
    map['gender'] = gender;
    map['birth_year'] = birthYear;
    map['present_address'] = presentAddress;
    map['permanent_address'] = permanentAddress;
    map['city'] = city;
    map['post_code'] = postCode;
    map['country'] = country;
    map['fcm_device_id'] = fcmDeviceId;
    map['is_email_verified'] = isEmailVerified;
    map['join_date'] = joinDate;
    map['is_active'] = isActive;
    map['is_2fa'] = fa;
    map['is_staff'] = isStaff;
    return map;
  }

}

class VerificationId {
  VerificationId({
      this.id, 
      this.frontImageDetail, 
      this.backImageDetail, 
      this.idNo, 
      this.name, 
      this.status, 
      this.rejectedReason, 
      this.creationTime, 
      this.updateTime, 
      this.user, 
      this.frontImage, 
      this.backImage,});

  VerificationId.fromJson(dynamic json) {
    id = json['id'];
    frontImageDetail = json['front_image_detail'];
    backImageDetail = json['back_image_detail'];
    idNo = json['id_no'];
    name = json['name'];
    status = json['status'];
    rejectedReason = json['rejected_reason'];
    creationTime = json['creation_time'];
    updateTime = json['update_time'];
    user = json['user'];
    frontImage = json['front_image'];
    backImage = json['back_image'];
  }
  int? id;
  dynamic frontImageDetail;
  dynamic backImageDetail;
  dynamic idNo;
  dynamic name;
  int? status;
  dynamic rejectedReason;
  String? creationTime;
  String? updateTime;
  int? user;
  dynamic frontImage;
  dynamic backImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['front_image_detail'] = frontImageDetail;
    map['back_image_detail'] = backImageDetail;
    map['id_no'] = idNo;
    map['name'] = name;
    map['status'] = status;
    map['rejected_reason'] = rejectedReason;
    map['creation_time'] = creationTime;
    map['update_time'] = updateTime;
    map['user'] = user;
    map['front_image'] = frontImage;
    map['back_image'] = backImage;
    return map;
  }

}

class ProfileImage {
  ProfileImage({
      this.original, 
      this.tab, 
      this.mobile,});

  ProfileImage.fromJson(dynamic json) {
    original = json['original'] != null ? Original.fromJson(json['original']) : null;
    tab = json['tab'] != null ? Tab.fromJson(json['tab']) : null;
    mobile = json['mobile'] != null ? Mobile.fromJson(json['mobile']) : null;
  }
  Original? original;
  Tab? tab;
  Mobile? mobile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (original != null) {
      map['original'] = original?.toJson();
    }
    if (tab != null) {
      map['tab'] = tab?.toJson();
    }
    if (mobile != null) {
      map['mobile'] = mobile?.toJson();
    }
    return map;
  }

}

class Mobile {
  Mobile({
      this.src, 
      this.width, 
      this.height, 
      this.alt,});

  Mobile.fromJson(dynamic json) {
    src = json['src'];
    width = json['width'];
    height = json['height'];
    alt = json['alt'];
  }
  String? src;
  int? width;
  int? height;
  String? alt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['src'] = src;
    map['width'] = width;
    map['height'] = height;
    map['alt'] = alt;
    return map;
  }

}

class Tab {
  Tab({
      this.src, 
      this.width, 
      this.height, 
      this.alt,});

  Tab.fromJson(dynamic json) {
    src = json['src'];
    width = json['width'];
    height = json['height'];
    alt = json['alt'];
  }
  String? src;
  int? width;
  int? height;
  String? alt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['src'] = src;
    map['width'] = width;
    map['height'] = height;
    map['alt'] = alt;
    return map;
  }

}

class Original {
  Original({
      this.src, 
      this.width, 
      this.height, 
      this.alt,});

  Original.fromJson(dynamic json) {
    src = json['src'];
    width = json['width'];
    height = json['height'];
    alt = json['alt'];
  }
  String? src;
  int? width;
  int? height;
  String? alt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['src'] = src;
    map['width'] = width;
    map['height'] = height;
    map['alt'] = alt;
    return map;
  }

}