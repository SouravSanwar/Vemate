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
    this.graphType,
  });

  SingleProductModel.fromJson(dynamic json) {
    id = json['id'];
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
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
    editionType = json['edition_type'] ?? '';
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
    graphType = json['graph_type'];

    if (json['graph'] != null) {
      graph = [];
      json['graph'].forEach((v) {
        graph?.add(Graph.fromJson(v));
      });
    }
  }

  int? id;
  Brand? brand;
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
  String? graphType;
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
    map['graph_type'] = graphType;
    map['parent'] = parent;
    return map;
  }
}

class Graph {
  Graph({
    this.floorPrice,
    this.creationTime,
    this.date,
    this.hourWiseTime,
    this.dayWiseTime,});

  Graph.fromJson(dynamic json) {
    floorPrice = json['floor_price'];
    creationTime = json['creation_time'];
    date = json['date'];
    if (date != null) {
      hourWiseTime = DateFormat('hh a').format(DateTime.parse(date!));
      dayWiseTime = DateFormat('EE').format(DateTime.parse(date!));
    }
  }
  double? floorPrice;
  String? creationTime;
  String? date;
  String? hourWiseTime;
  String? dayWiseTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['floor_price'] = floorPrice;
    map['creation_time'] = creationTime;
    map['date'] = date;
    return map;
  }

}


class Brand {
  Brand({
    this.id,
    this.name,
  });

  Brand.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}
