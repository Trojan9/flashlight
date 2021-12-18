import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_flashlight/flutter_flashlight.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _hasFlashlight = false;

  @override
  initState() {
    super.initState();
    initFlashlight();
  }

  initFlashlight() async {
    bool hasFlash = await Flashlight.hasFlashlight;
    print("Device has flash ? $hasFlash");
    setState(() {
      _hasFlashlight = hasFlash;
    });
  }

  var iterateflash = 0;
  void iterate() {
    Flashlight.lightOn();
    var duration = new Duration(milliseconds: 5);
    new Timer(duration, flashoff);
    iterateflash++;
  }

  void donothing() {
    print(iterateflash);
  }

  flashoff() {
    Flashlight.lightOff();
    iterateflash < 99 ? iterate() : donothing();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background.jpg"), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 10,
            backgroundColor: Colors.transparent,
            title: Text('Flutter Torch'),
            centerTitle: true,
          ),
          body: new Center(
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 150.0,
                    height: 40.0,
                    child: new RaisedButton(
                        child: Text('Start'),
                        color: Theme.of(context).accentColor,
                        elevation: 10.0,
                        splashColor: Colors.blueGrey,
                        onPressed: () {
                          iterateflash = 0;
                          iterate();
                        },
                        textColor: Colors.yellowAccent,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0))),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
