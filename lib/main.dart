import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var sex = ['Male', 'Female'];
  var sexAns = 'Male';
  String heightAns = "cm";
  String weightAns = "kg";
  String waistAns = "cm";
  TextEditingController sexTextEditingController = new TextEditingController();
  TextEditingController ageTextEditingController = new TextEditingController();
  TextEditingController heightTextEditingController =
      new TextEditingController();
  TextEditingController weightTextEditingController =
      new TextEditingController();
  TextEditingController waistTextEditingController =
      new TextEditingController();
  double absi = 0;
  double absiz = 0;
  String age;
  double absiMean = 0;
  double absiSD = 0;
  String risk = "";
  List<String> genderList = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.teal.shade400,
              title: Row(children: <Widget>[
                Text(
                  'Omni',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                Text(' Calculator')
              ])),
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                width: 350,
                color: Colors.white,
                child: Column(children: [
                  Row(children: [
                    Text("Sex", style: TextStyle(fontSize: 20)),
                    Container(
                      width: 225,
                    ),
                    DropdownButton<String>(
                      items: sex.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem,
                              style: TextStyle(fontSize: 20)),
                        );
                      }).toList(),
                      onChanged: (String genderSelected) {
                        setState(() {
                          this.sexAns = genderSelected;
                        });
                      },
                      value: sexAns,
                      underline: SizedBox(),
                    ),
                  ]),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text("Age", style: TextStyle(fontSize: 20)),
                      Container(
                          width: 225,
                          child: TextField(
                            controller: ageTextEditingController,
                            decoration:
                                new InputDecoration.collapsed(hintText: ""),
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.end, keyboardType:TextInputType.number
                          )),
                      Text("years", style: TextStyle(fontSize: 20)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text("Height", style: TextStyle(fontSize: 20)),
                      Container(
                          width: 210,
                          child: TextField(
                              controller: heightTextEditingController,
                              decoration: InputDecoration.collapsed(
                                hintText: "",
                              ),
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.end)),
                      DropdownButton(
                          underline: SizedBox(),
                          value: heightAns,
                          items: [
                            DropdownMenuItem(
                                child:
                                    Text("cm", style: TextStyle(fontSize: 20)),
                                value: "cm"),
                            DropdownMenuItem(
                                child:
                                    Text("m", style: TextStyle(fontSize: 20)),
                                value: "m"),
                            DropdownMenuItem(
                                child:
                                    Text("in", style: TextStyle(fontSize: 20)),
                                value: "in"),
                            DropdownMenuItem(
                                child:
                                    Text("ft", style: TextStyle(fontSize: 20)),
                                value: "ft"),
                            DropdownMenuItem(
                                child: Text("ft/in",
                                    style: TextStyle(fontSize: 20)),
                                value: "ft/in"),
                            DropdownMenuItem(
                                child: Text("m/cm",
                                    style: TextStyle(fontSize: 20)),
                                value: "m/cm")
                          ],
                          onChanged: (value) {
                            setState(() {
                              heightAns = value;
                            });
                          }),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Weight", style: TextStyle(fontSize: 20)),
                      Container(
                          width: 210,
                          child: TextField(
                              controller: weightTextEditingController,
                              decoration: InputDecoration.collapsed(
                                hintText: "",
                              ),
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.end)),
                      DropdownButton(
                          underline: SizedBox(),
                          value: weightAns,
                          items: [
                            DropdownMenuItem(
                                child:
                                    Text("kg", style: TextStyle(fontSize: 20)),
                                value: "kg"),
                            DropdownMenuItem(
                                child:
                                    Text("lb", style: TextStyle(fontSize: 20)),
                                value: "lb"),
                            DropdownMenuItem(
                                child: Text("stone",
                                    style: TextStyle(fontSize: 20)),
                                value: "stone"),
                          ],
                          onChanged: (value) {
                            setState(() {
                              weightAns = value;
                            });
                          }),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Waist Circumference",
                          style: TextStyle(fontSize: 20)),
                      Container(
                          width: 106,
                          child: TextField(
                              onChanged: (text) {
                                loadMaleList(ageTextEditingController.text);
                                calculatorABSI();
                              },
                              controller: waistTextEditingController,
                              decoration: InputDecoration.collapsed(
                                hintText: "",
                              ),
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.end)),
                      DropdownButton(
                          underline: SizedBox(),
                          value: waistAns,
                          items: [
                            DropdownMenuItem(
                                child:
                                    Text("cm", style: TextStyle(fontSize: 20)),
                                value: "cm"),
                            DropdownMenuItem(
                                child:
                                    Text("m", style: TextStyle(fontSize: 20)),
                                value: "m"),
                            DropdownMenuItem(
                                child:
                                    Text("in", style: TextStyle(fontSize: 20)),
                                value: "in"),
                          ],
                          onChanged: (value) {
                            setState(() {
                              waistAns = value;
                            });
                          }),
                    ],
                  ),
                  Container(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.teal[200], onPrimary: Colors.white),
                        child: Text("Calculate", style: TextStyle(fontSize: 20)),
                        onPressed: () {
                          calculatorABSI();
                        }),
                  ),
                  SizedBox(height: 20),
                  Container(height: 10, color: Colors.grey[350]),
                  Row(children: [
                    Container(
                        color: Colors.grey[350],
                        height: 35,
                        width: 350,
                        child: Text("Result",
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left))
                  ]),
                  SizedBox(height: 10),
                  Container(
                    child: Row(children: [
                      Text(
                        "ABSI",
                        style: TextStyle(fontSize: 20),
                      ),
                      Container(
                          width: 300,
                          child: Text(
                            absi.toStringAsFixed(5),
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.right,
                          )),
                    ]),
                    width: 350,
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: Row(children: [
                      Text(
                        "ABSI z-score",
                        style: TextStyle(fontSize: 20),
                      ),
                      Container(
                          width: 218,
                          child: Text(
                            absiz.toStringAsFixed(4),
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.right,
                          ))
                    ]),
                    width: 350,
                  ),
                  SizedBox(height: 10),
                  Divider(thickness:5),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                          width: 200,
                          height: 200,
                          child: Image.asset("assets/images/Legend.png",
                              scale: 1.5)),
                      Column(children: [
                        Container(
                          height: 30,
                          child: Text("Mortality Risk:",
                              style: TextStyle(fontSize: 20)),
                        ),
                        Text(risk,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Container(height: 150)
                      ])
                    ],
                  ),
                  Container(height: 50)
                ]),
              ),
            ),
          )),
    );
  }

  calculatorABSI() {
    setState(() {
      double height, weight, waist;
      //if statements
      if (heightAns == "cm")
        height = double.parse(heightTextEditingController.text) / 100;
      else if (heightAns == "m")
        height = double.parse(heightTextEditingController.text);
      else if (heightAns == "in")
        height = double.parse(heightTextEditingController.text) / 39.37;
      else if (heightAns == "ft")
        height = double.parse(heightTextEditingController.text) / 3.281;
      else if (heightAns == "ft/in") {
        var parts = heightTextEditingController.text.split("/");
        String feets = parts[0];
        String inches = parts[1];

        height = double.parse(feets) / 3.281 + double.parse(inches) / 39.37;
      } else if (heightAns == "m/cm") {
        var parts = heightTextEditingController.text.split("/");
        String meters = parts[0];
        String centimers = parts[1];

        height = double.parse(meters) + double.parse(centimers) / 100;
      } else {}

      if (weightAns == "kg")
        weight = double.parse(weightTextEditingController.text);
      else if (weightAns == "lb")
        weight = double.parse(weightTextEditingController.text) / 2.205;
      else if (weightAns == "stone")
        weight = double.parse(weightTextEditingController.text) * 6.35;
      else {}

      if (waistAns == "cm")
        waist = double.parse(waistTextEditingController.text) / 100;
      else if (waistAns == "m")
        waist = double.parse(waistTextEditingController.text);
      else if (waistAns == "in")
        waist = double.parse(waistTextEditingController.text) / 39.37;
      else {}

      loadMaleList(ageTextEditingController.text);

      //BMI Calculator
      double bmi = weight / (height * height);

      //ABSI Calculator
      absi = waist / (pow(bmi, 2 / 3) * pow(height, 1 / 2));
      absiz = (absi - absiMean) / absiSD;

      if (absiz < -0.868)
        risk = "Very Low";
      else if (absiz >= -0.868 && absiz < -0.272)
        risk = "Low";
      else if (absiz >= -0.272 && absiz < 0.229)
        risk = "Average";
      else if (absiz >= 0.229 && absiz < 0.798)
        risk = "High";
      else
        risk = "Very High";
    });
  }

  loadMaleList(String age) async {
    String responseText;
    int searchMean, searchSD;

    if (sexAns == "Male")
      responseText = await rootBundle.loadString('assets/tables/Male.txt');
    else
      responseText = await rootBundle.loadString('assets/tables/Female.txt');

    genderList = responseText.split(" ");
    searchMean = genderList.indexOf(age) + 3;
    searchSD = genderList.indexOf(age) + 4;
    absiMean = double.parse(genderList[searchMean]);
    absiSD = double.parse(genderList[searchSD]);
  }
}
