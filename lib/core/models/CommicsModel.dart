import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComicsModel {
  ComicsModel({
    this.comics,
  });

  ComicsModel.fromJson(dynamic json) {
    comics = json['comics'] != null ? Comics.fromJson(json['comics']) : null;
  }

  Comics? comics;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (comics != null) {
      map['comics'] = comics?.toJson();
    }
    return map;
  }
}

class Comics {
  Comics({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  Comics.fromJson(dynamic json) {
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
    this.editions,
    this.rarePoint,
    this.cpp,
  });

  Results.fromJson(dynamic json) {
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
    if (rarity == 'Rare') {
      rarePoint = 2;
      cpp = (double.parse(floorPrice!) / rarePoint!).toPrecision(2);
      rarityColor = Colors.deepPurpleAccent.shade100;
    } else if (rarity == 'Ultra Rare') {
      rarePoint = 3;
      cpp = (double.parse(floorPrice!) / rarePoint!).toPrecision(2);
      rarityColor = Colors.green.shade100;
    } else {
      rarePoint = 1;
      cpp = (double.parse(floorPrice!) / rarePoint!).toPrecision(2);
      if (rarity == 'Common') {
        rarityColor = Colors.blueGrey;
      } else {
        rarityColor = Colors.lime;
      }
    }
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
  int? rarePoint;
  double? cpp;
  Color? rarityColor;

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
