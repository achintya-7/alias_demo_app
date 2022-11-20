import 'package:alias_demo_app/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.user});
  final UserModel user;

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${user.id} : ${user.name}"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(user.name,
                style: const TextStyle(color: Colors.amber, fontSize: 30)),
            const SizedBox(height: 20),
            Text(user.username,
                style: const TextStyle(color: Colors.blue, fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  _launchUrl(Uri.parse(
                      "mailto:${user.email}?subject=<subject>&body=<body>"));
                },
                child: const Text("Go to Mail"))
          ],
        ),
      ),
    );
  }
}
