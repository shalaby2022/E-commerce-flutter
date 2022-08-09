import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:routing_fetching/screen2.dart';

//                   Presentation layer

class UsersScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UsersScreenState();
  }
}

class UsersScreenState extends State<UsersScreen> {
  late Future<List<User>> users;

  @override
  void initState() {
    super.initState();
    users = RemoteUsers().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: users,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var user = (snapshot.data as List<User>);
                return ListView.builder(
                    itemCount: user.length,
                    itemBuilder: (context, index) {
                      return userList(user[index]);
                    });
              } else if (snapshot.hasError) {
                return Container(
                  child: Center(child: Text('error')),
                );
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}

class userList extends StatelessWidget {
  var user;
  userList(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      child: Center(
          child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return screen2(user.title, user.content);
          }));
        },
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            child: Row(children: [
              Container(
                child: Image.network(user.picture),
              ),
              SizedBox(width: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(user.title)],
              ),
            ]),
          ),
        ),
      )),
    );
  }
}

//                    Model(domain) layer

class User {
  String title;
  String picture;
  String content;
  String id;

  User(this.title, this.picture, this.content, this.id);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['title'],
      json['picture'],
      json['content'],
      json['id'],
    );
  }
}

//                   Data layer

// class UsersCallCase {
//   Future<User> getUsers() {
//     return RemoteUsers().fetchData();
//   }
// }

class RemoteUsers {
  Future<List<User>> fetchData() async {
    var response = await http.get(
        Uri.parse('https://62d4154fcd960e45d452f790.mockapi.io/api/article'));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      var list =
          (jsonResponse as List).map((item) => User.fromJson(item)).toList();

      list.forEach((ele) => print(ele.picture));
      return list;
    } else {
      throw Exception('error occured');
    }
  }
}
