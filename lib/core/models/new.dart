class New {
  New({
      this.id, 
      this.brand, 
      this.graph, 
      this.graphType, 
      this.priceChangePercent, 
      this.image, 
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

  New.fromJson(dynamic json) {
    id = json['id'];
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    graph = json['graph'];
    graphType = json['graph_type'];
    priceChangePercent = json['price_change_percent'] != null ? PriceChangePercent.fromJson(json['price_change_percent']) : null;
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
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
  dynamic graph;
  dynamic graphType;
  PriceChangePercent? priceChangePercent;
  Image? image;
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
    map['graph'] = graph;
    map['graph_type'] = graphType;
    if (priceChangePercent != null) {
      map['price_change_percent'] = priceChangePercent?.toJson();
    }
    if (image != null) {
      map['image'] = image?.toJson();
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

class Image {
  Image({
      this.original, 
      this.detail,});

  Image.fromJson(dynamic json) {
    original = json['original'] != null ? Original.fromJson(json['original']) : null;
    detail = json['detail'] != null ? Detail.fromJson(json['detail']) : null;
  }
  Original? original;
  Detail? detail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (original != null) {
      map['original'] = original?.toJson();
    }
    if (detail != null) {
      map['detail'] = detail?.toJson();
    }
    return map;
  }

}

class Detail {
  Detail({
      this.src, 
      this.width, 
      this.height, 
      this.alt,});

  Detail.fromJson(dynamic json) {
    src = json['src'];
    width = json['width'];
    height = json['height'];
    alt = json['alt'];
  }
  String? src;
  int? width;
  int? height;
  String? alt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['src'] = src;
    map['width'] = width;
    map['height'] = height;
    map['alt'] = alt;
    return map;
  }

}

class Original {
  Original({
      this.src, 
      this.width, 
      this.height, 
      this.alt,});

  Original.fromJson(dynamic json) {
    src = json['src'];
    width = json['width'];
    height = json['height'];
    alt = json['alt'];
  }
  String? src;
  int? width;
  int? height;
  String? alt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['src'] = src;
    map['width'] = width;
    map['height'] = height;
    map['alt'] = alt;
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