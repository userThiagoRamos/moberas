class UserLocation {
  final double latitude;
  final double longitude;

  UserLocation({this.latitude, this.longitude});

  factory UserLocation.fromMap(Map data) {
    return UserLocation(
      latitude: data['latitude'],
      longitude: data['longitude'],
    );
  }
  Map<String, dynamic> toJson() =>
      {'latitude': latitude, 'longitude': longitude};
}
