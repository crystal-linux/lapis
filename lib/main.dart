import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:window_size/window_size.dart';

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

void setWindowSize() {
  setWindowMinSize(Size(900, 600));
  setWindowMaxSize(Size(900, 600));
}

run(setOutput, running, setRunning) async {
  if (!running) {
    var process = await Process.start('/opt/lapis/scripts/lapisemu.sh', []);
    process.stdout.transform(utf8.decoder).forEach(setOutput);
    setRunning();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  bool running = false;
  String output = "";

  @override
  Widget build(BuildContext context) {
    setWindowSize();
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
                color: const Color.fromARGB(255, 15, 15, 15),
              ),
              child: SingleChildScrollView(
                reverse: true,
                child: Text(
                  output,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Monospace',
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              output.toString().contains("Welcome to Crystal Linux. :)")
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
