import 'package:flutter/material.dart';
import 'package:remote/ui/screens/welcome/components/login_signup_button.dart';
import 'package:remote/ui/screens/welcome/components/welcome_image.dart';
import 'package:rfw/formats.dart';
import 'package:rfw/rfw.dart';

import '../../components/background.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key) {
    _update();
  }

  final Runtime _runtime = Runtime();
  final DynamicContent _data = DynamicContent();

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(child: getWidget(name: "root")

          //  SafeArea(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       WelcomeImage(),
          //       LoginAndSignupBtn(),
          //     ],
          //   ),
          // ),
          ),
    );
  }

  static WidgetLibrary _createLocalWidgets() {
    return LocalWidgetLibrary(<String, LocalWidgetBuilder>{
      'GreenBox': (BuildContext context, DataSource source) {
        return Container(
          color: const Color(0xFF002211),
          child: source.child(<Object>['child']),
        );
      },
      'Hello': (BuildContext context, DataSource source) {
        return Center(
          child: Text(
            'Hello, ${source.v<String>(<Object>["name"])}!',
            textDirection: TextDirection.ltr,
          ),
        );
      },
      "WelcomeImage": (context, source) {
        return WelcomeImage();
      },
      "LoginAndSignupBtn": (context, source) {
        return LoginAndSignupBtn();
      }
    });
  }

  static const LibraryName localName = LibraryName(<String>['local']);
  static const LibraryName remoteName = LibraryName(<String>['remote']);

  void _update() {
    _runtime.update(localName, _createLocalWidgets());
    _runtime.update(
        const LibraryName(<String>['core', 'widgets']), createCoreWidgets());
    //using core material
    _runtime.update(const LibraryName(<String>['core', 'material']),
        createMaterialWidgets());
    // Normally we would obtain the remote widget library in binary form from a
    // server, and decode it with [decodeLibraryBlob] rather than parsing the
    // text version using [parseLibraryFile]. However, to make it easier to
    // play with this sample, this uses the slower text format.
    _runtime.update(remoteName, parseLibraryFile('''
      import local;
      import core.widgets;
      import core.material;  
      widget root = 
      Column(
      mainAxisAlignment: "center",
      children: [ 
      WelcomeImage(),
      LoginAndSignupBtn(),
      ],
    );
    '''));
  }

  Widget getWidget({required String name}) {
    return RemoteWidget(
      runtime: _runtime,
      data: _data,
      widget: FullyQualifiedWidgetName(remoteName, name),
      onEvent: (String name, DynamicMap arguments) {
        debugPrint('user triggered event "$name" with data: $arguments');
      },
    );
  }
}
