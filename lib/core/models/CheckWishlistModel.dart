class CheckWishlistModel {
  CheckWishlistModel({
    this.isFound,
  });

  CheckWishlistModel.fromJson(dynamic json) {
    isFound = json['is_found'];
  }

  bool? isFound;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_found'] = isFound;
    return map;
  }
}
