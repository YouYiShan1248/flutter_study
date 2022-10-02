import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 120,
        width: 120,
        child: TweenAnimationBuilder(
            tween: Tween(begin: 1.0, end: 2.0),
            duration: const Duration(milliseconds: 1000),
            builder: (context, double value, child) {
              final whole = value ~/1;
              final decimal = value - whole;
              return Stack(
                children: [
                  Positioned(
                    top: -decimal*100, // 0 ~ -100
                    child: Opacity(
                      opacity: 1-decimal,
                      child: Text(
                        '$whole',
                        style: TextStyle(fontSize: 100),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100 - decimal*100, // 100 ~ 0
                    child: Opacity(
                      opacity: decimal,
                      child: Text(
                        '${whole+1}',
                        style: TextStyle(fontSize: 100),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

class Foo extends StatefulWidget {
  const Foo({Key? key}) : super(key: key);

  @override
  State<Foo> createState() => _FooState();
}

class _FooState extends State<Foo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
