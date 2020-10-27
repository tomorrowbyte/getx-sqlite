import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Settings".tr,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
                
              ),
              background: Image.asset('assets/images/bg.jpg'),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.volume_off),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
