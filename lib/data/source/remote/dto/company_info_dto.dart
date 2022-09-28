// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_info_dto.freezed.dart';

part 'company_info_dto.g.dart';
//dto를 통해 모델클라스를 불러옴 모델을 널러블로 하면 힘들기 떄문에 dto에 널러블을 만든다
@freezed
class CompanyInfoDto with _$CompanyInfoDto {
  const factory CompanyInfoDto({
    @JsonKey(name: 'Symbol') String? symbol,
    @JsonKey(name: 'Description') String? description,
    @JsonKey(name: 'Name') String? name,
    @JsonKey(name: 'Country') String? country,
    @JsonKey(name: 'Industry') String? industry,
  }) = __CompanyInfoDto;

  factory CompanyInfoDto.fromJson(Map<String, Object?> json) =>
      _$CompanyInfoDtoFromJson(json);
}
