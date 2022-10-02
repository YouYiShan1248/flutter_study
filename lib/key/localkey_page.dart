import 'package:flutter/material.dart';

class LocalkeyPage extends StatefulWidget {
  const LocalkeyPage({Key? key}) : super(key: key);

  @override
  State<LocalkeyPage> createState() => _LocalkeyPageState();
}

class _LocalkeyPageState extends State<LocalkeyPage> {
  _shuffle() {
    boxes.shuffle();
  }

  List<Widget> boxes = [
    Box(color: Colors.blue[100], key: UniqueKey()),
    Box(color: Colors.blue[200], key: UniqueKey()),
    Box(color: Colors.blue[300], key: UniqueKey()),
    Box(color: Colors.blue[400], key: UniqueKey()),
    Box(color: Colors.blue[500], key: UniqueKey()),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 100.0),
        width: 100,
        child: ReorderableListView(
            children: boxes,
            onReorder: (oldIndex, newIndex) {
              if (oldIndex < newIndex) {
                final box = boxes.removeAt(oldIndex);
                boxes.insert(newIndex - 1, box);
              } else {
                final box = boxes.removeAt(oldIndex);
                boxes.insert(newIndex, box);
              }
            }),
      ),
    );
  }
}

class Box extends StatelessWidget {
  const Box({
    Key? key,
    required this.color,
    Color? Color,
  }) : super(key: key);
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.all(8.0),
      height: 100,
    );
  }
}
