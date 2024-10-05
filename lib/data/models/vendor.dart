class Vendor {
  String name;
  String idSerialNumber;
  String phoneNumber;
  String email;
  String avatarImage;
  String magneticCart;

  Vendor(
      {required this.name,
      required this.idSerialNumber,
      required this.phoneNumber,
      required this.email,
      required this.avatarImage,
      required this.magneticCart});

  Vendor copyWith(
          {String? name,
          String? idSerialNumber,
          String? phoneNumber,
          String? email,
          String? avatarImage,
          String? magneticCart}) =>
      Vendor(
          name: name ?? this.name,
          idSerialNumber: idSerialNumber ?? this.idSerialNumber,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          email: email ?? this.email,
          avatarImage: avatarImage ?? this.avatarImage,
          magneticCart: magneticCart ?? this.magneticCart);
}
