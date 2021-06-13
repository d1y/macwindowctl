import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macwindowctl/macwindowctl.dart';

void main() {
  runApp(MacApp());
}

class MacApp extends StatefulWidget {
  MacApp({Key? key}) : super(key: key);

  double buttonSize = 24;

  double blurSize = 24;

  bool focused = true;

  @override
  _MacAppState createState() => _MacAppState();
}

class _MacAppState extends State<MacApp> {
  double get _buttonSize {
    return widget.buttonSize / 100;
  }

  set _buttonSize(_newval) {
    setState(() {
      widget.buttonSize = _newval * 100;
    });
  }

  double get _blurSize {
    return widget.blurSize / 100;
  }

  set _blurSize(_newval) {
    setState(() {
      widget.blurSize = _newval * 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("#MacApp"),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                width: 120,
                height: 120,
              ),
              Container(
                margin: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.all(
                    const Radius.circular(24),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Macwindowctl(
                        buttonSize: widget.buttonSize,
                        blurSize: widget.blurSize,
                        focused: widget.focused,
                        onHover: (action) {
                          // print("hover action: $action");
                        },
                        onExit: (action) {
                          // print("exit action: $action");
                        },
                        onClick: (action) {
                          print("click handle: $action");
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(24),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "a beautiful Mac OS X Traffic Lights",
                            style: TextStyle(fontSize: 24),
                          ),
                          Row(
                            children: [
                              Text("Button Size: "),
                              CupertinoSlider(
                                onChanged: (double value) {
                                  _buttonSize = value;
                                },
                                value: _buttonSize,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Blur Size: "),
                              CupertinoSlider(
                                onChanged: (double value) {
                                  _blurSize = value;
                                },
                                value: _blurSize,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("focused flag: "),
                              CupertinoSwitch(
                                onChanged: (value) {
                                  setState(() {
                                    widget.focused = value;
                                  });
                                },
                                value: widget.focused,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
