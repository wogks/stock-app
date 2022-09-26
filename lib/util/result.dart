//데이타를 담거나 에러처리를 담아놓은 곳 자유롭게 작성
import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
abstract class Result<T> with _$Result<T> {
  const factory Result.success(T data) = Success;
  const factory Result.error(Exception e) = Error;
}