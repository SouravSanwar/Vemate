class AppUpdator {
  AppUpdator({
      this.id, 
      this.name, 
      this.version, 
      this.description, 
      this.isMajor,});

  AppUpdator.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    version = json['version'];
    description = json['description'];
    isMajor = json['is_major'];
  }
  int? id;
  String? name;
  String? version;
  String? description;
  bool? isMajor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['version'] = version;
    map['description'] = description;
    map['is_major'] = isMajor;
    return map;
  }

}