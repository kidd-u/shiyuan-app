import 'package:flutter/material.dart';
import 'package:shiyuan/states/LogUtil.dart';
import 'package:shiyuan/states/default.dart';

class WorkChooseStoreUtil {
  static List allData;

  Future getAllData() async {
    Completer completer = new Completer();
    try {
      var res = await HttpUtil.get('/depart/');

      for (int i = 0; i < res.length; i++) {
        var res1 = await HttpUtil.get('/account/depart/eager/${res[i]['id']}');
        res[i]['children'] = res1;
      }
      WorkChooseStoreUtil.allData = res;
      completer.complete(true);
    } catch (err) {
      completer.completeError(err);
    }
    return completer.future;
  }
}

class WorkChooseStorePage extends StatefulWidget {
  WorkChooseStorePage({
    Key key,
    this.arguments,
  }) : super();
  Map arguments;

  @override
  State<StatefulWidget> createState() {
    return new WorkChooseStoreState();
  }
}

class WorkChooseStoreState extends State<WorkChooseStorePage> {
  List _dataList = [];
  String _page = ''; //YinhuanAdd
  bool _isPeople = false;
  bool _isSelectStore = false;
  String _value = '';

  void initState() {
    super.initState();
    setState(() {
      LogUtil.d(Filter.toJson(widget.arguments));
      _dataList = widget.arguments.containsKey('dataList') ? widget.arguments['dataList'] : WorkChooseStoreUtil.allData;
      _page = widget.arguments['page'];
      _isPeople = widget.arguments['isPeople'] ?? false;
//      _value = widget.arguments['value'] ?? '';
      print(WorkChooseStoreUtil.allData);
      print(_dataList);
      print('返回的路径${_page}');
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [];
    if (!_isPeople) {
      Widget btn = Button(
        child: Text(
          '选择',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        onPressed: () {
          setState(() {
            _isSelectStore = !_isSelectStore;
          });
        },
      );
      actions.add(btn);
    }

    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '选择部门', actions: [...actions]),
      body: new ListView.builder(
        padding: EdgeInsets.only(bottom: 40),
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  color: Colors.white,
                  height: 140 * ScaleWidth,
                  padding: EdgeInsets.only(left: 60 * ScaleWidth, right: 65 * ScaleWidth),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: MainTitleLabel(_dataList[index]['name']),
                      ),
                      _isPeople == true//选择人
                          ? (_dataList[index] as Map).containsKey('children')
                              //有children显示箭头
                              ? _isSelectStore
                                  //选择部门模式可以直接选择大的部门
                                  ? ImageView(
                                      src: _value == _dataList[index]['name'] ? 'imgs/mine/select_se.png' : 'imgs/mine/select_de.png',
                                      width: 38 * ScaleWidth,
                                      height: 38 * ScaleWidth)
                                  : ImageView(src: 'imgs/mine/right_icon.png', width: 12 * ScaleWidth, height: 23 * ScaleWidth)
                              //没有children显示圈⭕
                              : ImageView(src: 'imgs/mine/select_de.png', width: 38 * ScaleWidth, height: 38 * ScaleWidth)
                          : (_dataList[index] as Map).containsKey('children') && _dataList[index]['children'].length > 0//选择部门
                              //有children显示箭头
                              ? _isSelectStore
                                  //选择部门模式可以直接选择大的部门
                                  ? ImageView(
                                      src: _value == _dataList[index]['name'] ? 'imgs/mine/select_se.png' : 'imgs/mine/select_de.png',
                                      width: 38 * ScaleWidth,
                                      height: 38 * ScaleWidth)
                                  : ImageView(src: 'imgs/mine/right_icon.png', width: 12 * ScaleWidth, height: 23 * ScaleWidth)
                              //没有children显示圈⭕
                              : ImageView(src: 'imgs/mine/select_de.png', width: 38 * ScaleWidth, height: 38 * ScaleWidth),
                    ],
                  ),
                ),
                onTap: () {
                  //有children，继续选择
                  if ((_dataList[index] as Map).containsKey('children')) {
                    //选择部门模式，直接返回部门
                    if (_isSelectStore) {
                      var res = _dataList[index];
                      setState(() {
                        _value = res['name'];
                      });
                      EventBusUtil.getInstance().fire(PageEvent(name: 'WorkChoose',data: res));
                      PageUtil.popToName(_page);
                    } else {
                      //正常情况下，继续跳转
                      var children = _dataList[index]['children'];
                      if (children is Map) {
                        if (_isPeople) {
                          children = [...children['staffs'], ...children['children']];
                        } else {
                          children = children['children'];
                        }
                      }
                      if ((_dataList[index] as Map).containsKey('staffs')) {
                        if (_isPeople) {
                          children = [..._dataList[index]['staffs'], ...children];
                        } else {
                          children = children;
                        }
                      }
                      if (children.length > 0) {
                        PageUtil.push('WorkChooseStore', arguments: {'isPeople': _isPeople, 'dataList': children, 'page': _page});
                      } else {
                        if (_isPeople) {
                          DialogUtil.toastError('该部门下没有可执行人员');
                          return;
                        }
                        var res = _dataList[index];
                        EventBusUtil.getInstance().fire(PageEvent(name: 'WorkChoose',data: res));
                        PageUtil.popToName(_page);
                      }
                    }
                  } else {
                    //已经没有children
                    var res = _dataList[index];
                    setState(() {
                      _value = res['name'];
                    });
                    EventBusUtil.getInstance().fire(PageEvent(name: 'WorkChoose',data: res));
                    PageUtil.popToName(_page);
                  }
                },
              ),
              LineView(),
            ],
          );
        },
        itemCount: _dataList.length,
      ),
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
