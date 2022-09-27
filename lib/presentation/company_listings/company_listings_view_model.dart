//뷰모델은 상태를 가지고있고 상태를 각 화면 ui에 전달해주는 역할
//필요한 상태들 : 땡기면 리프레시 중인지 아닌지, 텍스트필드(쿼리), 메뉴 로딩중인지 아닌지
//상태가 많아지면 관리가 어려워지니 state클라스 따로 생성
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stock_app/domain/repository/stock_repository.dart';
import 'package:stock_app/presentation/company_listings/company_listings_action.dart';
import 'package:stock_app/presentation/company_listings/company_listings_state.dart';
import 'package:stock_app/util/result.dart';

class CompanyListingsViewModel with ChangeNotifier {
  final StockRepository _repository;

  var _state = CompanyListingsState(); // 계속 변해야되기 떄문에 var를 사용

  Timer? _debounce;

  CompanyListingsState get state =>
      _state; //외부에서 가져올수 있게 getter사용 프리즈드로 만들어서 외부에서 수정 불가

  //화면 시작하자마자 데이터를 다 로드하니까 생성자에서 모든 데이터를 로드해버린다
  CompanyListingsViewModel(this._repository) {
    _getCompanyListings();
  }

  void onAction(CompanyListingsAction action) {
    //사용자가 행하는 액션들을 모아놓음
    action.when(
        refresh: () => _getCompanyListings(fetchFromRemote: true),
        onSearchQueryChange: (query) {
          _debounce?.cancel();
          _debounce = Timer(const Duration(microseconds: 500), () {
            _getCompanyListings(query: query);
          });
        });
  }

  Future _getCompanyListings({
    //밑에 인자2개를 받게끔 했으니까 디폴트값 설정
    bool fetchFromRemote = false,
    String query = '',
  }) async {
    //프리즈드에서 제공하는 copywith로 불변객체를 복사해서 바꿔치지 한다
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();

    //중간에 실제데이터를 가져오는 코드 작성
    final result = await _repository.getCompanyListings(fetchFromRemote, query);
    result.when(
      success: (listings) {
        //성공일경우 데이터 교체
        _state = state.copyWith(
          companies: listings,
        );
      },
      error: (e) {
        //TODO : 에러처리
        print('리모트 에러 :' + e.toString());
      },
    );

    _state = state.copyWith(
      isLoading: false,
    );

    notifyListeners();
  }
}
