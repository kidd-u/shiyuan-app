import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/WorkUI/work.dart';

enum SpecialType {
  normal, //正常
  loading, //即将过期
  error, //已过期
}

class SpecialPeoplegController {
  SpecialPeoplePageState _state;

  void bindState(SpecialPeoplePageState state) {
    _state = state;
  }

  void search(String kerword) {
    _state.search(kerword);
  }
}

class SpecialPeoplePage extends StatefulWidget {
  const SpecialPeoplePage({
    Key key,
    this.status,
    this.controller,
  }) : super(key: key);
  final String status;
  final SpecialPeoplegController controller;

  @override
  State<StatefulWidget> createState() {
    SpecialPeoplePageState state = new SpecialPeoplePageState();
    if (controller != null) {
      controller.bindState(state);
    }
    return state;
  }
}

class SpecialPeoplePageState extends State<SpecialPeoplePage> {
  String _keyword = '';
  List _content = [];
  int _pageIndex = 0;
  RefreshViewController refreshViewController = new RefreshViewController();

  void initState() {
    super.initState();
  }

  void search(String kerword) {
    _keyword = kerword;
    refreshViewController.callRefresh();
  }

  void onRefresh() async {
    _pageIndex = 0;
    _content = [];
    loadDataByPage(_pageIndex);
  }

  void onLoad() async {
    loadDataByPage(_pageIndex + 1);
  }

  void loadDataByPage(int page) async {
    var url=widget.status==''?'/extedu/summary':'/extedu/summary/expired';
    try {
      var res = await HttpUtil.get(
        url,
        params: {'keyword': _keyword, 'page': page, 'size': 15, 'sort': 'id'},
      );
      List content = res['content'];
      setState(() {
        _content = [..._content, ...content];
        if (content.length > 0) {
          _pageIndex = page;
        }
      });
      refreshViewController.finish(success: true, noMore: _content.length < 15);
    } catch (err) {
      refreshViewController.finish(success: false, noMore: page != 0);
      print(err);
    }
  }
  didSelectCellForRow(Map item){
    PageUtil.push('specialPeopleDetail',arguments: item);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: BackgroundColor,
      child: RefreshView(
        scrollView: listView(),
        onRefresh: () => onRefresh(),
        onLoad: () => onLoad(),
        count: _content.length,
        controller: refreshViewController,
      ),
    );
  }

  Widget listView() {
    return ListView.builder(
        padding: EdgeInsets.all(30 * ScaleWidth),
        itemCount: _content.length,
        itemBuilder: (BuildContext context, int index) {
          return itemCell(_content[index]);
        });
  }

  Widget itemCell(Map item) {
    SpecialType type;
    int time = item['status'];
    String name, userName, groupName, timeRange;
    if (time < 0) {
      type = SpecialType.error;
    } else if (time < 90) {
      type = SpecialType.loading;
    } else {
      type = SpecialType.normal;
    }
    name = item['name'];
    userName = item['account']['name'];
    groupName = item['depart']['name'];
    timeRange = item['validDate'];

    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 30 * ScaleWidth),
        height: 300 * ScaleWidth,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5 * ScaleWidth)),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                bottom: 0,
                width: 14 * ScaleWidth,
                child: Container(
                  color: type == SpecialType.normal ? SuccessColor : type == SpecialType.loading ? LoadingColor : ErrorColor,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                bottom: 0,
                left: 14 * ScaleWidth,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      WorkEmpty(
                        showTopLine: false,
                        showBottomLine: false,
                        leftActions: [MainTitleLabel(name)],
                        rightActions: [
                          type == SpecialType.normal
                              ? SubTextLabel(
                                  '距离证书过期还有${time}天',
                                  textColor: SuccessColor,
                                )
                              : type == SpecialType.loading
                                  ? SubTextLabel(
                                      '距离证书过期还有${time}天',
                                      textColor: LoadingColor,
                                    )
                                  : SubTextLabel(
                                      '已过期',
                                      textColor: ErrorColor,
                                    ),
                        ],
                      ),
                      LineView(margin: EdgeInsets.only(left: 6 * ScaleWidth, right: 18 * ScaleWidth)),
                      MainTextLabel('持有者：${userName}',
                          textColor: Color(0xFF7D7D7D), margin: EdgeInsets.only(top: 22 * ScaleWidth, left: 22 * ScaleWidth, right: 22 * ScaleWidth)),
                      MainTextLabel('所属部门/单位：${groupName}',
                          textColor: Color(0xFF7D7D7D), margin: EdgeInsets.only(top: 22 * ScaleWidth, left: 22 * ScaleWidth, right: 22 * ScaleWidth)),
                      MainTextLabel('证书有效期：${timeRange}',
                          textColor: Color(0xFF7D7D7D), margin: EdgeInsets.only(top: 22 * ScaleWidth, left: 22 * ScaleWidth, right: 22 * ScaleWidth)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        didSelectCellForRow(item);
      },
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
