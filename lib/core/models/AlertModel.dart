class AlertModel {
  AlertModel({
      this.count, 
      this.next, 
      this.previous, 
      this.results,});

  AlertModel.fromJson(dynamic json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
  }
  int? count;
  dynamic next;
  dynamic previous;
  List<Results>? results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    map['next'] = next;
    map['previous'] = previous;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Results {
  Results({
      this.id, 
      this.type, 
      this.priceType, 
      this.value, 
      this.frequency, 
      this.creationTime, 
      this.updateTime, 
      this.product, 
      this.user,});

  Results.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    priceType = json['price_type'];
    value = json['value'];
    frequency = json['frequency'];
    creationTime = json['creation_time'];
    updateTime = json['update_time'];
    product = json['product'];
    user = json['user'];
  }
  int? id;
  int? type;
  int? priceType;
  double? value;
  int? frequency;
  String? creationTime;
  String? updateTime;
  int? product;
  int? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['price_type'] = priceType;
    map['value'] = value;
    map['frequency'] = frequency;
    map['creation_time'] = creationTime;
    map['update_time'] = updateTime;
    map['product'] = product;
    map['user'] = user;
    return map;
  }

}