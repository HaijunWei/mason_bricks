import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

mixin RefreshMixin<T> on Cubit<T> {
  final _refreshController = IndicatorController();
  IndicatorController get refreshController => _refreshController;
}

mixin PagingMixin<T, ItemType> on Cubit<T> {
  int _page = 1;
  int _nextPage = 1;
  int get nextPage => _nextPage;
  bool _initialized = false;

  final _pagingController = PagingController<int, ItemType>(firstPageKey: 1);
  PagingController<int, ItemType> get pagingController {
    if (!_initialized) {
      _initialized = true;
      _pagingController.addPageRequestListener(_pageListener);
    }
    return _pagingController;
  }

  final _refreshController = IndicatorController();
  IndicatorController get refreshController => _refreshController;

  void _pageListener(int page) {
    loadData(isLoadMore: page != 1);
  }

  void beginLoad(bool isLoadMore) {
    _nextPage = isLoadMore ? _page + 1 : 1;
    if (isLoadMore) {
      _refreshController.disableRefresh();
    } else {
      _pagingController.refresh();
    }
  }

  void endLoad({
    required bool isSuccess,
    List<ItemType>? data,
    dynamic error,
    bool? noMore,
  }) {
    if (isSuccess) {
      bool pNoMore = noMore ?? data!.isEmpty;
      if (_nextPage > _page) {
        if (pNoMore) {
          _pagingController.appendLastPage(data!);
        } else {
          _pagingController.appendPage(data!, _nextPage);
        }
      } else {
        _pagingController.appendFirstPage(
          data!,
          pNoMore ? null : _nextPage + 1,
        );
      }
    } else {
      _pagingController.error = error;
    }
    _refreshController.enableRefresh();
    _page = nextPage;
  }

  @override
  Future<void> close() {
    _pagingController.dispose();
    _refreshController.dispose();
    return super.close();
  }

  Future<void> loadData({bool isLoadMore = false});
}
