import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:rfw/rfw.dart';

Future<bool> updateWidgets(
    {required Runtime runtime, required String urlPrefix}) async {
  bool isCustomUi = false;

  final Directory home = await getApplicationSupportDirectory();
  final File settingsFile = File(path.join(home.path, 'settings.txt'));
  final File currentFile = File(path.join(home.path, 'current.rfw'));
  String routeName = "counter_app1.rfw";
  if (currentFile.existsSync()) {
    try {
      runtime.update(const LibraryName(<String>['main']),
          decodeLibraryBlob(await currentFile.readAsBytes()));
      isCustomUi = true;
    } catch (e, stack) {
      FlutterError.reportError(FlutterErrorDetails(exception: e, stack: stack));
    }
  }
  log("message$urlPrefix/$routeName");
  final HttpClientResponse client =
      await (await HttpClient().getUrl(Uri.parse('$urlPrefix/$routeName')))
          .close();
  await currentFile
      .writeAsBytes(await client.expand((List<int> chunk) => chunk).toList());
  await settingsFile.writeAsString(routeName);

  return isCustomUi;
}
