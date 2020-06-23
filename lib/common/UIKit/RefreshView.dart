import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'dart:async';

class RefreshViewController {
  RefreshViewState _state;

  // 绑定状态
  void bindState(RefreshViewState state) {
    _state = state;
  }

  /// 触发刷新
  void callRefresh() {
    _state.controller.resetRefreshState();
    _state.controller.resetLoadState();
    _state.controller.callRefresh();
  }

  /// 触发加载
  void callLoad() {
    _state.controller.callLoad();
  }

  /// 完成刷新
  void finishRefresh({bool success, bool noMore}) {
    ///下拉不允许显示noMore
    _state.controller.finishRefresh(success: success, noMore: false);
    _state.controller.resetLoadState();
    _state.controller.finishLoad(success: success, noMore: noMore);
    if (!_state.isRefresh) return;
    if (_state.refreshCompleter == null) return;
    _state.refreshCompleter.complete(true);
  }

  /// 完成加载
  void finishLoad({bool success, bool noMore}) {
    _state.controller.finishLoad(success: success, noMore: noMore);
    if (_state.isRefresh) return;
    if (_state.loadCompleter == null) return;
    _state.loadCompleter.complete(true);
  }

  /// 通用完成加载
  void finish({bool success, bool noMore}) {
    finishRefresh(success: success, noMore: noMore);
    finishLoad(success: success, noMore: noMore);
  }

  /// 恢复刷新状态(用于没有更多后)
  void resetRefreshState() {
    _state.controller.resetRefreshState();
  }

  /// 恢复加载状态(用于没有更多后)
  void resetLoadState() {
    _state.controller.resetLoadState();
  }
}

class RefreshView extends StatefulWidget {
  const RefreshView({
    Key key,

    ///scrollview列表
    @required this.scrollView,

    /// 刷新回调(null为不开启刷新)
    @required this.onRefresh,

    /// 加载回调(null为不开启加载)
    @required this.onLoad,

    /// 元数据长度，控制空视图
    @required this.count,

    /// 控制器
    @required this.controller,
  }) : super(key: key);
  final Widget scrollView;
  final Function onRefresh;
  final Function onLoad;
  final int count;
  final RefreshViewController controller;

  @override
  State<StatefulWidget> createState() {
    RefreshViewState state = new RefreshViewState();
    controller.bindState(state);
    return state;
  }
}

class RefreshViewState extends State<RefreshView> {
  EasyRefreshController controller = EasyRefreshController();
  Completer refreshCompleter;
  Completer loadCompleter;
  bool isRefresh;

  void initState() {
    super.initState();
  }

  GlobalKey<ClassicalFooterWidgetState> footKey = GlobalKey(debugLabel: 'foot');

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      controller: controller,
      child: widget.scrollView,
      onRefresh: () async {
        isRefresh = true;
        widget.onRefresh();
        refreshCompleter = new Completer();
        return refreshCompleter.future;
      },
      onLoad: widget.count == 0
          ? null
          : () {
              if (widget.count == 0) {
                controller.finishLoad(success: true, noMore: true);
                return null;
              }
              isRefresh = false;
              widget.onLoad();
              loadCompleter = new Completer();
              return loadCompleter.future;
            },
      taskIndependence: true,
      enableControlFinishRefresh: true,
      enableControlFinishLoad: true,
      firstRefresh: true,
      header: ClassicalHeader(
        enableInfiniteRefresh: false,
        infoColor: Colors.black87,
        refreshText: '下拉刷新',
        refreshReadyText: '松开立刻刷新',
        refreshingText: '正在刷新...',
        refreshedText: '刷新完成',
        refreshFailedText: '刷新失败',
        noMoreText: '没有更多了',
        showInfo: false,
      ),
      footer: ClassicalFooter(
        key: footKey,
        loadText: '上拉加载',
        loadReadyText: '松开加载',
        loadingText: '正在加载...',
        loadedText: '加载完成',
        loadFailedText: '加载失败',
        noMoreText: '没有更多数据',
        showInfo: false,
      ),
      emptyWidget: widget.count == 0
          ? Container(
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: SizedBox(),
                    flex: 2,
                  ),
                  SizedBox(
                    width: 189 / 2,
                    height: 219 / 2,
                    child: Image.asset('imgs/nav/empty.png'),
                  ),
                  Text(
                    '没有数据',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey[400]),
                  ),
                  Expanded(
                    child: SizedBox(),
                    flex: 3,
                  ),
                ],
              ),
            )
          : null,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
