import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _channel = "com.udemy.native_iop/battery";
  static const _getBatteryLevelMethod = "getBatteryLevel";

  String _level = "<unknown>";

  Future<void> _getBatteryLevel() async {
    try {
      const platform = MethodChannel(_channel);

      final batteryLevel =
          await platform.invokeMethod<int>(_getBatteryLevelMethod);

      setState(() => _level = batteryLevel?.toString() ?? "<unknown>");
    } catch (error) {
      if (kDebugMode) {
        print("Unexpected error: ${error.runtimeType}");
        print("${error.runtimeType}: $error");
      }
      setState(() => _level = "<error>");
    }
  }

  @override
  void initState() {
    super.initState();

    _getBatteryLevel();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Native IOp"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Battery Level: ",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _level,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
