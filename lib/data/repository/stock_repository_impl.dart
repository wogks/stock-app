//인터페이스의 기능들을 구현
import 'package:stock_app/data/csv/company_listings_parser.dart';
import 'package:stock_app/data/mapper/company_mapper.dart';
import 'package:stock_app/data/source/remote/stock_api.dart';
import 'package:stock_app/domain/model/company_listing.dart';
import 'package:stock_app/domain/repository/stock_repository.dart';
import 'package:stock_app/util/result.dart';

import '../source/local/stock_dao.dart';

class StockRepositoryImpl implements StockRepository {
  final StockApi _api; //리모트해서 데이터를 가져올때 필요함
  final StockDao _dao; //로컬에 접근할수있는 다오
  final _parser = CompanyListingsParser();
  StockRepositoryImpl(this._api, this._dao);

  @override
  Future<Result<List<CompanyListing>>> getCompanyListings(
      bool fetchFromRemote, String query) async {
    //캐시에서 찾는다
    final localListings = await _dao.searchCompanyListing(query);


    //없다면 리모트에서 찾는다

    final isDbEmpty = localListings.isEmpty && query.isEmpty; 
    final shouldJustLoadFromCache = !isDbEmpty && !fetchFromRemote;

    if(shouldJustLoadFromCache) {
      return Result.success(
        localListings.map((e) => e.toCompanyListing()).toList());
    }
    //리모트
    try {
      final response= await _api.getListings();
      final remoteListings = await _parser.parse(response.body);

      //캐시 비우기(안그러면 계속 데이터가 추가가 됨)
      await _dao.clearCompanyListings();


      //데이터를 받아오면 캐싱을 해야함. db에 넣는로직(캐싱 추가)
      await _dao.insertCompanyListings(
        remoteListings.map((e) => e.toCompanyListingEntity()).toList()
      );
      return Result.success(remoteListings);
    } catch (e) {
      return Result.error(Exception('데이터로드 실패'));
    }
    
  }
}
