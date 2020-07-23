import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import '../../model/AnswerModel.dart';

class ZaiXianKaoShiPage extends StatefulWidget {
  ZaiXianKaoShiPage({
    Key key,
    this.arguments, //任务id
  }) : super();
  Map arguments;

  @override
  State<StatefulWidget> createState() {
    return new ZaiXianKaoShiState();
  }
}

class ZaiXianKaoShiState extends State<ZaiXianKaoShiPage> {
  Map _paper = {};
  List _contents = [];
  String _title = '';
  int _index = 0;
  int _bigIndex = 0;
  int _amount = 0;

  void initState() {
    super.initState();

    _paper = widget.arguments['paper'];
    _contents = widget.arguments['contents'];
    _title = widget.arguments['title'];
  }

  void submit() async {
    await DialogUtil.dialogConfim('确认提交？');
    List ansList = [];
    for (int i = 0; i < _contents.length; i++) {
      Map item = _contents[i];
      ansList = [...ansList, ...item['answers']];
    }
    print(_paper['configs']);
    int SINGLE_score = _paper['configs']['SINGLE']['score'];
    int MULTI_score = _paper['configs']['MULTI']['score'];
    int TOF_score = _paper['configs']['TOF']['score'];
    int score = 0;
    ansList.forEach((element) {
      if (element['isCorrect'] == true) {
        if (element['type'] == 'SINGLE') {
          score += SINGLE_score;
        }
        if (element['type'] == 'MULTI') {
          score += MULTI_score;
        }
        if (element['type'] == 'TOF') {
          score += TOF_score;
        }
      }
    });
    print(score);
    var res = await HttpUtil.post('/process/online/test/${_paper['id']}', params: {'score': score, 'answers': ansList});
    res['id'] = widget.arguments['id'];
    res['isAdmin'] = false;
    PageUtil.pushAndReplace('xianshangAnswer', arguments: res);
//    PageUtil.popToName(widget.arguments['page']);
    EventBusUtil.getInstance().fire(PageEvent(name: 'xianshangPage',data: res));
  }

  @override
  Widget build(BuildContext context) {
    Widget btn = Button(
      child: Text(
        '交卷',
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
      onPressed: () {
        submit();
      },
    );
    String type = _contents[_bigIndex]['type'];
    _amount = _paper['configs'][type]['amount'];
    String bigTitle = '';
    if (type == 'SINGLE') {
      bigTitle = '单选题';
    }
    if (type == 'MULTI') {
      bigTitle = '多选题';
    }
    if (type == 'TOF') {
      bigTitle = '判断题';
    }

    Widget itemView;
    String itemType = _contents[_bigIndex]['content'][_index]['question']['type'];
    if (itemType == 'SINGLE') {
      itemView = WorkTestRadio(
//          key: new GlobalKey(),
          model: _contents[_bigIndex]['content'][_index],
          answer: _contents[_bigIndex]['answers'][_index],
          index: _index,
          onChange: (value) {
            Map ans = _contents[_bigIndex]['answers'][_index];
            ans['reply'] = value;
            ans['isCorrect'] = ans['reply'] == _contents[_bigIndex]['content'][_index]['question']['answer'];
            print(_contents[_bigIndex]['answers'][_index]);
          });
    } else if (itemType == 'MULTI') {
      itemView = WorkTestRadioMore(
//          key: new GlobalKey(),
          model: _contents[_bigIndex]['content'][_index],
          answer: _contents[_bigIndex]['answers'][_index],
          index: _index,
          onChange: (value) {
            print(value);
            Map ans = _contents[_bigIndex]['answers'][_index];
            ans['reply'] = value;
            ans['isCorrect'] = ans['reply'] == _contents[_bigIndex]['content'][_index]['question']['answer'];
            print(_contents[_bigIndex]['answers'][_index]);
          });
    } else if (itemType == 'TOF') {
      itemView = WorkTestRadioTof(
//          key: new GlobalKey(),
          model: _contents[_bigIndex]['content'][_index],
          answer: _contents[_bigIndex]['answers'][_index],
          index: _index,
          onChange: (value) {
            print(value);
            Map ans = _contents[_bigIndex]['answers'][_index];
            ans['reply'] = value;
            ans['isCorrect'] = ans['reply'] == _contents[_bigIndex]['content'][_index]['question']['answer'];
            print(_contents[_bigIndex]['answers'][_index]);
          });
    } else {
      itemView = Container();
    }
    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, _title, actions: [btn]),
      body: Column(
        children: <Widget>[
          Expanded(
            child: new ListView(
              physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
              children: <Widget>[
                topView(context),
                WorkTitle(
                  title: '${_bigIndex + 1}、${bigTitle}:${_index + 1}/${_amount} 每题分值：${_paper['configs'][type]['score']}分',
                ),
                itemView,
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30 * ScaleWidth, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                WorkTestLastBtn(
                  onClick: () {
                    if (_index == 0) {
                      if (_bigIndex == 0) {
                        ///第一题
                        return;
                      }
                      setState(() {
                        _bigIndex -= 1;
                        String type = _contents[_bigIndex]['type'];
                        int amount = _paper['configs'][type]['amount'];
                        _index = amount - 1;
                      });
                    } else {
                      setState(() {
                        _index -= 1;
                      });
                    }
                  },
                ),
                WorkTestNextBtn(
                  margin: EdgeInsets.only(left: 56 * ScaleWidth),
                  onClick: () {
                    if (_index + 1 == _amount && _bigIndex + 1 == _contents.length) {
                      ///没有题了
                      submit();
                    } else {
                      setState(() {
                        _index += 1;
                        if (_index >= _amount) {
                          _index = 0;
                          _bigIndex += 1;
                        }
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget multi() {}

  Widget tof() {}

  Widget topView(BuildContext context) {
    return Container(
      height: 80 * ScaleWidth,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          SubTextLabel(
            '总题数:',
            margin: EdgeInsets.only(left: 40 * ScaleWidth),
          ),
          SubTextLabel(_paper['totalQustions'].toString()),
          SubTextLabel(
            '满分:',
            margin: EdgeInsets.only(left: 40 * ScaleWidth),
          ),
          SubTextLabel(
            _paper['totalScore'].toString(),
            textColor: MainBlueColor,
          ),
          SubTextLabel(
            '及格分数:',
            margin: EdgeInsets.only(left: 40 * ScaleWidth),
          ),
          SubTextLabel(
            _paper['passScore'].toString(),
            textColor: SuccessColor,
          ),
          SubTextLabel(
            '答题时间:',
            margin: EdgeInsets.only(left: 40 * ScaleWidth),
          ),
          SubTextLabel(_paper['duration'].toString() + '分钟'),
        ],
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
