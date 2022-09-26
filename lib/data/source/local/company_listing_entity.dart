//database형태로 데이터 저장
import 'package:hive/hive.dart';

part 'company_listing_entity.g.dart'; //하이브 제네레이터 필요

@HiveType(typeId: 0)
class CompanyListingEntity {
  @HiveField(0)
  String symbol;
  @HiveField(1)
  String name;
  @HiveField(2)
  String exchange;

  CompanyListingEntity({
    required this.symbol,
    required this.name,
    required this.exchange,
  });
}
