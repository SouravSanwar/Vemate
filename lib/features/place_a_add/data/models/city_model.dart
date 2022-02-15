class CityModel {
  Cities? cities;

  CityModel({this.cities});

  CityModel.fromJson(Map<String, dynamic> json) {
    cities =
    json['cities'] != null ? Cities.fromJson(json['cities']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cities != null) {
      data['cities'] = cities!.toJson();
    }
    return data;
  }
}

class Cities {
  var totalCount;
  List<Edges>? edges;

  Cities({this.totalCount, this.edges});

  Cities.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['edges'] != null) {
      edges = [];
      json['edges'].forEach((v) {
        edges!.add(Edges.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalCount'] = totalCount;
    if (edges != null) {
      data['edges'] = edges!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Edges {
  Node? node;

  Edges({this.node});

  Edges.fromJson(Map<String, dynamic> json) {
    node = json['node'] != null ? Node.fromJson(json['node']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (node != null) {
      data['node'] = node!.toJson();
    }
    return data;
  }
}

class Node {
  var region;
  var city;
  var objectId;
  bool? usageStatus;
  var id;

  Node({this.region, this.city, this.objectId, this.usageStatus, this.id});

  Node.fromJson(Map<String, dynamic> json) {
    region = json['region'];
    city = json['city'];
    objectId = json['objectId'];
    usageStatus = json['usageStatus'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['region'] = region;
    data['city'] = city;
    data['objectId'] = objectId;
    data['usageStatus'] = usageStatus;
    data['id'] = id;
    return data;
  }
}