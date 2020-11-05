import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sqflite/utils/localization_service.dart';

class Settings extends StatelessWidget {
  final langCtrl = Get.put(LocalizationService());
  List _buildList() {
    List<Widget> listItems = List();
    listItems.add(
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
          FlatButton(
            child: Text("فارسی"),
            onPressed: () => langCtrl.changeLocale('فارسی'),
          ),
          FlatButton(
            child: Text("English"),
            onPressed: () => langCtrl.changeLocale('English'),
          )
        ],
      ),

      // ListTile(
      // leading: Text(
      // "Language".tr,
      // style: TextStyle(fontSize: 18),
      // ),
      // subtitle: DropdownButton<String>(
      // items:
      // Container(
      //   child: LocalizationService.langs
      //       .map(
      //         (lang) => DropdownMenuItem(
      //           key: UniqueKey(),
      //           child: Text(lang),
      //           value: lang,
      //         ),
      //       )
      //       .toList(),
      //   onChanged: (lang) {
      //     langCtrl.changeLocale(lang);
      //   },
      //   value: langCtrl.selectedLang.value,
      // ),
      // trailing: SizedBox(width: 60, child: Icon(Icons.language)),
      // ),
    );
    listItems.add(SizedBox(
      height: 700,
    ));
    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            // floating: true,
            expandedHeight: 220,
            pinned: true,
            // snap: true,
            elevation: 50,
            // backgroundColor: Colors,
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
