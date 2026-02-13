class LocationItemModel {
  final String id;
  final String city;
  final String countery;
  final String imgUrl;

  LocationItemModel({
    required this.id,
    required this.city,
    required this.countery,
    this.imgUrl =
        'https://previews.123rf.com/images/emojoez/emojoez1903/emojoez190300018/119684277-illustrations-design-concept-location-maps-with-road-follow-route-for-destination-drive-by-gps.jpg',
  });
}

List<LocationItemModel> dummyLocations = [
  LocationItemModel(id: '1', city: 'Cairo', countery: 'Egypt'),
  LocationItemModel(id: '2', city: 'Minia', countery: 'Egypt'),
  LocationItemModel(id: '3', city: 'Alexandria', countery: 'Egypt'),
];
