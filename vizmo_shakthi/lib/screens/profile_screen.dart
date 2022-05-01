import 'package:flutter/material.dart';
import 'package:vizmo_shakthi/constants/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.baseColor,
      appBar: AppBar(
        backgroundColor: Constants.secondaryColor,
        title: const Text("Profile"),
      ),
    );
  }
}
