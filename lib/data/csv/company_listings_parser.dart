import 'package:csv/csv.dart';
import 'package:stock_app/data/csv/csv_parser.dart';
import 'package:stock_app/domain/model/company_listing.dart';

class CompanyListingsParser implements CsvParser<CompanyListing> {
  @override
  Future<List<CompanyListing>> parse(String csvString) async {
    //csv의 값들
    List<List<dynamic>> csvValues =
        const CsvToListConverter().convert(csvString);

    //첫번째줄 날림(제목같은것듯)
    csvValues.removeAt(0);

    return csvValues.map((e){
      final symbol = e[0] ?? '';
      final name = e[1] ?? '';
      final exchange = e[2] ?? '';
      return CompanyListing(symbol: symbol, name: name, exchange: exchange);
    }).toList();
  }
}
