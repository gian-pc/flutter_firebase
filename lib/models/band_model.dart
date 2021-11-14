import 'dart:convert';

BandModel bandModelFromJson(String str) => BandModel.fromJson(json.decode(str));

String bandModelToJson(BandModel data) => json.encode(data.toJson());

class BandModel {
  BandModel({
    required this.pk,
    required this.id,
    required this.band,
    required this.image,
    required this.status,
    this.setlist,
  });

  String pk;
  int id;
  String band;
  String image;
  bool status;
  List<Setlist>? setlist;

  factory BandModel.fromJson(Map<String, dynamic> json) => BandModel(
    pk: json["pk"],
    id: json["id"],
    band: json["band"],
    image: json["image"],
    status: json["status"],
    setlist:json["setlist"] != null ? List<Setlist>.from(json["setlist"].map((x) => Setlist.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "pk": pk,
    "id": id,
    "band": band,
    "image": image,
    "status": status,
    "setlist": List<dynamic>.from(setlist!.map((x) => x.toJson())),
  };
}

class Setlist {
  Setlist({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Setlist.fromJson(Map<String, dynamic> json) => Setlist(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
