import 'package:flutter/material.dart';

class HooXiPage extends StatefulWidget {
  const HooXiPage({Key? key}) : super(key: key);

  @override
  State<HooXiPage> createState() => _HooXiPageState();
}

class _HooXiPageState extends State<HooXiPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 20));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Animation startAnimation = Tween(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Interval(0.0, 0.2)))
        .animate(_controller);
    Animation endAnimation = Tween(begin: 1.0, end: 0.0)
        .chain(CurveTween(curve: Interval(0.45, 0.95)))
        .animate(_controller);

    return Center(
      child: InkWell(
        onTap: () {
          _controller.forward();
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) {
            return Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.blue[600]!,
                    Colors.blue[100]!,
                  ],
                  stops: _controller.value <= 0.2
                      ? [startAnimation.value, startAnimation.value + 0.1]
                      : [endAnimation.value, endAnimation.value + 0.1],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
