import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SwitchPage extends StatefulWidget {
  const SwitchPage({Key? key}) : super(key: key);

  @override
  State<SwitchPage> createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  final List<String> _current = [
    'day_idle',
    'night_idle',
    'switch_day',
    'switch_night'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {},
        child: RiveAnimation.asset(
          'assets/transitions.riv',
          animations: _current,
        ),
      ),
    );
  }
}
