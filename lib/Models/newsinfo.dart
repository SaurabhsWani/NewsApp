// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  String? status;
  int? statusCode;
  String? version;
  String? lastModified;
  String? access;
  int? total;
  int? limit;
  int? offset;
  List<Datum>? data;
  Welcome({
    this.status,
    this.statusCode,
    this.version,
    this.lastModified,
    this.access,
    this.total,
    this.limit,
    this.offset,
    this.data,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        status: json["status"],
        statusCode: json["status-code"],
        version: json["version"],
        lastModified: json["last-modified"],
        access: json["access"],
        total: json["total"],
        limit: json["limit"],
        offset: json["offset"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status-code": statusCode,
        "version": version,
        "last-modified": lastModified,
        "access": access,
        "total": total,
        "limit": limit,
        "offset": offset,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.title,
    this.summary,
    this.link,
    this.published,
    this.image,
  });

  int? id;
  String? title;
  String? summary;
  String? link;
  String? published;
  String? image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        summary: json["summary"] == null ? null : json["summary"],
        link: json["link"],
        published: json["published"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "summary": summary == null ? null : summary,
        "link": link,
        "published": published,
        "image": image == null ? null : image,
      };
}

Welcomey welcomeyFromJson(String str) => Welcomey.fromJson(json.decode(str));

String welcomeyToJson(Welcome data) => json.encode(data.toJson());

class Welcomey {
  Welcomey({
    this.id,
    this.token,
    this.error,
  });

  int? id;
  String? token;
  String? error;

  factory Welcomey.fromJson(Map<String, dynamic> json) => Welcomey(
        id: json["id"],
        token: json["token"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "token": token,
        "error": error,
      };
}
