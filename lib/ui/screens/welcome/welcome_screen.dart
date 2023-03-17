import 'package:flutter/material.dart';
import 'package:remote/ui/screens/welcome/components/login_signup_button.dart';
import 'package:remote/ui/screens/welcome/components/welcome_image.dart';
import 'package:rfw/rfw.dart';

import '../../components/background.dart';

class WelcomeScreen extends StatelessWidget {
  final Runtime runtime;
  final DynamicContent data;
  WelcomeScreen({
    Key? key,
    required this.runtime,
    required this.data,
  }) : super(key: key) {
    runtime.update(localName, createLocalWidgets(data: data, runtime: runtime));
    runtime.update(
        const LibraryName(<String>['core', 'widgets']), createCoreWidgets());
    //using core material
    runtime.update(const LibraryName(<String>['core', 'material']),
        createMaterialWidgets());
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
          child: getWidget(name: "welcome", data: data, runtime: runtime)),
    );
  }

  static WidgetLibrary createLocalWidgets(
      {required Runtime runtime, required DynamicContent data}) {
    return LocalWidgetLibrary(<String, LocalWidgetBuilder>{
      "WelcomeImage": (context, source) {
        return WelcomeImage();
      },
      "LoginAndSignupBtn": (context, source) {
        return LoginAndSignupBtn(
          data: data,
          runtime: runtime,
        );
      }
    });
  }

  static const LibraryName localName = LibraryName(<String>['local']);
  static const LibraryName remoteName = LibraryName(<String>['remote']);

  Widget getWidget(
      {required String name,
      required Runtime runtime,
      required DynamicContent data}) {
    return RemoteWidget(
      runtime: runtime,
      data: data,
      widget: FullyQualifiedWidgetName(LibraryName(<String>['main']), name),
      onEvent: (String name, DynamicMap arguments) {
        debugPrint('user triggered event "$name" with data: $arguments');
      },
    );
  }
}
