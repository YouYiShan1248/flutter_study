import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
class ListViewPage extends StatefulWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHttp();
  }

  void getHttp() async {
    try {
      var response = await Dio().get('https://h5.48.cn/resource/jsonp/allmembers.php?gid=10');
      print(response);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('data'),
      ),
    );
  }
}
