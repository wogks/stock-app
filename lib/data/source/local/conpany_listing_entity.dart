//database형태로 데이터 저장
import 'package:hive/hive.dart';

class CompanyListingEntuty {
  @HiveField(0)
  String symbol;
  @HiveField(1)
  String name;
  @HiveField(2)
  String exchange;

  CompanyListingEntuty({
    required this.symbol,
    required this.name,
    required this.exchange,
  });
}
