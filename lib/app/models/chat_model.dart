import 'package:flutter_nb_net/flutter_net.dart';

class ChatModel extends BaseNetModel {
  @override
  fromJson(Map<String, dynamic> json) {
    return ChatModel.fromJson(json);
  }

  ChatModel({
    this.id,
    this.object,
    this.created,
    this.model,
    this.usage,
    this.choices,
  });

  ChatModel.fromJson(dynamic json) {
    id = json['id'];
    object = json['object'];
    created = json['created'];
    model = json['model'];
    usage = json['usage'] != null ? Usage.fromJson(json['usage']) : null;
    if (json['choices'] != null) {
      choices = [];
      json['choices'].forEach((v) {
        choices?.add(Choices.fromJson(v));
      });
    }
  }

  String? id;
  String? object;
  num? created;
  String? model;
  Usage? usage;
  List<Choices>? choices;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['object'] = object;
    map['created'] = created;
    map['model'] = model;
    if (usage != null) {
      map['usage'] = usage?.toJson();
    }
    if (choices != null) {
      map['choices'] = choices?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// message : {"role":"assistant","content":"Hello there! How can I assist you today?"}
/// finish_reason : "stop"
/// index : 0

class Choices {
  Choices({
    this.message,
    this.text,
    this.finishReason,
    this.index,
  });

  Choices.fromJson(dynamic json) {
    message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
    text = json['text'];
    finishReason = json['finish_reason'];
    index = json['index'];
  }

  Message? message;
  String? finishReason;
  String? text;
  num? index;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (message != null) {
      map['message'] = message?.toJson();
    }
    map['text'] = text;
    map['finish_reason'] = finishReason;
    map['index'] = index;
    return map;
  }
}

/// role : "assistant"
/// content : "Hello there! How can I assist you today?"

class Message {
  Message({
    this.role,
    this.content,
  });

  Message.fromJson(dynamic json) {
    role = json['role'];
    content = json['content'];
  }

  String? role;
  String? content;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['role'] = role;
    map['content'] = content;
    return map;
  }
}

/// prompt_tokens : 10
/// completion_tokens : 10
/// total_tokens : 20

class Usage {
  Usage({
    this.promptTokens,
    this.completionTokens,
    this.totalTokens,
  });

  Usage.fromJson(dynamic json) {
    promptTokens = json['prompt_tokens'];
    completionTokens = json['completion_tokens'];
    totalTokens = json['total_tokens'];
  }

  num? promptTokens;
  num? completionTokens;
  num? totalTokens;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['prompt_tokens'] = promptTokens;
    map['completion_tokens'] = completionTokens;
    map['total_tokens'] = totalTokens;
    return map;
  }
}
