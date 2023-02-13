import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:day35/details_show_page.dart';
import 'package:day35/model_class_page.dart';
import 'package:day35/wigets/spinkit_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String link =
      "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json?fbclid=IwAR2gsu4SRvRRFkHK8JPTWHZXmaNP0dtpOG6h7ep4zQp7WaamX5S1UaSrc3A";
  List<Exercise> allData = [];
  late Exercise exercise;
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  bool isLoading = false;
  fetchData() async {
    try {
      setState(() {
        isLoading = true;
      });
      var responce = await http.get(Uri.parse(link));
      print("status code is ${responce.statusCode}");
      if (responce.statusCode == 200) {
        var data = jsonDecode(responce.body);
        for (var i in data["exercises"]) {
          exercise = Exercise(
              id: i["id"],
              title: i["title"],
              thumbnail: i["thumbnail"],
              gif: i["gif"],
              seconds: i["seconds"]);

          setState(() {
            allData.add(exercise);
          });
        }
        setState(() {
          isLoading = false;
        });
      }
      setState(() {
        isLoading = false;
      });
      //

    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("The problem is: $e");
      showToast("Somthing wrong !");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading == true,
      blur: 0.5,
      opacity: 0.5,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
        appBar: AppBar(
          title: ListTile(
            title: Text(
              "Fitness App",
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text("Md.Rahul Reza"),
          ),
          centerTitle: true,
          leading: Icon(Icons.menu),
          actions: [Icon(Icons.person)],
        ),
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: allData.length,
            itemBuilder: (context, index) {
              return  Padding(
                padding: const EdgeInsets.all(12),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: allData.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                exercise: allData[index],
                              )));
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            border: Border.all(
                              color: Colors.blue,
                              width: 5.0
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          height: MediaQuery.of(context).size.height/2,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: CachedNetworkImage(
                                  width: double.infinity,
                                  imageUrl: "${allData[index].thumbnail}",
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => spinkit,
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                              Positioned(

                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.only(left: 20, bottom: 12),
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    "${allData[index].title}  ${allData[index].seconds}Sec ",
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 24),
                                  ),
                                  height: 60,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      gradient: const LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            Colors.indigo,
                                            Colors.blue,
                                            Colors.blueAccent,
                                            Colors.transparent
                                          ])),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              );
            }),
      ),
    );
  }
}

showToast(String title) {
  return Fluttertoast.showToast(
      msg: "$title",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
