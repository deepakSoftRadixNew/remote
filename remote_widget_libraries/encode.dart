// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// This file is hand-formatted.

import 'dart:io';

import 'package:rfw/formats.dart';

void main() {
  final String counterApp1 = File('remote_widget_libraries/counter_app1.rfwtxt').readAsStringSync();
  File('remote_widget_libraries/counter_app1.rfw').writeAsBytesSync(encodeLibraryBlob(parseLibraryFile(counterApp1)));
  final String counterApp2 = File('remote_widget_libraries/counter_app2.rfwtxt').readAsStringSync();
  File('remote_widget_libraries/counter_app2.rfw').writeAsBytesSync(encodeLibraryBlob(parseLibraryFile(counterApp2)));
}
