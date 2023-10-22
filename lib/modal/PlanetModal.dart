
import 'dart:convert';

PlanetModal planetModalFromJson(String str) => PlanetModal.fromJson(json.decode(str));

String planetModalToJson(PlanetModal data) => json.encode(data.toJson());

class PlanetModal {
  String? solarSystem;
  List<Planet>? planets;

  PlanetModal({
    this.solarSystem,
    this.planets,
  });

  factory PlanetModal.fromJson(Map<String, dynamic> json) => PlanetModal(
    solarSystem: json["solar_system"],
    planets: json["planets"] == null ? [] : List<Planet>.from(json["planets"]!.map((x) => Planet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "solar_system": solarSystem,
    "planets": planets == null ? [] : List<dynamic>.from(planets!.map((x) => x.toJson())),
  };
}

class Planet {
  String? position;
  String? name;
  String? type;
  String? image;
  String? velocity;
  String? distance;
  String? description;
  Diameter? distanceFromSun;
  Diameter? diameter;
  Diameter? mass;
  Diameter? gravity;
  List<String>? atmosphere;
  List<Moon>? moons;

  Planet({
    this.position,
    this.name,
    this.type,
    this.image,
    this.velocity,
    this.distance,
    this.description,
    this.distanceFromSun,
    this.diameter,
    this.mass,
    this.gravity,
    this.atmosphere,
    this.moons,
  });

  factory Planet.fromJson(Map<String, dynamic> json) => Planet(
    position: json["position"],
    name: json["name"],
    type: json["type"],
    image: json["image"],
    velocity: json["velocity"],
    distance: json["distance"],
    description: json["description"],
    distanceFromSun: json["distance_from_sun"] == null ? null : Diameter.fromJson(json["distance_from_sun"]),
    diameter: json["diameter"] == null ? null : Diameter.fromJson(json["diameter"]),
    mass: json["mass"] == null ? null : Diameter.fromJson(json["mass"]),
    gravity: json["gravity"] == null ? null : Diameter.fromJson(json["gravity"]),
    atmosphere: json["atmosphere"] == null ? [] : List<String>.from(json["atmosphere"]!.map((x) => x)),
    moons: json["moons"] == null ? [] : List<Moon>.from(json["moons"]!.map((x) => Moon.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "position": position,
    "name": name,
    "type": type,
    "image": image,
    "velocity": velocity,
    "distance": distance,
    "description": description,
    "distance_from_sun": distanceFromSun?.toJson(),
    "diameter": diameter?.toJson(),
    "mass": mass?.toJson(),
    "gravity": gravity?.toJson(),
    "atmosphere": atmosphere == null ? [] : List<dynamic>.from(atmosphere!.map((x) => x)),
    "moons": moons == null ? [] : List<dynamic>.from(moons!.map((x) => x.toJson())),
  };
}

class Diameter {
  String? value;
  Unit? unit;

  Diameter({
    this.value,
    this.unit,
  });

  factory Diameter.fromJson(Map<String, dynamic> json) => Diameter(
    value: json["value"],
    unit: unitValues.map[json["unit"]]!,
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "unit": unitValues.reverse[unit],
  };
}

enum Unit {
  KILOGRAMS,
  KILOMETERS,
  MILLION_KILOMETERS,
  M_S
}

final unitValues = EnumValues({
  "kilograms": Unit.KILOGRAMS,
  "kilometers": Unit.KILOMETERS,
  "million kilometers": Unit.MILLION_KILOMETERS,
  "m/s²": Unit.M_S
});

class Moon {
  String? name;
  Diameter? distanceFromPlanet;

  Moon({
    this.name,
    this.distanceFromPlanet,
  });

  factory Moon.fromJson(Map<String, dynamic> json) => Moon(
    name: json["name"],
    distanceFromPlanet: json["distance_from_planet"] == null ? null : Diameter.fromJson(json["distance_from_planet"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "distance_from_planet": distanceFromPlanet?.toJson(),
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(k as T, v as String));
    return reverseMap;
  }
}
