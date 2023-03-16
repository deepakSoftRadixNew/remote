// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// This file is hand-formatted.

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:remote/ui/constants.dart';
import 'package:remote/widget/update_widgets.dart';
import 'package:rfw/rfw.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Auth UI',
    theme: ThemeData(
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: Colors.white,
    ),
    home: Example(),
  ));
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final Runtime runtime = Runtime();
  final DynamicContent _data = DynamicContent();

  bool isCustomUi = false;
  // int _counter = 0;
  String urlPrefix =
      'https://raw.githubusercontent.com/deepakSoftRadixNew/remote/main/remote_widget_libraries';
  @override
  void initState() {
    super.initState();
    //using core widgets
    runtime.update(
        const LibraryName(<String>['core', 'widgets']), createCoreWidgets());
    //using core material
    runtime.update(const LibraryName(<String>['core', 'material']),
        createMaterialWidgets());
    // _updateData();
    updateWidgets(
      routeName: "counter_app1.rfw",
      runtime: runtime,
      urlPrefix: urlPrefix,
    ).then((value) {
      setState(() {
        log("message$value");
        isCustomUi = value;
      });
    });
  }

  // void _updateData() {
  //   _data.update('counter', _counter.toString());
  // }

  @override
  Widget build(BuildContext context) {
    return uiViewer();
  }

  AnimatedSwitcher uiViewer() {
    Widget result = SizedBox();
    if (isCustomUi) {
      result = RemoteWidget(
        runtime: runtime,
        data: _data,
        widget: const FullyQualifiedWidgetName(
            LibraryName(<String>['main']), 'Counter'),
        onEvent: (String name, DynamicMap arguments) {
          // if (name == 'increment') {
          //   _counter += 1;
          //   _updateData();
          // }
        },
      );
    } else {
      result = defaultUi(result: result);
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: result,
    );
  }

  Widget defaultUi({required Widget result}) {
    result = Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Center(child: Text('Loading.....', textAlign: TextAlign.center)),
          ],
        ),
      ),
    );
    return result;
  }
}
