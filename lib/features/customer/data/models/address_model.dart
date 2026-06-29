class AddressModel {
  final String id;
  final String country;
  final String region;
  final String city;
  final String street;
  final String? postalCode;
  final bool isDefault;

  const AddressModel({
    required this.id,
    required this.country,
    required this.region,
    required this.city,
    required this.street,
    this.postalCode,
    this.isDefault = false,
  });

  String get fullAddress => '$street, $city, $region, $country';

  String get summary => '$street, $city';

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json['id']?.toString() ?? '',
        country: json['country'] as String? ?? '',
        region: json['region'] as String? ?? '',
        city: json['city'] as String? ?? '',
        street: json['street'] as String? ?? '',
        postalCode: json['postal_code'] as String?,
        isDefault: json['is_default'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'country': country,
        'region': region,
        'city': city,
        'street': street,
        'postal_code': postalCode,
        'is_default': isDefault,
      };
}
