import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({Key? key}) : super(key: key);

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this)
          ..repeat(reverse: false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SlideTransition(
            position: Tween(
              begin: Offset.zero,
              end: Offset(1.0, 0.0),
            )
                .chain(CurveTween(curve: Curves.bounceOut))
                .chain(CurveTween(curve: Interval(0.0, 0.2)))
                .animate(_controller),
            child: Container(height: 120, width: 120, color: Colors.blue[200]),
          ),
          SlideTransition(
            position: Tween(
              begin: Offset.zero,
              end: Offset(1.0, 0.0),
            )
                .chain(CurveTween(curve: Curves.bounceOut))
                .chain(CurveTween(curve: Interval(0.2, 0.4)))
                .animate(_controller),
            child: Container(height: 120, width: 120, color: Colors.blue[400]),
          ),
          SlideTransition(
            position: Tween(
              begin: Offset.zero,
              end: Offset(1.0, 0.0),
            )
                .chain(CurveTween(curve: Curves.bounceOut))
                .chain(CurveTween(curve: Interval(0.4, 0.6)))
                .animate(_controller),
            child: Container(height: 120, width: 120, color: Colors.blue[600]),
          ),
          SlideTransition(
            position: Tween(
              begin: Offset.zero,
              end: Offset(1.0, 0.0),
            )
                .chain(CurveTween(curve: Curves.bounceOut))
                .chain(CurveTween(curve: Interval(0.6, 1.0)))
                .animate(_controller),
            child: Container(height: 120, width: 120, color: Colors.blue[800]),
          ),
        ],
      ),
    );
  }
}
