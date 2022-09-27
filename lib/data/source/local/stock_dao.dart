//로컬데이터에 접속하는 기능들을 모아놓는 곳
// 계속 api를 받아서 사용하면 느리니까 로컬 디비에 저장후 사용
import 'package:hive/hive.dart';

import 'company_listing_entity.dart';

class StockDao {
  static const companyListing = 'companyListing';

  //추가
  Future<void> insertCompanyListings(
      List<CompanyListingEntity> companyListingEntities) async {
    final box = await Hive.openBox<CompanyListingEntity>('stock.db');
    await box.addAll(companyListingEntities);
  }

  //클리어
  Future<void> clearCompanyListings() async {
    final box = await Hive.openBox<CompanyListingEntity>('stock.db');
    await box.clear();
  }

  //검색
  Future<List<CompanyListingEntity>> searchCompanyListing(String query) async {
    final box = await Hive.openBox<CompanyListingEntity>('stock.db');
    //데이터 갖오고는거 get
    //박스풋의 키값으로 데이터 가져온다
    final List<CompanyListingEntity> companyListing = box.values.toList();
    return companyListing
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()) ||
            query.toUpperCase() == element.symbol)
        .toList();
  }
}
