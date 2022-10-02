import 'package:flutter/material.dart';

class DisMissiblePage extends StatefulWidget {
  const DisMissiblePage({Key? key}) : super(key: key);

  @override
  State<DisMissiblePage> createState() => _DisMissiblePageState();
}

class _DisMissiblePageState extends State<DisMissiblePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            _controller.forward();
          },
          child: AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                height: 100,
                color: Colors.blue,
                child: Text('data'),
              );
            },
          ),
        );
      },
    );
  }
}
