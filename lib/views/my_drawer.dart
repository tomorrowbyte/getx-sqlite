import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sqflite/views/settings.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Sebghat Yusuf"),
            accountEmail: Text("SebghatYusuf@gmail.com"),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: (){
              Get.to(Settings());
            },
          )
        ],
      ),
    );
  }
}
