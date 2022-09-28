import 'package:csv/csv.dart';
import 'package:stock_app/data/csv/csv_parser.dart';
import 'package:stock_app/data/source/remote/dto/intraday_info_dto.dart';
import 'package:stock_app/domain/model/intraday_info.dart';

class IntradayInfoParser implements CsvParser<IntradayInfo> {
  @override
  Future<List<IntradayInfo>> parse(String csvString) {
    //csv의 값들
    List<List<dynamic>> csvValues =
        const CsvToListConverter().convert(csvString);

    //첫번째줄 날림(제목같은것듯)
    csvValues.removeAt(0);

    return csvValues.map((e) {
      final timestamp = e[0] ?? '';
      final close = e[4] ?? '';
      final dto = IntradayInfoDto(timeStamp: timeStamp, close: close);
    });
  }

}