import 'package:intl/intl.dart';

class SingleProductModel {
  SingleProductModel({
    this.id,
    this.brand,
    this.graph,
    this.type,
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
    this.series,
    this.coverVariant,
    this.coverArtist,
    this.publisher,
    this.issue,
    this.pages,
    this.startYear,
    this.writers,
    this.artists,
    this.characters,
    this.creationTime,
    this.updateTime,
    this.parent,
  });

  SingleProductModel.fromJson(dynamic json) {
    id = json['id'];
    brand = json['brand'];
    if (json['graph'] != null) {
      graph = [];
      json['graph'].forEach((v) {
        graph?.add(Graph.fromJson(v));
      });
    }
    type = json['type'];
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
    series = json['series'];
    coverVariant = json['cover_variant'];
    coverArtist = json['cover_artist'];
    publisher = json['publisher'];
    issue = json['issue'];
    pages = json['pages'];
    startYear = json['start_year'];
    writers = json['writers'];
    artists = json['artists'];
    characters = json['characters'];
    creationTime = json['creation_time'];
    updateTime = json['update_time'];
    parent = json['parent'];
  }

  int? id;
  dynamic brand;
  List<Graph>? graph;
  int? type;
  String? name;
  String? description;
  int? listing;
  String? floorPrice;
  String? owner;
  String? edition;
  dynamic dropDate;
  dynamic listPrice;
  dynamic editions;
  dynamic editionType;
  dynamic season;
  String? rarity;
  dynamic license;
  dynamic series;
  String? coverVariant;
  String? coverArtist;
  String? publisher;
  String? issue;
  String? pages;
  String? startYear;
  String? writers;
  String? artists;
  String? characters;
  String? creationTime;
  String? updateTime;
  dynamic parent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['brand'] = brand;
    if (graph != null) {
      map['graph'] = graph?.map((v) => v.toJson()).toList();
    }
    map['type'] = type;
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
    map['series'] = series;
    map['cover_variant'] = coverVariant;
    map['cover_artist'] = coverArtist;
    map['publisher'] = publisher;
    map['issue'] = issue;
    map['pages'] = pages;
    map['start_year'] = startYear;
    map['writers'] = writers;
    map['artists'] = artists;
    map['characters'] = characters;
    map['creation_time'] = creationTime;
    map['update_time'] = updateTime;
    map['parent'] = parent;
    return map;
  }
}

class Graph {
  Graph({
    this.time,
    this.price,
    this.formattedTime,
  });

  Graph.fromJson(dynamic json) {
    time = json['time'];
    price = json['price'];
    formattedTime = DateFormat('hh a').format(DateTime.parse(time!));
  }

  String? time;
  double? price;
  var formattedTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time'] = time;
    map['price'] = price;
    return map;
  }
}
