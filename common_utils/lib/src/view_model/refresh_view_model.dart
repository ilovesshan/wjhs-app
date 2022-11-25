import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../view/view_state.dart';
import 'base_view_model.dart';

abstract class RefreshViewMode<T> with ChangeNotifier, BaseViewModel {
  late ViewState viewState = ViewState.LOADING;
  bool _disposed = false;

  /// 刷新控制器
  late final EasyRefreshController _controller = EasyRefreshController();

  EasyRefreshController get refreshController => _controller;

  /// 页面数据
  late List<T> list = [];

  /// 默认页码
  late final int _defaultPageNum = 1;
  late int _currentPageNum = _defaultPageNum;

  /// 默认一次加载的条数
  late final int _defaultPageSize = 10;

  /// 子类需要实现的 抽象方法
  Future<List<T>> loadData({int pageNum});

  /// 初始化数据
  void initData() {
    _setViewState(ViewState.LOADING);
    _refresh(isFirstLoad: true);
  }

  /// 加载失败 重新尝试
  @override
  void retry() {
    _setViewState(ViewState.LOADING);
    _refresh(isFirstLoad: false);
  }

  /// 更新 view状态
  void _setViewState(ViewState state) {
    viewState = state;
    notifyListeners();
  }

  /// 第一次加载
  void _refresh({bool isFirstLoad = false}) async {
    try {
      List<T> data = await loadData();
      if (data.isEmpty) {
        list.clear();
        _setViewState(ViewState.EEMPTY);
      } else {
        _setViewState(ViewState.SUCCESS);
        list.clear();
        list.addAll(data);
      }
    } catch (e) {
      printLog(StackTrace.current, "***************************捕获到异常***************************");
      printLog(StackTrace.current,e.toString());
      printLog(StackTrace.current, "***************************捕获到异常***************************");
      if (e is DioError) {
        EasyLoading.showToast("请求失败: ${e.message.toString()}");
      } else {
        // EasyLoading.showToast(e.toString());
      }
      if (isFirstLoad) {}
      _setViewState(ViewState.ERROR);
    }
  }

  /// 下拉刷新
  Future<void> pullRefresh() async {
    try {
      _controller.resetLoadState();
      _currentPageNum = _defaultPageNum;
      List<T> data = await loadData();
      if (data.isEmpty) {
        list.clear();
        _controller.finishRefresh(success: true);
      } else {
        if (data.length < _defaultPageSize) {
          // 没有更多了...
          _controller.finishLoad(success: true, noMore: true);
        } else {
          _controller.finishLoad(success: true);
        }
        list.clear();
        list.addAll(data);
      }
      notifyListeners();
    } catch (e) {
      printLog(StackTrace.current, "***************************捕获到异常***************************");
      printLog(StackTrace.current,e.toString());
      printLog(StackTrace.current, "***************************捕获到异常***************************");
      if (e is DioError) {
        EasyLoading.showToast("请求失败: ${e.message.toString()}");
      } else {
        // EasyLoading.showToast(e.toString());
      }
      // _setViewState(ViewState.ERROR);
      _controller.finishRefresh(success: false);
    }
  }

  /// 上拉加载更多
  Future<void> loadMore() async {
    try {
      List<T> data = await loadData(pageNum: ++_currentPageNum);
      if (data.isEmpty) {
        _currentPageNum--;
        _controller.finishLoad(success: true, noMore: true);
      } else {
        if (data.length < _defaultPageSize) {
          // 没有更多了...
          _controller.finishLoad(success: true, noMore: true);
        } else {
          _controller.finishLoad(success: true);
        }
        list.addAll(data);
      }
      notifyListeners();
    } catch (e) {
      printLog(StackTrace.current, "***************************捕获到异常***************************");
      printLog(StackTrace.current,e.toString());
      printLog(StackTrace.current, "***************************捕获到异常***************************");
      if (e is DioError) {
        EasyLoading.showToast("请求失败: ${e.message.toString()}");
      } else {
        // EasyLoading.showToast(e.toString());
      }
      _currentPageNum--;
      _controller.finishLoad(success: false);
      // _setViewState(ViewState.ERROR);
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
    _controller.dispose();
    _disposed = true;
    super.dispose();
  }
}
