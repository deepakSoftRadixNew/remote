import 'package:flutter/material.dart';
import 'package:remote/ui/screens/login/components/login_form.dart';
import 'package:remote/ui/screens/login/components/login_screen_top_image.dart';
import 'package:rfw/rfw.dart';

class LoginScreen extends StatelessWidget {
  final Runtime runtime;
  final DynamicContent data;
  LoginScreen({
    Key? key,
    required this.runtime,
    required this.data,
  }) : super(key: key) {
    // runtime.update(localName, _createLocalWidgets());
    // runtime.update(
    //     const LibraryName(<String>['core', 'widgets']), createCoreWidgets());
    // //using core material
    // runtime.update(const LibraryName(<String>['core', 'material']),
    //     createMaterialWidgets());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              SizedBox(height: 50),
              const LoginScreenTopImage(),
              Row(
                children: const [
                  Spacer(),
                  Expanded(
                    flex: 8,
                    child: LoginForm(),
                  ),
                  Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // static WidgetLibrary _createLocalWidgets() {
  //   return LocalWidgetLibrary(<String, LocalWidgetBuilder>{
  //     "LoginForm": (context, source) {
  //       return LoginForm();
  //     },
  //   });
  // }

  // static const LibraryName localName = LibraryName(<String>['local']);
  // static const LibraryName remoteName = LibraryName(<String>['remote']);

  // Widget getWidget(
  //     {required String name,
  //     required Runtime runtime,
  //     required DynamicContent data}) {
  //   return RemoteWidget(
  //     runtime: runtime,
  //     data: data,
  //     widget: const FullyQualifiedWidgetName(
  //         LibraryName(<String>['main']), 'welcome'),
  //     onEvent: (String name, DynamicMap arguments) {
  //       debugPrint('user triggered event "$name" with data: $arguments');
  //     },
  //   );
  // }
}
