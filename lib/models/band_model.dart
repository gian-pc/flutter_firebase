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
  });

  String pk;
  int id;
  String band;
  String image;
  bool status;

  factory BandModel.fromJson(Map<String, dynamic> json) => BandModel(
    pk: json["pk"],
    id: json["id"],
    band: json["band"],
    image: json["image"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "pk": pk,
    "id": id,
    "band": band,
    "image": image,
    "status": status,
  };
}