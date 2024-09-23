class Currency {
  String name;
  DateTime time;
  double rate = 0.0;
  String source = '';
  String balance = '0.0';
  String profit = '0.0';

  String imageAvatar = '';
  String excangheType = 'Manual';

  void set currencyDateSetRate(DateTime _newTime) => time = _newTime;

  Currency(
      {required this.name,
      this.rate = 0.0,
      this.source = '',
      this.balance = '',
      this.profit = '',
      this.imageAvatar = ''})
      : time = DateTime.now();
}
