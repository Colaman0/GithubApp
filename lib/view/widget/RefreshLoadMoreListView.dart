import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github/view/widget/TextView.dart';

class RefreshLoadmoreListView extends StatefulWidget {
  final RLDataFactory _dataFactory;
  final RefreshLoadmoreOption _option;

  RefreshLoadmoreListView(this._dataFactory, this._option);

  @override
  _RefreshLoadmoreListViewState createState() => _RefreshLoadmoreListViewState(_dataFactory, _option);
}

class RefreshLoadmoreOption {
  final bool _canLoadMore;
  final bool _canRefresh;

  RefreshLoadmoreOption(this._canLoadMore, this._canRefresh);
}

class _RefreshLoadmoreListViewState extends State<RefreshLoadmoreListView> {
  final RLDataFactory _dataFactory;
  final RefreshLoadmoreOption _option;
  final PageHelper _pageHelper = new PageHelper();

  _RefreshLoadmoreListViewState(this._dataFactory, this._option);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        child: FutureBuilder<PageDTO>(
            future: _dataFactory.createFuture(_pageHelper.currentPage),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Center(
                      child: TextView('网络请求出错,点击重试').click(() => refresh()),
                    );
                  }
              }
              _pageHelper.injectData(snapshot.data);
              return ListView.builder(
                  itemCount: _pageHelper.datas.length + ((_option._canLoadMore && !_pageHelper.isLastPage()) ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (_option._canLoadMore) {
                      if (_pageHelper.isLastPage()) {
                        return _dataFactory.createItemWidget(context, index);
                      } else {
                        return _dataFactory.createLoadMoreItem(context, index);
                      }
                    }
                    return _dataFactory.createItemWidget(context, index);
                  });
            }),
      ),
    );
  }

  void refresh() {
    _pageHelper.reset();
  }
}

class PageHelper {
  List datas = List();

  int currentPage = 1;

  bool isLastPage;

  void reset() {
    datas.clear();
    currentPage = 1;
  }

  void injectData(PageDTO pageDTO) {
    datas.addAll(pageDTO.getDatas());
    isLastPage = pageDTO.isLastPage();
  }
}

abstract class RLDataFactory<T> {
  Future<PageDTO<T>> createFuture(int page);

  Widget createItemWidget(BuildContext context, int index);

  Widget createLoadMoreItem(BuildContext context, int index);
}

abstract class PageDTO<T> {
  List<T> getDatas();

  bool isLastPage();
}
