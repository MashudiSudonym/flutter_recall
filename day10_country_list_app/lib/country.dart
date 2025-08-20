class Country {
  final String name;
  final String region;
  final String flagUrl;

  Country({required this.name, required this.region, required this.flagUrl});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'] ?? 'Unknown',
      region: json['region'] ?? 'Unknows',
      flagUrl: json['flags']['png'] ?? '',
    );
  }
}
