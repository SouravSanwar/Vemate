class CategoryModel {
  Categories? categories;

  CategoryModel({this.categories});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categories = json['categories'] != null
        ? Categories.fromJson(json['categories'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categories != null) {
      data['categories'] = categories!.toJson();
    }
    return data;
  }
}

class Categories {
  var totalCount;
  List<Edges>? edges;

  Categories({this.totalCount, this.edges});

  Categories.fromJson(Map<String, dynamic> json) {
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
  var name;
  var keyword;
  var objectId;
  var childCount;

  Node({this.name, this.keyword, this.objectId, this.childCount});

  Node.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    keyword = json['keyword'];
    objectId = json['objectId'];
    childCount = json['childCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['keyword'] = keyword;
    data['objectId'] = objectId;
    data['childCount'] = childCount;
    return data;
  }
}