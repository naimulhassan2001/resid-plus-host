class MyResidence {
  int views;
  int likes;
  int comments;
  int rank;
  String id;
  String residenceName;
  List<Photo> photos;
  int capacity;
  int beds;
  int baths;
  String address;
  String city;
  String municipality;
  String quirtier;
  String aboutResidence;
  int hourlyAmount;
  int popularity;
  int ratings;
  int dailyAmount;
  List<Amenity> amenities;
  String ownerName;
  String hostId;
  String aboutOwner;
  String status;
  Category category;
  Country country;
  bool isDeleted;
  String acceptanceStatus;
  DateTime createdAt;
  DateTime updatedAt;
  int version;
  String feedBack;
  bool reUpload;

  MyResidence({
    this.views = 0,
    this.likes = 0,
    this.comments = 0,
    this.rank = 0,
    required this.id,
    this.residenceName = '',
    this.photos = const [],
    this.capacity = 0,
    this.beds = 0,
    this.baths = 0,
    this.address = '',
    this.city = '',
    this.municipality = '',
    this.quirtier = '',
    this.aboutResidence = '',
    this.hourlyAmount = 0,
    this.popularity = 0,
    this.ratings = 0,
    this.dailyAmount = 0,
    this.amenities = const [],
    this.ownerName = '',
    required this.hostId,
    this.aboutOwner = '',
    this.status = 'inactive',
    required this.category,
    required this.country,
    this.isDeleted = false,
    this.acceptanceStatus = 'pending',
    required this.createdAt,
    required this.updatedAt,
    this.version = 0,
    this.feedBack = '',
    this.reUpload = false,
  });

  factory MyResidence.fromJson(Map<String, dynamic> json) {
    return MyResidence(
      views: json['views'] ?? 0,
      likes: json['likes'] ?? 0,
      comments: json['comments'] ?? 0,
      rank: json['rank'] ?? 0,
      id: json['_id'] ?? '',
      residenceName: json['residenceName'] ?? '',
      photos:
          List<Photo>.from(json['photo']?.map((x) => Photo.fromJson(x)) ?? []),
      capacity: json['capacity'] ?? 0,
      beds: json['beds'] ?? 0,
      baths: json['baths'] ?? 0,
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      municipality: json['municipality'] ?? '',
      quirtier: json['quirtier'] ?? '',
      aboutResidence: json['aboutResidence'] ?? '',
      hourlyAmount: json['hourlyAmount'] ?? 0,
      popularity: json['popularity'] ?? 0,
      ratings: json['ratings'] ?? 0,
      dailyAmount: json['dailyAmount'] ?? 0,
      amenities: List<Amenity>.from(
          json['amenities']?.map((x) => Amenity.fromJson(x)) ?? []),
      ownerName: json['ownerName'] ?? '',
      hostId: json['hostId'] ?? '',
      aboutOwner: json['aboutOwner'] ?? '',
      status: json['status'] ?? 'inactive',
      category: Category.fromJson(json['category'] ?? {}),
      country: Country.fromJson(json['country'] ?? {}),
      isDeleted: json['isDeleted'] ?? false,
      acceptanceStatus: json['acceptanceStatus'] ?? 'pending',
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      version: json['__v'] ?? 0,
      feedBack: json['feedBack'] ?? '',
      reUpload: json['reUpload'] ?? false,
    );
  }
}

class Photo {
  String publicFileUrl;
  String path;

  Photo({
    this.publicFileUrl = '',
    this.path = '',
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      publicFileUrl: json['publicFileUrl'] ?? '',
      path: json['path'] ?? '',
    );
  }
}

class Amenity {
  Translation translation;
  String id;

  Amenity({
    required this.translation,
    this.id = '',
  });

  factory Amenity.fromJson(Map<String, dynamic> json) {
    return Amenity(
      translation: Translation.fromJson(json['translation'] ?? {}),
      id: json['_id'] ?? '',
    );
  }
}

class Translation {
  String en;
  String fr;

  Translation({
    this.en = '',
    this.fr = '',
  });

  factory Translation.fromJson(Map<String, dynamic> json) {
    return Translation(
      en: json['en'] ?? '',
      fr: json['fr'] ?? '',
    );
  }
}

class Category {
  Translation translation;
  String id;

  Category({
    required this.translation,
    this.id = '',
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      translation: Translation.fromJson(json['translation'] ?? {}),
      id: json['_id'] ?? '',
    );
  }
}

class Country {
  String id;
  String countryName;

  Country({
    this.id = '',
    this.countryName = '',
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['_id'] ?? '',
      countryName: json['countryName'] ?? '',
    );
  }
}
