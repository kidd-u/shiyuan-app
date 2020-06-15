import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/WorkUI/work.dart';

/**
 * 带RadioChoose选项，带choose选择，顶部蓝色，通过，带信息，带照片
 * */
class HomeWorkCardAudit extends StatefulWidget {
  const HomeWorkCardAudit({
    Key key,
    this.margin,
  }) : super(key: key);
  final EdgeInsets margin;

  @override
  State<StatefulWidget> createState() {
    return new HomeWorkCardAuditState();
  }
}

class HomeWorkCardAuditState extends State<HomeWorkCardAudit> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    String value = '1';
    return new Container(
      margin: widget.margin,
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              offset: Offset(0.0, 2.0), //阴影xy轴偏移量
              blurRadius: 3.0, //阴影模糊程度
              spreadRadius: 1 //阴影扩散程度
          )
        ],
      ),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10 * ScaleWidth),
          child: Container(
            color: Colors.white,
            width: 680 * ScaleWidth,
            child: Column(
              children: <Widget>[
                WorkTitle(title: '上级审批人：余建伟',fontWeight: FontWeight.w400),
                WorkInputArea(placehoder: '请输入回复内容...', showTopLine: false, height: 188 * ScaleWidth),
                WorkImageTitle(leftActions: <Widget>[MainTitleLabel('上传照片（3/10）')]),
                WorkImageWithMessage(),
                Container(
                  margin: EdgeInsets.only(top: 20 * ScaleWidth),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: WorkButtonCancel(
                          showBorder: false,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: WorkButtonDone(
                          showBorder: false,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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
