/*
class ErrorModel {
  List<Errors>? errors;
  Data? data;

  ErrorModel({this.errors, this.data});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    if (json['errors'] != null) {
      errors = [];
      json['errors'].forEach((v) {
        errors!.add(Errors.fromJson(v));
      });
    }
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (errors != null) {
      data['errors'] = errors!.map((v) => v.toJson()).toList();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Errors {
  var message;
  List<Locations>? locations;
  List<String>? path;

  Errors({this.message, this.locations, this.path});

  Errors.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['locations'] != null) {
      locations = [];
      json['locations'].forEach((v) {
        locations!.add(Locations.fromJson(v));
      });
    }
    path = json['path'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (locations != null) {
      data['locations'] = locations!.map((v) => v.toJson()).toList();
    }
    data['path'] = path;
    return data;
  }
}

class Locations {
  var line;
  var column;

  Locations({this.line, this.column});

  Locations.fromJson(Map<String, dynamic> json) {
    line = json['line'];
    column = json['column'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['line'] = line;
    data['column'] = column;
    return data;
  }
}

class Data {
  void loginUser;

  Data({this.loginUser});

  Data.fromJson(Map<String, dynamic> json) {
    loginUser = json['loginUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['loginUser'] = loginUser;
    return data;
  }
}*/
