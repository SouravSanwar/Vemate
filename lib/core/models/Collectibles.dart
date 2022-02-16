class Collectibles {
  Collectibles({
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
      this.series,});

  Collectibles.fromJson(dynamic json) {
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
  }
  var id;
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