import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class StreamPage extends StatefulWidget {
  const StreamPage({Key? key}) : super(key: key);

  @override
  State<StreamPage> createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  final _inputController = StreamController.broadcast();
  final _scoreController = StreamController.broadcast();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.pink[100]!, Colors.cyan[100]!],
            stops: [0.0, 1.0]),
      ),
      child: Stack(
        children: [
          ...List.generate(
            5,
            (index) => Puzzle(
              inputStream: _inputController.stream,
              scoreStream: _scoreController,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: KeyPad(
              controller: _inputController,
            ),
          ),
          StreamBuilder(
            stream: _scoreController.stream.transform(TallyTransformer()),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                return Positioned(
                  top: MediaQuery.of(context).padding.top + 10,
                  right: MediaQuery.of(context).padding.right + 10,
                  child: DefaultTextStyle(
                    style: TextStyle(fontSize: 24, color: Colors.white),
                    child: Row(
                      children: [
                        Text('score: '),
                        Text('${snapshot.data}'),
                      ],
                    ),
                  ),
                );
              }
              return Positioned(
                  top: MediaQuery.of(context).padding.top + 10,
                  right: MediaQuery.of(context).padding.right + 10,
                  child: Text('waiting..'));
            },
          ),
        ],
      ),
    );
  }
}

class Puzzle extends StatefulWidget {
  Puzzle({Key? key, required this.inputStream, required this.scoreStream})
      : super(key: key);
  final Stream inputStream;
  final StreamController scoreStream;

  @override
  State<Puzzle> createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  int? a;
  int? b;
  Color? color;
  double? x;

  reset() {
    a = Random().nextInt(5) + 1;
    b = Random().nextInt(5);
    x = Random().nextDouble() * 300;
    color = Colors.primaries[Random().nextInt(Colors.primaries.length)][200];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reset();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: Random().nextInt(3000) + 3000),
    )..forward(from: 0.0);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        reset();
        _animationController.forward(from: 0.0);
        widget.scoreStream.add(-3);
      }
    });

    widget.inputStream.listen((event) {
      if (event == a! + b!) {
        reset();
        _animationController.forward(from: 0.0);
        widget.scoreStream.add(5);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return Positioned(
          top: -200 +
              _animationController.value * (MediaQuery.of(context).size.height),
          left: x,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: color?.withOpacity(0.5),
                border: Border.all(color: Colors.black54)),
            padding: EdgeInsets.all(12.0),
            child: Text(
              '$a+$b',
              style: TextStyle(fontSize: 24.0),
            ),
          ),
        );
      },
    );
  }
}

class KeyPad extends StatelessWidget {
  const KeyPad({
    Key? key,
    this.controller,
  }) : super(key: key);

  final controller;
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 16 / 9,
      shrinkWrap: true,
      crossAxisCount: 3,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        9,
        (index) => MaterialButton(
          child: Text(
            '${index + 1}',
            style: TextStyle(fontSize: 24.0),
          ),
          onPressed: () {
            controller.add(index + 1);
          },
          color: Colors.primaries[index][100],
        ),
      ),
    );
  }
}

class TallyTransformer implements StreamTransformer {
  int sum = 0;
  StreamController _controller = StreamController();
  @override
  Stream bind(Stream stream) {
    stream.listen((event) {
      sum += event.hashCode;
      _controller.add(sum);
    });
    return _controller.stream;
  }

  @override
  StreamTransformer<RS, RT> cast<RS, RT>() => StreamTransformer.castFrom(this);
}
