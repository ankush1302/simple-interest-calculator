import 'package:flutter/material.dart';

void main() => runApp(sic());

class sic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: calculator(),
      theme: ThemeData(
          accentColor: Colors.black,
          primaryColor: Colors.black,
          hintColor: Colors.black45),
    );
  }
}

class calculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIformState();
  }
}

class _SIformState extends State<calculator> {
  var currency = ['Rupees', 'Dollars', 'Pounds'];
  var currentItemSelected = 'Rupees';
  TextEditingController principleController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termsController = TextEditingController();
  var displayResult = '';
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          title: Text(
            "Simple Interest Calculator",
            textDirection: TextDirection.ltr,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          elevation: 8.0,
          backgroundColor: Colors.black,
          leading: Icon(
            Icons.monetization_on,
            color: Colors.amber,
          ),
        ),
        body: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: ListView(
                  children: <Widget>[
                  getImage(),
              Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: TextFormField(
                  // ignore: missing_return
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'please enter principle amount';
                    }
                  },
                  controller: principleController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_balance),
                      hintText: 'enter principle eg : 100000 ',
                      labelText: 'Principle',
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(6.0)),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: roiController,
                  decoration: InputDecoration(
                      hintText: 'in percent',
                      labelText: 'Rate Of Interest',
                      prefixIcon: Icon(Icons.fast_forward),
                      border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(6.0)))),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: termsController,
                              decoration: InputDecoration(
                                  hintText: 'time(years)',
                                  labelText: 'Terms',
                                  prefixIcon: Icon(Icons.access_time),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(6.0)))),
                            ),
                          )),
                      Container(
                        width: 20.0,
                      ),
                      Expanded(
                          child: DropdownButton<String>(
                            items: currency.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            value: currentItemSelected,
                            onChanged: (String newValueSelected) {
                              dropDownMenuSelected(newValueSelected);
                            },
                          ))
                    ],
                  )),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                        child: Text(
                          "Calculate",
                          textScaleFactor: 1.3,
                        ),
                        textColor: Colors.white,
                        color: Colors.black,
                        onPressed: () {
                          setState(() {
                            if (formKey.currentState.validate()) {
                              this.displayResult = totalReturns();
                            };
                          },
                          );
                        }
                    ),),
                    Container(
                      width: 30.0,
                    ),
                    Expanded(
                        child: RaisedButton(
                          textColor: Colors.black,
                          color: Colors.white,
                          child: Text(
                            "Reset",
                            textScaleFactor: 1.3,
                          ),
                          onPressed: () {
                            setState(() {
                              resetData();
                            });
                          },
                        ))
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      displayResult,
                      textScaleFactor: 1.3,
                    ),
                  ),
                ],
              ),
            )));
  }

  void dropDownMenuSelected(String newValueSelected) {
    setState(() {
      this.currentItemSelected = newValueSelected;
    });
  }

  String totalReturns() {
    double principle = double.parse(principleController.text);
    double roi = double.parse(roiController.text);
    double terms = double.parse(termsController.text);
    double amountPayable = principle + (principle * roi * terms) / 100;
    String result =
        'After $terms years , your investment will be worth $amountPayable $currentItemSelected';
    return result;
  }

  void resetData() {
    principleController.text = '';
    roiController.text = '';
    termsController.text = '';
    displayResult = '';
    currentItemSelected = currency[0];
  }
}

Widget getImage() {
  AssetImage assetImage = AssetImage("images/money_icon.png");
  Image image = Image(
    image: assetImage,
    width: 200.0,
    height: 200.0,
  );
  return Container(
    child: image,
    padding: EdgeInsets.only(left: 10.0, top: 20.0),
  );
}
