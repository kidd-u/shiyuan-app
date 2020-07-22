import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:flutter/cupertino.dart';

class DialogBounceAnimation extends StatefulWidget {
  const DialogBounceAnimation({
    Key key,
    @required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  State<StatefulWidget> createState() {
    return new DialogBounceAnimationState();
  }
}

class DialogBounceAnimationState extends State<DialogBounceAnimation> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  double _scale = 0.8;

  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 150), vsync: this);
    _animation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.8, end: 1.2), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 1.0), weight: 1),
    ]).animate(_controller)
      ..addListener(() {
        setState(() {
          _scale = _animation.value;
        });
      });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: _scale,
      child: widget.child,
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
    _controller.dispose();
    super.dispose();
  }
}

class DialogBottomSheetAnimation extends StatefulWidget {
  const DialogBottomSheetAnimation({
    Key key,
    @required this.child,
    @required this.height,
  }) : super(key: key);
  final Widget child;
  final double height;

  @override
  State<StatefulWidget> createState() {
    return new DialogBottomSheetAnimationState();
  }
}

class DialogBottomSheetAnimationState extends State<DialogBottomSheetAnimation> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  double _bottom = 0;

  void initState() {
    super.initState();
    _bottom = -widget.height;
    _controller = AnimationController(duration: const Duration(milliseconds: 150), vsync: this);
    _animation = Tween(begin: -widget.height, end: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _bottom = _animation.value;
        });
      });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Positioned(
            bottom: _bottom,
            left: 0,
            right: 0,
            height: widget.height,
            child: widget.child,
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
    _controller.dispose();
    super.dispose();
  }
}
