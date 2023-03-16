// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// This file is hand-formatted.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:remote/ui/constants.dart';
import 'package:rfw/rfw.dart';

const String urlPrefix =
    'https://raw.githubusercontent.com/deepakSoftRadixNew/remote/main/remote_widget_libraries';

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
  final Runtime _runtime = Runtime();
  final DynamicContent _data = DynamicContent();

  bool _ready = false;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    //using core widgets
    _runtime.update(
        const LibraryName(<String>['core', 'widgets']), createCoreWidgets());
    //using core material
    _runtime.update(const LibraryName(<String>['core', 'material']),
        createMaterialWidgets());
    _updateData();
    _updateWidgets();
  }

  void _updateData() {
    _data.update('counter', _counter.toString());
  }

  Future<void> _updateWidgets() async {
    final Directory home = await getApplicationSupportDirectory();
    final File settingsFile = File(path.join(home.path, 'settings.txt'));

    String nextFile = 'counter_app1.rfw';
    // if (settingsFile.existsSync()) {
    //   final String settings = await settingsFile.readAsString();
    //   // if (settings == nextFile) {
    //   //   nextFile = 'counter_app2.rfw';
    //   // }
    // }
    final File currentFile = File(path.join(home.path, 'current.rfw'));
    if (currentFile.existsSync()) {
      try {
        _runtime.update(const LibraryName(<String>['main']),
            decodeLibraryBlob(await currentFile.readAsBytes()));
        setState(() {
          _ready = true;
        });
      } catch (e, stack) {
        FlutterError.reportError(
            FlutterErrorDetails(exception: e, stack: stack));
      }
    }
    print('Fetching: $urlPrefix/$nextFile'); // ignore: avoid_print
    final HttpClientResponse client =
        await (await HttpClient().getUrl(Uri.parse('$urlPrefix/$nextFile')))
            .close();
    await currentFile
        .writeAsBytes(await client.expand((List<int> chunk) => chunk).toList());
    await settingsFile.writeAsString(nextFile);
  }

  @override
  Widget build(BuildContext context) {
    return uiViewer();
  }

  AnimatedSwitcher uiViewer() {
    Widget result = SizedBox();
    if (_ready) {
      result = RemoteWidget(
        runtime: _runtime,
        data: _data,
        widget: const FullyQualifiedWidgetName(
            LibraryName(<String>['main']), 'Counter'),
        onEvent: (String name, DynamicMap arguments) {
          if (name == 'increment') {
            _counter += 1;
            _updateData();
          }
        },
      );
    } else {
      // TODO(goderbauer): Make this const when this package requires Flutter 3.8 or later.
      // ignore: prefer_const_constructors
      result = defaltUi(result: result);
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      // switchOutCurve: Curves.elasticInOut,
      // switchInCurve: Curves.elasticInOut,
      child: result,
    );
  }

  Widget defaltUi({required Widget result}) {
    // TODO(goderbauer): Make this const when this package requires Flutter 3.8 or later.
    // ignore: prefer_const_constructors
    result = Scaffold(
      // TODO(goderbauer): Make this const when this package requires Flutter 3.8 or later.
      // ignore: prefer_const_constructors
      body: SafeArea(
        // TODO(goderbauer): Make this const when this package requires Flutter 3.8 or later.
        // ignore: prefer_const_constructors
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
