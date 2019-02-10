import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
void main() => runApp(new MaterialApp(
  home: new HomePage(),
));

class HomePage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  final String url="https://swapi.co/api/people";
  List data;

  @override
  void initState(){
    super.initState();
    this.getjsonData();
  }

  Future<String> getjsonData() async{

    var response = await http.get(
    Uri.encodeFull(url),
    headers:{"Accept" : "application/json"}
    );

    setState(() {
      var convertDataToJson = JSON.jsonDecode(response.body);
      data = convertDataToJson['results'];
      print(data);
    });

    return "Success";

  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Retrive Json via HTTP Get"),
      ),
      body: new ListView.builder(
        itemCount: data==null? 0 : data.length,
        itemBuilder: (BuildContext context,int index){
          return new Container(
            child: new Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Card(
                    child: new Container(
                      child: new Text(data[index]['name']),
                      padding: const EdgeInsets.all(20.0),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
//ttgi