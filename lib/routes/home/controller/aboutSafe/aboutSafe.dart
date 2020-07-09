import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/WorkEmpty.dart';
import 'package:shiyuan/common/WorkUI/WorkTitle.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import 'package:shiyuan/states/default.dart';

class AboutSafePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AboutSafeState();
  }
}

class AboutSafeState extends State<AboutSafePage> {
  Map _detail = {};
  List _safeEdu = [];
  List _safeCheck = [];
  List _safeLog = [];
  List<WorkImageUploadController> controllers=[
    WorkImageUploadController(),
    WorkImageUploadController(),
    WorkImageUploadController(),
  ];

  void initState() {
    super.initState();
    getForm();
  }

  getForm() async {
    Map res = await HttpUtil.get('/thirdparty/record/mine/detail');
    setState(() {
      _detail = res;
      _safeEdu = _detail.safe(['detail','EDU'])??[];
      _safeCheck = _detail.safe(['detail', 'CHECK']) ?? [];
      _safeLog = _detail.safe(['detail', 'LOG']) ?? [];
      controllers[0].resetValue(_safeEdu);
      controllers[1].resetValue(_safeCheck);
      controllers[2].resetValue(_safeLog);
    });
  }

  submit() async {
    print(_safeEdu);
    print(_safeCheck);
    print(_safeLog);
    if (_safeEdu.length == 0 || _safeCheck.length == 0 || _safeLog.length == 0) {
      DialogUtil.dialogAlert('您有必填项没有填写!');
      return;
    }
    await DialogUtil.dialogConfim('确认提交?');
    List images = [
      ..._safeEdu
          .map((e) => {
                'usage': 'EDU',
                'image': {'type': 'IMAGE', 'src': e['src'], 'description': e['description']}
              })
          .toList(),
      ..._safeCheck
          .map((e) => {
                'usage': 'CHECK',
                'image': {'type': 'IMAGE', 'src': e['src'], 'description': e['description']}
              })
          .toList(),
      ..._safeLog
          .map((e) => {
                'usage': 'LOG',
                'image': {'type': 'IMAGE', 'src': e['src'], 'description': e['description']}
              })
          .toList(),
    ];
    print(images);
    DialogUtil.showLoading();
    var res = await HttpUtil.put('/thirdparty/record/detail/${_detail['id']}', params: {'images': images});
    DialogUtil.toastSuccess('提交成功!');
    PageUtil.pop();
  }

  @override
  Widget build(BuildContext context) {
    Widget btn = Button(
      child: Text(
        '确定',
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
      onPressed: () => submit(),
    );

    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '相关方安全工作', actions: [btn]),
      body: new ListView(
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20 * ScaleWidth, bottom: 20 * ScaleWidth, left: 26 * ScaleWidth, right: 26 * ScaleWidth),
            //边框设置
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10 * ScaleWidth)),
            ),
            child: Column(
              children: <Widget>[
                WorkEmpty(
                  color: Colors.transparent,
                  showTopLine: false,
                  showBottomLine: false,
                  leftActions: [MainTitleLabel(UserInfo.userInfo.name)],
                  rightActions: [
                    MainTitleLabel(_detail.safe(['depart', 'name']) ?? '')
                  ],
                ),
              ],
            ),
          ),
          WorkSelect(title: '安全教育', color: Colors.transparent, must: true, placeholder: ''),
          WorkImageUpload(
            title: '本月安全教育记录:',
            value: _safeEdu,
            controller: controllers[0],
            onChange: (value) {
              _safeEdu = value;
            },
          ),
          WorkSelect(title: '安全巡查', color: Colors.transparent, must: true, placeholder: ''),
          WorkImageUpload(
            title: '本月安全巡查记录:',
            value: _safeCheck,
            controller: controllers[1],
            onChange: (value) {
              _safeCheck = value;
            },
          ),
          WorkSelect(title: '安全工作', color: Colors.transparent, must: true, placeholder: ''),
          WorkImageUpload(
            title: '安全工作日志:',
            value: _safeLog,
            controller: controllers[2],
            onChange: (value) {
              _safeLog = value;
            },
          ),
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
