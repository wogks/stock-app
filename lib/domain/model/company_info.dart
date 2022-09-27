import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_info.freezed.dart';

part 'company_info.g.dart';
//상세내용 api가져오기
@freezed
class CompanyInfo with _$CompanyInfo {
  const factory CompanyInfo({
    required String symbol,
    required String description,
    required String name,
    required String country,
    required String industry,
  }) = _CompanyInfo;
  //symbol이 주어지면 그거에 관련된 info를 불러오는 기능
  factory CompanyInfo.fromJson(Map<String, Object?> json) => _$CompanyInfoFromJson(json);
}