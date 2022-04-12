class Test {
  Test({
      this.id, 
      this.brand, 
      this.graph, 
      this.graphType, 
      this.priceChangePercent, 
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
      this.parent,});

  Test.fromJson(dynamic json) {
    id = json['id'];
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    if (json['graph'] != null) {
      graph = [];
      json['graph'].forEach((v) {
        graph?.add(Graph.fromJson(v));
      });
    }
    graphType = json['graph_type'];
    priceChangePercent = json['price_change_percent'] != null ? PriceChangePercent.fromJson(json['price_change_percent']) : null;
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
  Brand? brand;
  List<Graph>? graph;
  String? graphType;
  PriceChangePercent? priceChangePercent;
  int? type;
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
  String? series;
  dynamic coverVariant;
  dynamic coverArtist;
  dynamic publisher;
  dynamic issue;
  dynamic pages;
  dynamic startYear;
  dynamic writers;
  dynamic artists;
  dynamic characters;
  String? creationTime;
  String? updateTime;
  dynamic parent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (brand != null) {
      map['brand'] = brand?.toJson();
    }
    if (graph != null) {
      map['graph'] = graph?.map((v) => v.toJson()).toList();
    }
    map['graph_type'] = graphType;
    if (priceChangePercent != null) {
      map['price_change_percent'] = priceChangePercent?.toJson();
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

class PriceChangePercent {
  PriceChangePercent({
      this.changePercent, 
      this.sign,});

  PriceChangePercent.fromJson(dynamic json) {
    changePercent = json['change_percent'];
    sign = json['sign'];
  }
  double? changePercent;
  String? sign;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['change_percent'] = changePercent;
    map['sign'] = sign;
    return map;
  }

}

class Graph {
  Graph({
      this.floorPrice, 
      this.creationTime, 
      this.date,});

  Graph.fromJson(dynamic json) {
    floorPrice = json['floor_price'];
    creationTime = json['creation_time'];
    date = json['date'];
  }
  double? floorPrice;
  String? creationTime;
  String? date;

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
      this.name,});

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