import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../Controller/quotes_controller.dart';
import '../Helperes/quotes_helper.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  TextEditingController Love = TextEditingController();
  TextEditingController albert = TextEditingController();
  TextEditingController swami = TextEditingController();
  TextEditingController motevational = TextEditingController();
  HomeController homeController = Get.put(HomeController());

  getData () async {
    DBHelper dbHelper = DBHelper();
    homeController.dataList.value = await dbHelper.readData();
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      images.forEach((imageUrl) {
        precacheImage(NetworkImage(imageUrl), context);
      });
    });
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Amazing Quotes'),
        backgroundColor: Colors.red,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("All In One Quotes"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: swami,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: ("Swami Vivekananda Quotes")),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          controller: Love,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: ("Love Quotes")),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          controller: albert,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: ("Albert einstein Quotes")),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          controller: motevational,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: ("Motivational Quotes")),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            ElevatedButton(
                                onPressed: () async {
                                  DBHelper dbHelper = DBHelper();
                                  dbHelper.insertData(
                                    svn: swami.text,
                                    love: Love.text,
                                    mq: motevational.text,
                                    aeq: albert.text,
                                  );
                                  homeController.dataList.value = await dbHelper.readData();
                                },
                                child: const Text("Insert")),
                            SizedBox(width: 5),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("cancel")),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                child: CarouselSlider.builder(
                  itemCount: images.length,
                  options: CarouselOptions(
                    viewportFraction: 1,
                    autoPlay: true,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                  ),
                  itemBuilder: (context, index, realIdx) {
                    return Obx(
                          () => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Image.network(
                            images[index],
                            fit: BoxFit.cover,
                            width: 1000,
                          ),
                        ),
                      ),
                    );
                  },
                )),
            Container(
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Most Popular",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('LoveQuotes');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 100,
                          width: 180,
                          color: Colors.blue,
                          child: const Text(
                            "Love Quotes",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('SwamiVivekanand');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 100,
                          width: 172,
                          color: Colors.green,
                          child: const Text(
                            "Swami \n Vivekananda \n Quotes",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('Albert_Quotes');
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 180,
                      color: Colors.amber,
                      child: const Text(
                        "Albert Einstein \n Quotes",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('Motevational_Quotes');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 172,
                      color: Colors.purple,
                      child: const Text(
                        "Motivational \n Quotes",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Quotes By Category",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 200,
                      color: Colors.blueAccent,
                      child: const Text(
                        "Happiness Quotes",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 200,
                      color: Colors.lightGreen,
                      child: const Text(
                        "Success Quotes",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 200,
                      color: Colors.blueAccent,
                      child: const Text(
                        "Sad Quotes",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 200,
                      color: Colors.purple,
                      child: const Text(
                        "Motivational Quotes",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Quotes By Author",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('LoveQuotes');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 100,
                          width: 180,
                          color: Colors.amberAccent,
                          child: const Text(
                            "Albert Einstein \n Quotes",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        height: 100,
                        width: 172,
                        color: Colors.purpleAccent,
                        child: const Text(
                          "Swami \n Vivekananda \n Quotes",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Container(
                    alignment: Alignment.center,
                    height: 100,
                    width: 180,
                    color: Colors.brown,
                    child: const Text(
                      "Helen Keller \n Quotes",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 100,
                    width: 172,
                    color: Colors.redAccent,
                    child: const Text(
                      "Dr. Seuss \n Quotes",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Future",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 100,
                          width: 180,
                          color: Colors.deepPurple,
                          child: const Text(
                            "Success Quotes",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        height: 100,
                        width: 172,
                        color: Colors.lightBlue,
                        child: const Text(
                          "Life Quotes",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Container(
                    alignment: Alignment.center,
                    height: 100,
                    width: 180,
                    color: Colors.amber,
                    child: const Text(
                      "Sad Quotes",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 100,
                    width: 172,
                    color: Colors.red,
                    child: const Text(
                      "Dr. Seuss \n Quotes",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
