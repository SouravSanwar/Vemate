class VaultProductDetailsModel {
  VaultProductDetailsModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  VaultProductDetailsModel.fromJson(dynamic json) {
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
    this.mintNumber,
    this.ap,
    this.ad,
    this.creationTime,
    this.user,
    this.product,
  });

  Results.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    mintNumber = json['mint_number'];
    ap = json['ap'];
    ad = json['ad'];
    creationTime = json['creation_time'];
    user = json['user'];
    product = json['product'];
  }

  int? id;
  int? type;
  int? mintNumber;
  String? ap;
  String? ad;
  String? creationTime;
  int? user;
  int? product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['mint_number'] = mintNumber;
    map['ap'] = ap;
    map['ad'] = ad;
    map['creation_time'] = creationTime;
    map['user'] = user;
    map['product'] = product;
    return map;
  }
}
