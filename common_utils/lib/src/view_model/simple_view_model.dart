import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../view/view_state.dart';
import 'base_view_model.dart';

abstract class SimpleViewMode<T> with ChangeNotifier, BaseViewModel {
  late ViewState viewState = ViewState.LOADING;
  late T mode;
  bool _disposed = false;

  Future<T> loadData();

  void initData() {
    _setViewState(ViewState.LOADING);
    _refresh(isFirstLoad: true);
  }

  @override
  void retry() {
    _setViewState(ViewState.LOADING);
    _refresh(isFirstLoad: false);
  }

  void _setViewState(ViewState state) {
    viewState = state;
    notifyListeners();
  }

  void _refresh({bool isFirstLoad = false}) async {
    try {
      T data = await loadData();
      if (data is List) {
        if (data.length == 0) {
          _setViewState(ViewState.EEMPTY);
        } else {
          _setViewState(ViewState.SUCCESS);
          mode = data;
        }
      } else {
        if (data == null) {
          _setViewState(ViewState.EEMPTY);
        } else {
          _setViewState(ViewState.SUCCESS);
          mode = data;
        }
      }
    } catch (e) {
      printLog(StackTrace.current, "***************************捕获到异常***************************");
      printLog(StackTrace.current,e.toString());
      printLog(StackTrace.current, "***************************捕获到异常***************************");
      if (e is DioError) {
        switch (e.response?.statusCode) {
          case 500:
            EasyLoading.showToast(e.response!.data["message"].toString());
            break;
          default:
            EasyLoading.showToast("请求失败: ${e.message.toString()}");
        }
      } else {
        EasyLoading.showToast(e.toString());
      }
      if (isFirstLoad) {}
      _setViewState(ViewState.ERROR);
    }
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
