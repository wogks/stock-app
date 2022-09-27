//개발시 사용할 기능 추상클래스 작성 후 데이타 레포에서 실제구현 로직 작성(인터페이스)
import 'package:stock_app/domain/model/company_listing.dart';
import 'package:stock_app/util/result.dart';

abstract class StockRepository {
  //에러처리를 위해서 리절트로 한번 매핑 후 가져온다
  Future<Result<List<CompanyListing>>> getCompanyListings(
    //리모트해서 가져올거냐, 로컬에서 가져올거냐 트루폴스를 통해 조절을 위해
    bool fetchFromRemote,
    String query,
  );
}