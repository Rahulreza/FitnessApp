import 'package:day35/model_class_page.dart';
import 'package:day35/third_page.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key? key, this.exercise}) : super(key: key);
  final Exercise? exercise;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int second = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Colors.purple,
            elevation: 10,

            child: Text(

              "${widget.exercise!.title}",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                "${widget.exercise!.thumbnail}",
                height: double.infinity,

                //fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SleekCircularSlider(
                  min: 3,
                  max: 10,
                  initialValue: second.toDouble(),
                  onChange: (double value) {
                    setState(() {
                      second = value.toInt();
                      print("second is$second");
                    });
                    // callback providing a value while its being changed (with a pan gesture)
                  },
                  innerWidget: (double value) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("${second.toStringAsFixed(0)}",
                              style: TextStyle(
                                  fontSize: 32,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold)),
                          ElevatedButton(
                            onPressed: () {
                              print("Second:$second");
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ThirdPage(
                                        exercise: widget.exercise,
                                        second: second,
                                      )));
                            },
                            child: Text("Start"),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.purple),
                          )
                        ],
                      ),
                    );
                    // use your custom widget inside the slider (gets a slider value from the callback)
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
