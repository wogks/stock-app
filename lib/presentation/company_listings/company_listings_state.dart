import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/company_listing.dart';

part 'company_listings_state.freezed.dart';

part 'company_listings_state.g.dart';

@freezed
class CompanyListingsState with _$CompanyListingsState {
  const factory CompanyListingsState({
    //@default는 디폴트값지정, 아니면 required를 사용해야함 디폴트 사용하면 다 안써도 되서 편함
    @Default([]) List<CompanyListing> companies,
    @Default(false) bool isLoading, //로딩중인지 아닌지
    @Default(false) bool isRefreshing, // 리프레쉬중인지 아닌지
    @Default('') String searchQuery,

    
  }) = _CompanyListingsState;

  factory CompanyListingsState.fromJson(Map<String, Object?> json) => _$CompanyListingsStateFromJson(json);
}