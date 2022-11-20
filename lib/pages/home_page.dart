// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:alias_demo_app/pages/details_page.dart';
import 'package:alias_demo_app/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:alias_demo_app/models/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<UserModel>> getUsers() async {
    var response = await HttpService.getResponse(
        Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response == null) {
      Fluttertoast.showToast(msg: "Unable to fetch data");
      return [];
    }
    var jsonData = jsonDecode(response);
    return jsonData.map<UserModel>((json) => UserModel.fromMap(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: getUsers(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            var users = snapshot.data;

            if (users == null || users.isEmpty) {
              return const Center(
                child: Text('No data found'),
              );
            } else {
              return ListView.builder(
                itemCount: users.length * 10,
                itemBuilder: ((context, index) {
                  return ListTile(
                    title: Text(users[index % users.length].name),
                    subtitle: Text(users[index % users.length].email),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: ((context) => DetailsPage(user: users[index % users.length]))));
                    },
                  );
                }),
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
