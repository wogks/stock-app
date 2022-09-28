import 'package:intl/intl.dart';
import 'package:stock_app/domain/model/intraday_info.dart';

import '../source/remote/dto/intraday_info_dto.dart';

//이 함수는 IntradayInfoDto에 추가를 할것이고 dto를 일반 모델클라스로 변환하는 코드
extension ToIntradayInfo on IntradayInfoDto {
  //IntradayInfo로 변환
  IntradayInfo toIntradayInfo () {
    //2022-09-27 20:00:00 이걸 데이트 타임으로 변환 할건데 intl라이브러리 설치 필요
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return IntradayInfo(date: formatter.parse(timestamp), close: close);
  }
}