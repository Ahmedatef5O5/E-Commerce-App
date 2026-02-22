class LocationItemModel {
  final String id;
  final String city;
  final String country;
  final bool isChosen;
  final String imgUrl;

  LocationItemModel({
    required this.id,
    required this.city,
    required this.country,
    this.isChosen = false,
    this.imgUrl =
        'https://previews.123rf.com/images/emojoez/emojoez1903/emojoez190300018/119684277-illustrations-design-concept-location-maps-with-road-follow-route-for-destination-drive-by-gps.jpg',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'city': city,
      'country': country,
      'isChosen': isChosen,
      'imgUrl': imgUrl,
    };
  }

  factory LocationItemModel.fromMap(Map<String, dynamic> map) {
    return LocationItemModel(
      id: map['id'] as String? ?? '',
      city: map['city'] as String? ?? '',
      country: map['country'] as String? ?? '',
      isChosen: map['isChosen'] as bool? ?? false,
      imgUrl: map['imgUrl'] as String? ?? '',
    );
  }

  // String toJson() => json.encode(toMap());

  // factory LocationItemModel.fromJson(String source) => LocationItemModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

List<LocationItemModel> dummyLocations = [
  LocationItemModel(id: '1', city: 'Cairo', country: 'Egypt'),
  LocationItemModel(id: '2', city: 'Minia', country: 'Egypt'),
  LocationItemModel(id: '3', city: 'Alexandria', country: 'Egypt'),
];
