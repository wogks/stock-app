import 'package:flutter/material.dart';
import 'package:stock_app/domain/repository/stock_repository.dart';
import 'package:stock_app/presentation/company_info/company_info_state.dart';

class CompanyInfoViewModel with ChangeNotifier {
  final StockRepository _repository;
  var _state = const CompanyInfoState();

  CompanyInfoState get state => _state;

  CompanyInfoViewModel(this._repository, String symbol) {
    //첫번쨰 화면에서 두번쨰화면으로 넘어갈때 symbol을 넘기기위해 인자값 작성
loadCompanyInfo(symbol);
  }

  Future<void> loadCompanyInfo(String symbol) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _repository.getCompanyInfo(symbol);
    result.when(
      success: (info) {
        _state = state.copyWith(
          companyInfo: info,
          isLoading: false,
          errorMessage: null,
        );
      },
      error: (e) {
        _state = state.copyWith(
          companyInfo: null,
          isLoading: false,
          errorMessage: e.toString(),
        );
      },
    );

    notifyListeners();
  }
}
