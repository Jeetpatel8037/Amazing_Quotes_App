import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Controller/quotes_controller.dart';
import '../Helperes/quotes_helper.dart';

class Albert_Quotes extends StatefulWidget {
  const Albert_Quotes({Key? key}) : super(key: key);

  @override
  State<Albert_Quotes> createState() => _Albert_QuotesState();
}

class _Albert_QuotesState extends State<Albert_Quotes> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Albert Einstein Quotes"),
        backgroundColor: Colors.amber,
      ),
      body: Obx(
            () => ListView.builder(
            itemCount: homeController.dataList.length,
            itemBuilder: (context, i) {
              return Card(
                child: ListTile(
                  title: Text("${homeController.dataList[i]['aeq']}"),
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
