//getlistings 파서 관련된 부분 작성

abstract class CsvParser<T> {
  Future<List<T>> parse(String csvString);
}