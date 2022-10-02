import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  List<Member> _members = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //Dio拿到的response.data就是json格式了，可以直接通过json的键值对方式获取内容，不需要使用convert里的方法进行转换
  getHttp() async {
    try {
      Response response = await Dio()
          .get('https://h5.48.cn/resource/jsonp/allmembers.php?gid=10');
      final json = response.data;
      final members = json['rows'].map<Member>((row) {
        return Member(id: row['sid'], name: row['sname']);
      });
      _members = members.toList();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _members.length,
            itemBuilder: (BuildContext context, int index) {
              final m = _members[index];
              return ListTile(
                leading: ClipOval(
                  child: Image.network(m.avatarUrl),
                ),
                title: Text(m.name),
                subtitle: Text(m.id),
              );
            },
          ),
        ),
        FloatingActionButton(onPressed: () {
          setState(() {
            getHttp();
          });
        }),
      ],
    );
  }
}

class Member {
  final String id;
  final String name;
  Member({required this.id, required this.name});
  String get avatarUrl => 'https://www.snh48.com/images/member/zp_$id.jpg';

  @override
  String toString() {
    // TODO: implement toString
    return "$id: $name";
  }
}
