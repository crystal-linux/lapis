import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arch 2 Crystal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Arch 2 Crystal'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  run(setOutput, running, setRunning) async {
    if (!running) {
      var process =
          await Process.start('pkexec', ['/opt/lapis/scripts/convert.sh']);
      process.stdout.transform(utf8.decoder).forEach(setOutput);
      setRunning(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    String output = "";
    bool running = false;
    run(
        (value) {
          setState(() {
            output = output + "\n" + value;
          });
        },
        running,
        () {
          setState(() {
            running = true;
          });
        });
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 23, 23, 23),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 600,
              height: 300,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black),
                color: Color.fromARGB(255, 15, 15, 15),
              ),
              child: SingleChildScrollView(
                reverse: true,
                child: Text(
                  "test",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Monospace',
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
            ),
            Text(
              output
                      .toString()
                      .contains("Installation finished! You may reboot now!")
                  ? "Conversion finished, you can close this window now! Have fun with crystal!"
                  : "Please do not close this window until the conversion is finished.",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 169, 0, 255),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
