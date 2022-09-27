//tocompanylistingentity to companylisting
import 'package:stock_app/data/source/local/company_listing_entity.dart';
import 'package:stock_app/data/source/remote/dto/company_info_dto.dart';

import '../../domain/model/company_info.dart';
import '../../domain/model/company_listing.dart';

//컴퍼니리스팅 엔티티에 기능을 추가
extension TocompanyListing on CompanyListingEntity {
  CompanyListing toCompanyListing() {
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

//companyinfo에서 이 기능을 추가
extension ToCompanyInfo on CompanyInfoDto {
  CompanyInfo toCompanyInfo() {
    return CompanyInfo(
      symbol: symbol ?? '',
      description: description ?? '',
      name: name ?? '',
      country: country ?? '',
      industry: industry ?? '',
    );
  }
}
