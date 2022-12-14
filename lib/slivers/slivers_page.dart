import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class SliversPage extends StatefulWidget {
  const SliversPage({Key? key}) : super(key: key);

  @override
  State<SliversPage> createState() => _SliversPageState();
}

class _SliversPageState extends State<SliversPage> {
  List<Member> _members = [];

  //Dio拿到的response.data就是json格式了，可以直接通过json的键值对方式获取内容，不需要使用convert里的方法进行转换
  getHttp() async {
    try {
      Response response = await Dio()
          .get('https://h5.48.cn/resource/jsonp/allmembers.php?gid=10');
      final json = response.data;
      final members = json['rows'].map<Member>((row) {
        return Member(id: row['sid'], name: row['sname'], team: row['tname']);
      });
      _members = members.toList();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: FloatingActionButton(
            child: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                getHttp();
              });
            },
          ),
        ),
        SliverToBoxAdapter(child: Text('Team SII')),
        _buildTeamList('SII'),
        SliverToBoxAdapter(child: Text('Team NII')),
        _buildTeamList('NII'),
        SliverToBoxAdapter(child: Text('Team HII')),
        _buildTeamList('HII'),
        SliverToBoxAdapter(child: Text('Team X')),
        _buildTeamList('X'),
      ],
    );
  }

  SliverList _buildTeamList(String teamName) {
    final teamMembers =
        _members.where((element) => element.team == teamName).toList();

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final m = teamMembers[index];
          return ListTile(
            leading: ClipOval(
              child: Image.network(m.avatarUrl),
            ),
            title: Text(m.name),
            subtitle: Text(m.id),
            // trailing: Text(m.team),
          );
        },
        childCount: teamMembers.length,
      ),
    );
  }
}

class Member {
  final String id;
  final String name;
  final String team;

  Member({required this.team, required this.id, required this.name});
  String get avatarUrl => 'https://www.snh48.com/images/member/zp_$id.jpg';

  @override
  String toString() {
    // TODO: implement toString
    return "$id: $name";
  }
}
