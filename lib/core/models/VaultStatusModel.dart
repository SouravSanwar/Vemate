import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VaultStatsModel {
  VaultStatsModel({
    this.totalVaultValue,
    this.mcp,
    this.totalPriceChange,
    this.totalPercentChange,
    this.collectible,
    this.comic,
  });

  VaultStatsModel.fromJson(dynamic json) {
    totalVaultValue = json['total_vault_value'];
    mcp = json['mcp'];
    totalPriceChange = json['total_price_change'];
    totalPercentChange =
        double.parse(json['total_percent_change'].toString()).toPrecision(2);
    collectible = json['collectible'] != null
        ? Collectible.fromJson(json['collectible'])
        : null;
    comic = json['comic'] != null ? Comic.fromJson(json['comic']) : null;
  }

  var totalVaultValue;
  int? mcp;
  var totalPriceChange;
  var totalPercentChange;
  Collectible? collectible;
  Comic? comic;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_vault_value'] = totalVaultValue;
    map['mcp'] = mcp;
    map['total_price_change'] = totalPriceChange;
    map['total_percent_change'] = totalPercentChange;
    if (collectible != null) {
      map['collectible'] = collectible?.toJson();
    }
    if (comic != null) {
      map['comic'] = comic?.toJson();
    }
    return map;
  }
}

class Comic {
  Comic({
    this.totalComicValue,
    this.sign,
    this.changePercent,
    this.changePrice,
    this.comicGraph,
    this.mcp,
  });

  Comic.fromJson(dynamic json) {
    totalComicValue = json['total_comic_value'];
    sign = json['sign'];
    changePercent = double.parse(json['change_percent'].toString()).toPrecision(2);
    changePrice = double.parse(json['change_price'].toString()).toPrecision(2);
    if (json['graph'] != null) {
      comicGraph = [];
      json['graph'].forEach((v) {
        comicGraph?.add(ComicGraph.fromJson(v));
      });
    }
    mcp = json['mcp'];
  }

  var totalComicValue;
  String? sign;
  var changePercent;
  var changePrice;
  List<ComicGraph>? comicGraph;
  int? mcp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_comic_value'] = totalComicValue;
    map['sign'] = sign;
    map['change_percent'] = changePercent;
    map['change_price'] = changePrice;
    if (comicGraph != null) {
      map['graph'] = comicGraph?.map((v) => v.toJson()).toList();
    }
    map['mcp'] = mcp;
    return map;
  }
}

class ComicGraph {
  ComicGraph({
    this.hour,
    this.total,
    this.inHour,
  });

  ComicGraph.fromJson(dynamic json) {
    hour = json['hour'];
    total = json['total'];
    inHour = DateFormat('hh a').format(DateTime.parse(hour!));
  }

  String? hour;
  var inHour;
  double? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hour'] = hour;
    map['total'] = total;
    return map;
  }
}

class Collectible {
  Collectible({
    this.totalCollectibleValue,
    this.sign,
    this.changePercent,
    this.changePrice,
    this.collectibleGraph,
    this.mcp,
  });

  Collectible.fromJson(dynamic json) {
    totalCollectibleValue = json['total_collectible_value'];
    sign = json['sign'];
    changePercent = double.parse(json['change_percent'].toString()).toPrecision(2);
    changePrice = json['change_price'];
    if (json['collectible_graph'] != null) {
      collectibleGraph = [];
      json['graph'].forEach((v) {
        collectibleGraph?.add(CollectibleGraph.fromJson(v));
      });
    }
    mcp = json['mcp'];
  }

  var totalCollectibleValue;
  String? sign;
  var changePercent;
  var changePrice;
  List<CollectibleGraph>? collectibleGraph;
  int? mcp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_collectible_value'] = totalCollectibleValue;
    map['sign'] = sign;
    map['change_percent'] = changePercent;
    map['change_price'] = changePrice;
    if (collectibleGraph != null) {
      map['graph'] =
          collectibleGraph?.map((v) => v.toJson()).toList();
    }
    map['mcp'] = mcp;
    return map;
  }
}

class CollectibleGraph {
  CollectibleGraph({
    this.hour,
    this.total,
    this.inHour,
  });

  CollectibleGraph.fromJson(dynamic json) {
    hour = json['hour'];
    total = json['total'];
    inHour = DateFormat('hh a').format(DateTime.parse(hour!));
  }

  String? hour;
  double? total;
  var inHour;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hour'] = hour;
    map['total'] = total;
    return map;
  }
}
