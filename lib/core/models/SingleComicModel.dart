class SingleComicModel {
  SingleComicModel({
      this.details, 
      this.floorPrices,});

  SingleComicModel.fromJson(dynamic json) {
    details = json['details'] != null ? Details.fromJson(json['details']) : null;
    floorPrices = json['floor_prices'] != null ? FloorPrices.fromJson(json['floorPrices']) : null;
  }
  Details? details;
  FloorPrices? floorPrices;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (details != null) {
      map['details'] = details?.toJson();
    }
    if (floorPrices != null) {
      map['floor_prices'] = floorPrices?.toJson();
    }
    return map;
  }

}

class FloorPrices {
  FloorPrices({
      this.count, 
      this.next, 
      this.previous, 
      this.results,});

  FloorPrices.fromJson(dynamic json) {
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
  dynamic next;
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
      this.date, 
      this.time, 
      this.floorPrice, 
      this.comic,});

  Results.fromJson(dynamic json) {
    id = json['id'];
    date = json['date'];
    time = json['time'];
    floorPrice = json['floor_price'];
    comic = json['comic'];
  }
  int? id;
  String? date;
  String? time;
  String? floorPrice;
  int? comic;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['date'] = date;
    map['time'] = time;
    map['floor_price'] = floorPrice;
    map['comic'] = comic;
    return map;
  }

}

class Details {
  Details({
      this.id, 
      this.name, 
      this.rarity, 
      this.description, 
      this.listing, 
      this.floorPrice, 
      this.owner, 
      this.edition, 
      this.coverVariant, 
      this.coverArtist, 
      this.publisher, 
      this.series, 
      this.issue, 
      this.pages, 
      this.startYear, 
      this.writers, 
      this.artists, 
      this.characters, 
      this.editions,});

  Details.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    rarity = json['rarity'];
    description = json['description'];
    listing = json['listing'];
    floorPrice = json['floor_price'];
    owner = json['owner'];
    edition = json['edition'];
    coverVariant = json['cover_variant'];
    coverArtist = json['cover_artist'];
    publisher = json['publisher'];
    series = json['series'];
    issue = json['issue'];
    pages = json['pages'];
    startYear = json['start_year'];
    writers = json['writers'];
    artists = json['artists'];
    characters = json['characters'];
    editions = json['editions'];
  }
  int? id;
  String? name;
  String? rarity;
  String? description;
  int? listing;
  String? floorPrice;
  String? owner;
  String? edition;
  String? coverVariant;
  String? coverArtist;
  String? publisher;
  String? series;
  String? issue;
  String? pages;
  String? startYear;
  String? writers;
  String? artists;
  String? characters;
  String? editions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['rarity'] = rarity;
    map['description'] = description;
    map['listing'] = listing;
    map['floor_price'] = floorPrice;
    map['owner'] = owner;
    map['edition'] = edition;
    map['cover_variant'] = coverVariant;
    map['cover_artist'] = coverArtist;
    map['publisher'] = publisher;
    map['series'] = series;
    map['issue'] = issue;
    map['pages'] = pages;
    map['start_year'] = startYear;
    map['writers'] = writers;
    map['artists'] = artists;
    map['characters'] = characters;
    map['editions'] = editions;
    return map;
  }

}