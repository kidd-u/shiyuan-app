import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/WorkUI/work.dart';

///已完成
class XianXiaPeiXunPage extends StatefulWidget {
  XianXiaPeiXunPage({
    Key key,
    this.arguments, //任务id
  }) : super();
  Map arguments;

  @override
  State<StatefulWidget> createState() {
    return new Page();
  }
}

class Page extends State<XianXiaPeiXunPage> {
  List _dataAry = [];

  void initState() {
    super.initState();
    getDetail();
  }

  getDetail() async {
    var res = await HttpUtil.get('/process/common/detail/${widget.arguments['procId']}');
    setState(() {
      _dataAry = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: buildAppBar(context, '线上培训考试结果'),
      backgroundColor: BackgroundColor,
      body: new ListView.builder(
        padding: EdgeInsets.only(bottom: 40),
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: <Widget>[
                ..._dataAry.map((e) {
                  String name = e['name'];
                  String label = e['label'];
                  if (name == '是否需要考试' && label == '是') {
                    return WorkEmpty(
                      leftActions: [MainTitleLabel(name)],
                      rightActions: [
                        MainTextLabel(label),
                        MainTextLabel(
                          '(查看考试详情)',
                          textColor: MainDarkBlueColor,
                          onClick: () {
                            PageUtil.push('xianshangAnswer',arguments: widget.arguments);
                          },
                        ),
                      ],
                    );
                  }
                  return WorkSelect(title: name, value: label);
                }).toList(),
              ],
            );
          }
          return null;
//          return WorkTestRadio(model: null, index: null, onChange: null);
        },
        itemCount: 1,
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
