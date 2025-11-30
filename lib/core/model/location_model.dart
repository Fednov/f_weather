import 'dart:convert';

class LocationModel {
  final int? id;
  final String name;
  final double lat;
  final double lon;
  final String country;
  final String? region;
  final String? url;
  final int? localtimeEpoch;
  final String? localtime;
  LocationModel({
    this.id,
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
    this.region,
    this.url,
    this.localtimeEpoch,
    this.localtime,
  });

  LocationModel copyWith({
    int? id,
    String? name,
    double? lat,
    double? lon,
    String? country,
    String? region,
    String? url,
    int? localtimeEpoch,
    String? localtime,
  }) {
    return LocationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      country: country ?? this.country,
      region: region ?? this.region,
      url: url ?? this.url,
      localtimeEpoch: localtimeEpoch ?? this.localtimeEpoch,
      localtime: localtime ?? this.localtime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'lat': lat,
      'lon': lon,
      'country': country,
      'region': region,
      'url': url,
      'localtimeEpoch': localtimeEpoch,
      'localtime': localtime,
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      id: map['id']?.toInt(),
      name: map['name'] ?? '',
      lat: map['lat']?.toDouble() ?? 0.0,
      lon: map['lon']?.toDouble() ?? 0.0,
      country: map['country'] ?? '',
      region: map['region'],
      url: map['url'],
      localtimeEpoch: map['localtime_epoch']?.toInt(),
      localtime: map['localtime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) =>
      LocationModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocationModel &&
        other.id == id &&
        other.name == name &&
        other.lat == lat &&
        other.lon == lon &&
        other.country == country &&
        other.region == region &&
        other.url == url &&
        other.localtimeEpoch == localtimeEpoch &&
        other.localtime == localtime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        lat.hashCode ^
        lon.hashCode ^
        country.hashCode ^
        region.hashCode ^
        url.hashCode ^
        localtimeEpoch.hashCode ^
        localtime.hashCode;
  }

  @override
  String toString() {
    return 'LocationModel(id: $id, name: $name, lat: $lat, lon: $lon, country: $country, region: $region, url: $url, localtimeEpoch: $localtimeEpoch, localtime: $localtime)';
  }
}
