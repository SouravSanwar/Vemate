class AppUpdate {
  AppUpdate({
      this.id, 
      this.version,});

  AppUpdate.fromJson(dynamic json) {
    id = json['id'];
    version = json['version'];
  }
  int? id;
  String? version;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['version'] = version;
    return map;
  }

}