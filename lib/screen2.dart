import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:routing_fetching/screen1.dart';

class screen2 extends StatelessWidget {
  late String title;
  late String content;

  screen2(this.title, this.content);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: 
        Text(
          title,
          style: TextStyle(
            fontSize: 30,
            color: Colors.deepPurple,
          ),),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Card(
            child: Text(
              content,
              style: TextStyle(
                fontSize: 20,
                color: Colors.greenAccent
                )),
          ),
        )),
    );
  }
}
