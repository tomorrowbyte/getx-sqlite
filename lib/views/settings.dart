import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sqflite/utils/localization_service.dart';

class Settings extends StatelessWidget {
  final langCtrl = Get.put(LocalizationService());
  List _buildList() {
    List<Widget> listItems = List();
    listItems.add(Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Text(
            "Language".tr,
            style: TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Obx(() => DropdownButton<String>(
                items: LocalizationService.langs
                    .map((lang) => DropdownMenuItem(
                          child: Text(lang),
                          value: lang,
                        ))
                    .toList(),
                onChanged: (lang) {
                  langCtrl.changeLocale(lang);
                },
                value: langCtrl.selectedLang.value,
              )),
        ),
      ],
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
            backgroundColor: Colors.pink,
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
