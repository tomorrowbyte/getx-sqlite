import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: [],
          )
        ],
      ),
    );
  }
}
