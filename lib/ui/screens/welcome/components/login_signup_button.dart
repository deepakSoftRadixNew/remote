import 'package:flutter/material.dart';
import 'package:remote/ui/screens/login/login_screen.dart';
import 'package:rfw/rfw.dart';

import '../../../constants.dart';

class LoginAndSignupBtn extends StatelessWidget {
  final Runtime runtime;
  final DynamicContent data;
  LoginAndSignupBtn({
    Key? key,
    required this.runtime,
    required this.data,
  }) : super(key: key) {
    // // runtime.update(localName, createLocalWidgets(data: data, runtime: runtime));
    // runtime.update(
    //     const LibraryName(<String>['core', 'widgets']), createCoreWidgets());
    // //using core material
    // runtime.update(const LibraryName(<String>['core', 'material']),
    //     createMaterialWidgets());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return LoginScreen(
                    data: data,
                    runtime: runtime,
                  );
                },
              ),
            );
          },
          child: Text("Login".toUpperCase()),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryLightColor, elevation: 0),
          child: Text(
            "Sign Up".toUpperCase(),
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
