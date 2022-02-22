import 'package:get/get.dart';

class CollectiblesModel {
  CollectiblesModel({
    this.collectibles,
  });

  CollectiblesModel.fromJson(dynamic json) {
    collectibles = json['collectibles'] != null
        ? Collectibles.fromJson(json['collectibles'])
        : null;
  }

  Collectibles? collectibles;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (collectibles != null) {
      map['collectibles'] = collectibles?.toJson();
    }
    return map;
  }
}

class Collectibles {
  Collectibles({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  Collectibles.fromJson(dynamic json) {
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
  String? next;
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
    this.name,
    this.description,
    this.listing,
    this.floorPrice,
    this.owner,
    this.edition,
    this.dropDate,
    this.listPrice,
    this.editions,
    this.editionType,
    this.season,
    this.rarity,
    this.license,
    this.brand,
    this.series,
    this.rarePoint,
    this.cpp,
  });

  Results.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    listing = json['listing'];
    floorPrice = json['floor_price'];
    owner = json['owner'];
    edition = json['edition'];
    dropDate = json['drop_date'];
    listPrice = json['list_price'];
    editions = json['editions'];
    editionType = json['edition_type'];
    season = json['season'];
    rarity = json['rarity'];
    license = json['license'];
    brand = json['brand'];
    series = json['series'];

    if (rarity == 'Rare') {
      rarePoint = 2;
      cpp = (double.parse(floorPrice!) / rarePoint!).toPrecision(2);
    } else if (rarity == 'Ultra Rare') {
      rarePoint = 3;
      cpp = (double.parse(floorPrice!) / rarePoint!).toPrecision(2);
    } else {
      rarePoint = 1;
      cpp = (double.parse(floorPrice!) / rarePoint!).toPrecision(2);
    }
  }

  int? id;
  String? name;
  String? description;
  int? listing;
  String? floorPrice;
  String? owner;
  String? edition;
  String? dropDate;
  String? listPrice;
  String? editions;
  String? editionType;
  String? season;
  String? rarity;
  String? license;
  String? brand;
  String? series;
  int? rarePoint;
  double? cpp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['listing'] = listing;
    map['floor_price'] = floorPrice;
    map['owner'] = owner;
    map['edition'] = edition;
    map['drop_date'] = dropDate;
    map['list_price'] = listPrice;
    map['editions'] = editions;
    map['edition_type'] = editionType;
    map['season'] = season;
    map['rarity'] = rarity;
    map['license'] = license;
    map['brand'] = brand;
    map['series'] = series;
    return map;
  }
}
