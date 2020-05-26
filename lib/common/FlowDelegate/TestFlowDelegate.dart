import 'package:flutter/material.dart';
class TestFlowDelegate extends FlowDelegate {

  EdgeInsets margin = EdgeInsets.zero;

  TestFlowDelegate({this.margin});

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;

    for (var i = 0; i < context.childCount; i++) {
      var w = x + context
          .getChildSize(i)
          .width + margin.right;
      if (w < context.size.width) {
        context.paintChild(
            i, transform: new Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y = y + context
            .getChildSize(i)
            .height + margin.bottom;
        context.paintChild(
            i, transform: new Matrix4.translationValues(x, y, 0.0));
        x = x + context
            .getChildSize(i)
            .width + margin.right + margin.left;
      }
    }
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }

  //  是否需要重新布局。
  @override
  bool shouldRelayout(FlowDelegate oldDelegate) {
    return super.shouldRelayout(oldDelegate);
  }

  //设置Flow的尺寸
  @override
  Size getSize(BoxConstraints constraints) {
    return super.getSize(constraints);
  }

  //  设置每个child的布局约束条件
  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return super.getConstraintsForChild(i, constraints);
  }
}