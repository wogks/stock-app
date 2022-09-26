//인터페이스의 기능들을 구현
import 'package:stock_app/data/mapper/company_mapper.dart';
import 'package:stock_app/data/source/remote/stock_api.dart';
import 'package:stock_app/domain/model/company_listing.dart';
import 'package:stock_app/domain/repository/stock_repository.dart';
import 'package:stock_app/util/result.dart';

import '../source/local/stock_dao.dart';

class StockRepositoryImpl implements StockRepository {
  final StockApi _api; //리모트해서 데이터를 가져올때 필요함
  final StockDao _dao; //로컬에 접근할수있는 다오
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
      final remoteListings= await _api.getListings();
      return Result.success([]);
    } catch (e) {
      return Result.error(Exception('데이터로드 실패'));
    }
    throw UnimplementedError();
  }
}
