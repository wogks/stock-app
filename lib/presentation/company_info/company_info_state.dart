import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/company_info.dart';

part 'company_info_state.freezed.dart';

part 'company_info_state.g.dart';

@freezed
class CompanyInfoState with _$CompanyInfoState {
  const factory CompanyInfoState({
    //data 가 없는 경우도 있을수 있으니 널러블
    CompanyInfo? companyInfo,
    @Default(false)bool isLoading,
    String? errorMessage,

    
  }) = _CompanyInfoState;

  factory CompanyInfoState.fromJson(Map<String, Object?> json) => _$CompanyInfoStateFromJson(json);
}