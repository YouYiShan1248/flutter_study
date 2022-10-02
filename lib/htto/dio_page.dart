import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_study/htto/weather_model.dart';

class DioPage extends StatefulWidget {
  const DioPage({Key? key}) : super(key: key);

  @override
  State<DioPage> createState() => _DioPageState();
}

class _DioPageState extends State<DioPage> {
  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onRefresh();

  }

  onRefresh()async{
    try {
       Response response = await Dio().get(
          'https://api.openweathermap.org/data/2.5/weather?q=Chengdu&appid=bc447f7ec08b60c799bea73aaf5d9990');
       weatherModel = WeatherModel.fromJson(response.data);
       print(weatherModel.name);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        onRefresh: ()=>onRefresh(),
        child: ListView.builder(
          itemExtent: 80,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${weatherModel.name}'),
              subtitle: Text('${weatherModel.main}'),
            );
          },
        ),
      ),
    );
  }
}
