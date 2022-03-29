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
      this.updateTime,});

  SingleProductModel.fromJson(dynamic json) {
    id = json['id'];
    brand = json['brand'];
    graph = json['graph'];
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
  }
  int? id;
  dynamic brand;
  dynamic graph;
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['brand'] = brand;
    map['graph'] = graph;
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
    return map;
  }

}