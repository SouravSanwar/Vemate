class PropertyRentModel {
  PropertyRentAdvertises? propertyRentAdvertises;

  PropertyRentModel({this.propertyRentAdvertises});

  PropertyRentModel.fromJson(Map<String, dynamic> json) {
    propertyRentAdvertises = json['propertyRentAdvertises'] != null
        ? PropertyRentAdvertises.fromJson(json['propertyRentAdvertises'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (propertyRentAdvertises != null) {
      data['propertyRentAdvertises'] = propertyRentAdvertises!.toJson();
    }
    return data;
  }
}

class PropertyRentAdvertises {
  var totalCount;
  List<Edges>? edges;

  PropertyRentAdvertises({this.totalCount, this.edges});

  PropertyRentAdvertises.fromJson(Map<String, dynamic> json) {
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
  City? city;
  var description;
  var objectId;
  var id;
  bool? availability;
  var price;
  var currency;
  var location;
  var status;
  Category? category;

  Node(
      {this.city,
      this.description,
      this.objectId,
      this.id,
      this.availability,
      this.price,
      this.currency,
      this.location,
      this.status,
      this.category});

  Node.fromJson(Map<String, dynamic> json) {
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    description = json['description'];
    objectId = json['objectId'];
    id = json['id'];
    availability = json['availability'];
    price = json['price'];
    currency = json['currency'];
    location = json['location'];
    status = json['status'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (city != null) {
      data['city'] = city!.toJson();
    }
    data['description'] = description;
    data['objectId'] = objectId;
    data['id'] = id;
    data['availability'] = availability;
    data['price'] = price;
    data['currency'] = currency;
    data['location'] = location;
    data['status'] = status;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }
}

class City {
  var objectId;
  var region;
  var city;

  City({this.objectId, this.region, this.city});

  City.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    region = json['region'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['region'] = region;
    data['city'] = city;
    return data;
  }
}

class Category {
  var childCount;
  var keyword;
  var objectId;
  var id;
  var name;
  Parent? parent;

  Category(
      {this.childCount,
      this.keyword,
      this.objectId,
      this.id,
      this.name,
      this.parent});

  Category.fromJson(Map<String, dynamic> json) {
    childCount = json['childCount'];
    keyword = json['keyword'];
    objectId = json['objectId'];
    id = json['id'];
    name = json['name'];
    parent = json['parent'] != null ? Parent.fromJson(json['parent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['childCount'] = childCount;
    data['keyword'] = keyword;
    data['objectId'] = objectId;
    data['id'] = id;
    data['name'] = name;
    if (parent != null) {
      data['parent'] = parent!.toJson();
    }
    return data;
  }
}

class Parent {
  var keyword;
  var childCount;
  var objectId;
  var id;
  var name;

  Parent({this.keyword, this.childCount, this.objectId, this.id, this.name});

  Parent.fromJson(Map<String, dynamic> json) {
    keyword = json['keyword'];
    childCount = json['childCount'];
    objectId = json['objectId'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['keyword'] = keyword;
    data['childCount'] = childCount;
    data['objectId'] = objectId;
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
