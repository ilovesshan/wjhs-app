import 'dart:io';

import 'package:app/router/router.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(elevation: 0, systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light)),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
