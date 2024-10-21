import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double dx = 100.0, dy = 100.0;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Flutter Sensors",
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.blue,
              centerTitle: true,
            ),
            body: StreamBuilder<GyroscopeEvent>(
              stream: SensorsPlatform.instance.gyroscopeEventStream(),
              builder: (_, snapshot) {

                if (snapshot.hasData) {
                  dx = dx + (snapshot.data!.y * 10);
                  dy = dy + (snapshot.data!.x * 10);

                  // set boundary for dx
                  if (dx < 1) {
                    dx = 1; // Left boundary
                  } else if (dx > 263) {
                    dx = 263; // Right boundary
                  }

                  // set boundary for dy
                  if (dy < 1) {
                    dy = 1; // Top boundary
                  } else if (dy > 565) {
                    dy = 565; // Bottom boundary
                  }
                }
                return Transform.translate(
                    offset: Offset(dx, dy),
                    child: Image.asset('assets/images/BasketBall.png',fit:BoxFit.cover, height: 100));
              },
            )));
  }
}
