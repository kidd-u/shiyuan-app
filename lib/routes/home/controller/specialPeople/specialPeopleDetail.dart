import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import 'package:shiyuan/states/default.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

enum SpecialType {
  normal, //正常
  loading, //即将过期
  error, //已过期
}

class SpecialPeopleDetailPage extends StatefulWidget {
  SpecialPeopleDetailPage({
    Key key,
    this.arguments, //任务id
  }) : super();
  Map arguments;

  @override
  State<StatefulWidget> createState() {
    return new SpecialPeopleDetailState();
  }
}

class SpecialPeopleDetailState extends State<SpecialPeopleDetailPage> {
  String _exteduId;
  Map _detail = {};

  void initState() {
    super.initState();
    _exteduId = '${widget.arguments['id']}';
    getDetail();
  }

  getDetail() async {
    var res = await HttpUtil.get('/extedu/detail/${_exteduId}');
    setState(() {
      _detail = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    SpecialType type;
    int time = _detail['status'] ?? 0;
    if (time < 0) {
      type = SpecialType.error;
    } else if (time < 90) {
      type = SpecialType.loading;
    } else {
      type = SpecialType.normal;
    }
    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '证书详情'),
      body: new ListView(
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          Container(
            width: ScreenWidth,
            height: 363 * ScaleWidth,
            child: _detail.containsKey('certificates')?new Swiper(
              itemBuilder: (BuildContext context, int index) {
                return new Image.network(
                  SafeMap(_detail)['certificates'][index]['src'].value,
                  fit: BoxFit.cover,
                );
              },
              itemCount: SafeMap(_detail)['certificates'].list.length,
              pagination: new SwiperPagination(),
              autoplay: true,
            ):SizedBox(),
          ),
          WorkSelect(title: '证书名称:', value: SafeMap(_detail)['name'].value),
          WorkSelect(title: '持证人：', value: SafeMap(_detail)['account']['name'].value),
          WorkSelect(title: '证书有效期：', value: SafeMap(_detail)['validDate'].value),
          WorkSelect(title: '所属部门/单位:', value: SafeMap(_detail)['depart']['name'].value),
          WorkSelect(title: '岗位:', value: SafeMap(_detail)['job'].value),
          WorkSelect(title: '上传人:', value: SafeMap(_detail)['uploader']['name'].value),
          WorkEmpty(
            leftActions: [MainTitleLabel('当前状态:')],
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
          )
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
