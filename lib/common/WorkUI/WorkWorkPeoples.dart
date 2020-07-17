import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/WorkEmpty.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/UIKit/SelectImage.dart';

class WorkWorkPeoples extends StatefulWidget {
  const WorkWorkPeoples({
    Key key,
    this.margin,
    this.color = BackgroundColor,
    @required this.value,
    @required this.onChange,
    this.enable = true,
    this.must = false,
    this.showBorder = true,
    this.paddingTop = 0,
  }) : super(key: key);
  final EdgeInsets margin;
  final Color color;
  final Function onChange; //
  final List value;
  final bool enable; //禁用，false为禁用
  final bool showBorder; //是否显示边框
  final double paddingTop;
  final bool must;

  @override
  State<StatefulWidget> createState() {
    return new WorkWorkPeoplesState();
  }
}

class WorkWorkPeoplesState extends State<WorkWorkPeoples> {
  List _value;

  void initState() {
    super.initState();
    setState(() {
      _value = widget.value.length > 0
          ? widget.value
          : [
              {'fileName': '', 'id': '', 'url': ''},
            ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return Container(
      color: widget.color,
      margin: widget.margin,
//      height: 136 * ScaleWidth,
      padding: EdgeInsets.only(bottom: 22 * ScaleWidth, top: widget.paddingTop),
      child: Column(
        children: <Widget>[
          WorkEmpty(
            color: BackgroundColor,
            showTopLine: false,
            showBottomLine: false,
            leftActions: [
              ...widget.must ? [MainTitleLabel('*', textColor: WarningColor)] : [],
              MainTitleLabel('动火人信息：')
            ],
            rightActions: [
              ...widget.enable
                  ? [
                      TextButton(
                        '新增',
                        textColor: Colors.white,
                        fontSize: 24 * ScaleWidth,
                        width: 130 * ScaleWidth,
                        height: 50 * ScaleWidth,
                        decoration: new BoxDecoration(
                          color: NormalColor,
                          borderRadius: BorderRadius.all(Radius.circular(5 * ScaleWidth)),
                        ),
                        onPressed: () {
                          setState(() {
                            _value.add({'fileName': '', 'id': '', 'url': ''});
                          });
                        },
                      )
                    ]
                  : []
            ],
          ),
          ...views(),
        ],
      ),
    );
  }

  List<Widget> views() {
    List<Widget> views = [];
    for (int i = 0; i < _value.length; i++) {
      Map item = _value[i];
      views.addAll(items(i));
    }
    return views;
  }

  List<Widget> items(int index) {

    return [
      WorkTitleWithDelete(
        title: '动火人信息${index + 1}',
        enbale: widget.enable,
        onDelete: () async {
          print('=====');
          await DialogUtil.dialogConfim('确认删除动火人信息?');
          setState(() {
            _value.removeAt(index);
          });
        },
      ),
      WorkInput(
          title: '动火人：',
          value: _value[index]['fileName'],
          placehoder: '请输入动火人',
          enable: widget.enable,
          onChange: (text) {
            _value[index]['fileName'] = text;
            widget.onChange(_value);
          }),
      WorkInput(
          title: '特殊作业证件号：',
          value: _value[index]['id'],
          placehoder: '请输入证件号',
          enable: widget.enable,
          onChange: (text) {
            _value[index]['id'] = text;
            widget.onChange(_value);
          }),
      WorkSelect(title: '证书上传：', value: ''),
      Container(
          width: ScreenWidth,
          color: Colors.white,
          child: Row(
            children: <Widget>[
              SelectImage(
                width: 136 * ScaleWidth,
                heidht: 136 * ScaleWidth,
                margin: EdgeInsets.only(left: 30 * ScaleWidth, top: 20 * ScaleWidth, bottom: 20 * ScaleWidth),
                enabled: widget.enable,
                src: _value[index]['url'],
                onChange: (value) {
                  setState(() {
                    _value[index]['url'] = value;
                  });
                  widget.onChange(_value);
                },
              ),
            ],
          ))
    ];
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
