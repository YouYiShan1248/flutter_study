import 'dart:math';

import 'package:flutter/material.dart';

class SnowPage extends StatefulWidget {
  const SnowPage({Key? key}) : super(key: key);

  @override
  State<SnowPage> createState() => _SnowPageState();
}

class _SnowPageState extends State<SnowPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Snowflake> _snowflakes = List.generate(200, (index) => Snowflake());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue[400]!, Colors.blue[200]!, Colors.white],
              stops: [0.0, 0.5, 0.95])),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          _snowflakes.forEach((snow) {
            snow.fall();
          });
          return CustomPaint(
            painter: MyPaint(_snowflakes),
          );
        },
      ),
    );
  }
}

class MyPaint extends CustomPainter {
  List<Snowflake> _snowflakes;
  MyPaint(this._snowflakes);
  final whithPaint = Paint()..color = Colors.white;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(size.center(Offset(0.0, 230.0)), 70.0, whithPaint);
    canvas.drawOval(
        Rect.fromCenter(
            center: size.center(Offset(0.0, 400.0)), width: 200, height: 250),
        whithPaint);
    _snowflakes.forEach((snowflake) {
      canvas.drawCircle(
          Offset(snowflake.x, snowflake.y), snowflake.radius, whithPaint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Snowflake {
  double x = Random().nextDouble() * 500;
  double y = Random().nextDouble() * 900;
  double radius = Random().nextDouble() * 2 + 2;
  double velocity = Random().nextDouble() * 4 + 2;

  fall() {
    y += velocity;
    if (y >= 900) {
      y = 0;
      x = Random().nextDouble() * 500;
      radius = Random().nextDouble() * 2 + 2;
      velocity = Random().nextDouble() * 4 + 2;
    }
  }
}
