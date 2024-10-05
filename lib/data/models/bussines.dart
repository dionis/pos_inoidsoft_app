class Bussines {
  String name;
  String address;
  String image;
  List<String> phoneNumbers;

  Bussines(
      {required this.name,
      required this.address,
      required this.image,
      required this.phoneNumbers});

  Bussines copyWith({
    String? name,
    String? address,
    String? image,
    List<String>? phoneNumbers,
  }) =>
      Bussines(
        name: name ?? this.name,
        address: address ?? this.address,
        image: image ?? this.image,
        phoneNumbers: phoneNumbers ?? this.phoneNumbers,
      );
}
