//로컬데이터에 접속하는 기능들을 모아놓는 곳
// 계속 api를 받아서 사용하면 느리니까 로컬 디비에 저장후 사용
import 'package:hive/hive.dart';

import 'company_listing_entity.dart';

class StockDao {
  static const companyListing = 'companyListing';
  final box = Hive.box('stock.db'); //데이터베이스

  //추가
  Future<void> insertCompanyListings(
      List<CompanyListingEntity> companyListingEntity) async {
    await box.put(StockDao.companyListing, companyListingEntity);
  }

  //클리어
  Future<void> clearCompanyListings() async {
    await box.clear();
  }

  //검색
  Future<List<CompanyListingEntity>> searchCompanyListing(String query) async {
    //데이터 갖오고는거 get
    //박스풋의 키값으로 데이터 가져온다
    final List<CompanyListingEntity> companyListing =
        box.get(StockDao.companyListing, defaultValue: []);
    return companyListing
    .where((element) => element.name.toLowerCase().contains(query.toLowerCase())||
    query.toUpperCase() == element.symbol)
    .toList();
  }
}
