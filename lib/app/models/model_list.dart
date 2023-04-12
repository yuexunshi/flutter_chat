import 'package:flutter_nb_net/flutter_net.dart';

/// data : [{"id":"model-id-0","object":"model","owned_by":"organization-owner","permission":["..."]},{"id":"model-id-1","object":"model","owned_by":"organization-owner","permission":["..."]},{"id":"model-id-2","object":"model","owned_by":"openai","permission":["..."]},null]
/// object : "list"

class ModelList extends BaseNetModel {
  ModelList({
    this.data,
    this.object,
  });

  ModelList.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ModelBean.fromJson(v));
      });
    }
    object = json['object'];
  }

  List<ModelBean>? data;
  String? object;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['object'] = object;
    return map;
  }

  @override
  ModelList fromJson(Map<String, dynamic> json) {
    return ModelList.fromJson(json);
  }
}

/// id : "model-id-0"
/// object : "model"
/// owned_by : "organization-owner"
/// permission : ["..."]

class ModelBean {
  ModelBean({
    this.id,
    this.object,
    this.ownedBy,
    this.permission,
  });

  ModelBean.fromJson(dynamic json) {
    id = json['id'];
    object = json['object'];
    ownedBy = json['owned_by'];
    permission =
        json['permission'] != null ? json['permission'].cast<String>() : [];
  }

  String? id;
  String? object;
  String? ownedBy;
  List<String>? permission;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['object'] = object;
    map['owned_by'] = ownedBy;
    map['permission'] = permission;
    return map;
  }
}
