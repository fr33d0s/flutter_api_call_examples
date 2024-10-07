import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API Call"),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final name = user["name"]["first"];
          final email = user["email"];
          final imageUrl = user["picture"]["thumbnail"];

          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(imageUrl),
            ),
            title: Text(name.toString()),
            subtitle: Text(email),
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

    setState(() {
      users = json["results"];
    });
    if (kDebugMode) {
      print("fetchUsers completed");
    }
  }
}
