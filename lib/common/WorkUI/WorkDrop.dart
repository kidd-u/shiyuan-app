import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:bot_toast/bot_toast.dart';

class WorkDrop extends StatefulWidget {
  WorkDrop(
    this.context, {
    Key key,
    this.title,
    this.margin,
    this.color = Colors.white,
    this.value,
    this.placeholder = '请选择',
    this.onChange,
    this.must = false,
    @required this.actions,
  }) : super(key: key);
  final String title;
  final EdgeInsets margin;
  final Color color;
  String value;
  final String placeholder;
  final CallbackAction onChange;
  final bool must;
  final List<String> actions;
  final BuildContext context;

  @override
  State<StatefulWidget> createState() {
    return new WorkDropState();
  }
}

class WorkDropState extends State<WorkDrop> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    List<Widget> views = [];
    if (widget.value == null) {
      Widget label = MainTextLabel(
        widget.placeholder,
        margin: EdgeInsets.only(left: 19 * ScaleWidth),
        textColor: Color(0xFFACABAE),
      );
      views.add(label);
    } else {
      Widget label = MainTextLabel(
        widget.value,
        margin: EdgeInsets.only(left: 19 * ScaleWidth),
      );
      views.add(label);
    }

    return Column(
      children: <Widget>[
        new Container(
          margin: widget.margin,
          color: widget.color,
          height: 88 * ScaleWidth,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    MainTitleLabel(
                      widget.must ? '*' : '',
                      textColor: WarningColor,
                      margin: EdgeInsets.only(left: 30 * ScaleWidth),
                    ),
                    MainTitleLabel(
                      widget.title,
                    ),
                  ],
                ),
              ),
              Stack(
                alignment: AlignmentDirectional.centerStart,
                children: <Widget>[
                  ImageView(
                    src: 'imgs/home/jihua/drop.png',
                    width: 306 * ScaleWidth,
                    height: 50 * ScaleWidth,
                    margin: EdgeInsets.only(right: 30 * ScaleWidth),
                  ),
                  ...views,
                  Builder(builder: (context) {
                    return GestureDetector(
                      child: Container(
                        width: 306 * ScaleWidth,
                        height: 50 * ScaleWidth,
                        color: Colors.transparent,
                      ),
                      onTap: () {
                        BotToast.showAttachedWidget(
                            backgroundColor: Color.fromRGBO(0, 0, 0, 0.3),
                            targetContext: context,
                            preferDirection: PreferDirection.bottomCenter,
                            attachedBuilder: (cancelFunc) {
                              List<Widget> dropList = [];
                              for (int i = 0; i < widget.actions.length; i++) {
                                Widget itemCell = GestureDetector(
                                  child: Container(
                                    width: 306 * ScaleWidth,
                                    height: 60 * ScaleWidth,
                                    color: Colors.transparent,
                                    padding: EdgeInsets.only(left: 20 * ScaleWidth, right: 20 * ScaleWidth),
                                    child: Row(
                                      children: <Widget>[MainTextLabel(widget.actions[i])],
                                    ),
                                  ),
                                  onTap: (){
                                    print(widget.actions[i]);
                                    setState(() {
                                      widget.value = widget.actions[i];
                                    });
                                    cancelFunc();
                                  },
                                );
                                dropList.add(itemCell);
                                if (i != widget.actions.length - 1) {
                                  dropList.add(LineView());
                                }
                              }
                              return ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                child: Container(
                                  color: Colors.white,
                                  width: 306 * ScaleWidth,
                                  height: 60 * widget.actions.length * ScaleWidth + widget.actions.length,
                                  child: Column(
                                    children: <Widget>[
                                      ...dropList,
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
        LineView(),
      ],
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
