import 'package:uuid/uuid.dart';

class ExchangeCoin {
  String id;
  String title;
  String description;
  double rate;
  String image;
  String excangheType = 'Normal';
  DateTime time;

  ExchangeCoin(
      {this.title = "",
      this.rate = 0.0,
      this.description = "",
      this.image = 'assets/no-image.jpg'})
      : id = const Uuid().v1(),
        time = DateTime.now();
}
