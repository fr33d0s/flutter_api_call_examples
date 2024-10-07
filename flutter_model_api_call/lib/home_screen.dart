import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Model API Call"),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: '${user.name.title} '),
                  TextSpan(text: '${user.name.first} '),
                  TextSpan(text: user.name.last),
                ],
              ),
            ),
            subtitle: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: '${user.nat} '),
                  TextSpan(text: user.phone),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
        child: const Icon(Icons.add),
      ),
    );
  }

  void fetchUsers() async {
    if (kDebugMode) {
      print("fetchUsers called");
    }
    const url = "https://randomuser.me/api/?results=100";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json["results"] as List<dynamic>;
    final transformed = results.map((e) {
      final name = UserName(
          title: e["name"]["title"],
          first: e["name"]["first"],
          last: e["name"]["last"]);
      return User(
        cell: e["cell"],
        email: e["email"],
        gender: e["gender"],
        phone: e["phone"],
        nat: e["nat"],
        name: name,
      );
    }).toList();
    setState(() {
      users = transformed;
    });
    if (kDebugMode) {
      print("fetchUsers completed");
    }
  }
}
