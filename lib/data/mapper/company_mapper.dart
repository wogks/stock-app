//tocompanylistingentity to companylisting
import 'package:stock_app/data/source/local/company_listing_entity.dart';

import '../../domain/model/company_listing.dart';

//컴퍼니리스팅 엔티티에 기능을 추가
extension TocompanyListing on CompanyListingEntity {
  CompanyListing  toCompanyListing() {
    return CompanyListing(
      symbol: symbol,
      name: name,
      exchange: exchange,
    );
  }
}

//반대
extension TocompanyListingEntity on CompanyListing {
  CompanyListingEntity toCompanyListingEntity() {
    return CompanyListingEntity(
      symbol: symbol,
      name: name,
      exchange: exchange,
    );
  }
}