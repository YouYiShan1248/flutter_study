import 'dart:math';

import 'package:flutter/material.dart';

class GlobalKeyPage extends StatefulWidget {
  const GlobalKeyPage({Key? key}) : super(key: key);

  @override
  State<GlobalKeyPage> createState() => _GlobalKeyPageState();
}

class _GlobalKeyPageState extends State<GlobalKeyPage> {
  int? _slot;
  double? _offset;
  var _color = Colors.blue;
  var _colors;

  final GlobalKey _globalKey = GlobalKey();

  _shuffle() {
    _color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    _colors = List.generate(8, (index) => _color[(index + 1) * 100]);
    _colors.shuffle();
  }

  @override
  void initState() {
    super.initState();
    _shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal[100]!, Colors.teal[200]!, Colors.teal[300]!],
            stops: [0.0, 0.5, 1.0]),
      ),
      child: Listener(
        onPointerMove: (event) {
          final y = event.position.dy;
          if (y > (_slot! + 1) * Box.height + _offset!) {
            if (_slot == _colors.length - 1) return;
            setState(() {
              var c = _colors[_slot!];
              _colors[_slot!] = _colors[_slot! + 1];
              _colors[_slot! + 1] = c;
              _slot = _slot! + 1;
            });
          } else if (y < (_slot!) * Box.height + _offset!) {
            if (_slot == 0) return;
            setState(() {
              var c = _colors[_slot!];
              _colors[_slot!] = _colors[_slot! - 1];
              _colors[_slot! - 1] = c;
              _slot = _slot! - 1;
            });
          }
        },
        child: Stack(key: _globalKey, children: [
          ...List.generate(
            _colors.length,
            (index) => Box(
              color: _colors[index],
              x: 100,
              y: index * (Box.height + 2),
              key: ValueKey(_colors[index]),
              onDrag: (Color color) {
                _slot = _colors.indexOf(color);
                var renderBox = (_globalKey.currentContext?.findRenderObject()
                    as RenderBox);
                // var stackHeight = renderBox.globalToLocal(Offset.zero).dy;
                _offset = renderBox.localToGlobal(Offset.zero).dy;
              },
            ),
          ),
        ]),
      ),
    );
  }
}

class Box extends StatelessWidget {
  const Box(
      {Key? key,
      required this.color,
      required this.x,
      required this.y,
      required this.onDrag})
      : super(key: key);
  final Color? color;
  final double x;
  final double y;
  static const width = 200.0;
  static const height = 80.0;
  final Function(Color) onDrag;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: y,
      left: x,
      duration: const Duration(milliseconds: 100),
      child: Draggable(
        onDragStarted: () => onDrag(color!),
        feedback: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), color: color),
        ),
        childWhenDragging: Container(
          height: height,
          width: width,
        ),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), color: color),
        ),
      ),
    );
  }
}
