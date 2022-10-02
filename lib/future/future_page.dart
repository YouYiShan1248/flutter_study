import 'package:flutter/material.dart';

class FuturePage extends StatelessWidget {
  const FuturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: Future.delayed(Duration(seconds: 2), () => 42),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return Text('data');
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }
          throw 'error';
        },
      ),
    );
  }
}
