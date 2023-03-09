import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../Controller/quotes_controller.dart';
import '../Helperes/quotes_helper.dart';

class SwamiVivekanand extends StatefulWidget {
  const SwamiVivekanand({Key? key}) : super(key: key);

  @override
  State<SwamiVivekanand> createState() => _SwamiVivekanandState();
}

class _SwamiVivekanandState extends State<SwamiVivekanand> {
  HomeController homeController = Get.put(HomeController());

  getData() async {
    DBHelper dbHelper = DBHelper();
    homeController.dataList.value = await dbHelper.readData();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  TextEditingController Love = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Swami Vivekananda Quotes"),
        backgroundColor: Colors.green,
      ),
      body: Obx(
            () => ListView.builder(
            itemCount: homeController.dataList.length,
            itemBuilder: (context, i) {
              return Card(
                child: ListTile(
                  title: Text("${homeController.dataList[i]['svn']}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            DBHelper.dbHalper.deleteData(
                                id: homeController.dataList[i]['id']);
                            getData();
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ))
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
