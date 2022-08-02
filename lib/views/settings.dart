import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sqflite/utils/localization_service.dart';
import 'package:open_mail_app/open_mail_app.dart';

class Settings extends StatelessWidget {
  final langCtrl = Get.put(LocalizationService());

  void openMail() async {
    var result = await OpenMailApp.openMailApp();
    if (!result.didOpen && !result.canOpen) {
      Get.snackbar("Warning", "No mail apps installed");
    }
  }

  /// build list of items to show in sliver
  List _buildList() {
    List<Widget> listItems = [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.language),
              SizedBox(
                width: 10,
              ),
              Text("Language".tr),
            ],
          ),
          TextButton(
            child: Text("فارسی"),
            onPressed: () => langCtrl.changeLocale('فارسی'),
          ),
          TextButton(
            child: Text("English"),
            onPressed: () => langCtrl.changeLocale('English'),
          ),
        ],
      ),
      ListTile(
          leading: Icon(Icons.report_problem),
          title: Text("Report Problem".tr),
          onTap: () {
            openMail();
          }),
      SizedBox(
        height: 700,
      )
    ];

    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            elevation: 50,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset('assets/images/bg.jpg'),
              centerTitle: true,
              title: Text(
                "Settings".tr,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ),
          SliverList(delegate: SliverChildListDelegate(_buildList())),
        ],
      ),
    );
  }
}
