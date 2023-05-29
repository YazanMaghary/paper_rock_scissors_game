import 'dart:math';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List rand = ["paper.png", "R.png", "scissors.png"];
  // ignore: non_constant_identifier_names
  late String rand_choise = rand[0];
  // ignore: non_constant_identifier_names
  late String rand_choise2 = rand[1];
  List<Icon> icons2 = [];
  int counterWin = 0;
  int counterLose = 0;
  Icon? random() {
    setState(() {
      rand_choise2 = rand[Random().nextInt(rand.length)];
      if (rand_choise == "paper.png" && rand_choise2 == "R.png") {
        counterWin++;
        icons2.add(const Icon(
          Icons.thumb_up,
          size: 30,
          color: Colors.green,
        ));
      } else if (rand_choise == "paper.png" && rand_choise2 == "scissors.png") {
        counterLose++;
        icons2.add(const Icon(Icons.thumb_down, size: 30, color: Colors.red));
      } else if (rand_choise == "R.png" && rand_choise2 == "paper.png") {
        counterLose++;
        icons2.add(const Icon(Icons.thumb_down, size: 30, color: Colors.red));
      } else if (rand_choise == "R.png" && rand_choise2 == "scissors.png") {
        counterWin++;
        icons2.add(const Icon(
          Icons.thumb_up,
          size: 30,
          color: Colors.green,
        ));
      } else if (rand_choise == "scissors.png" && rand_choise2 == "paper.png") {
        counterWin++;
        icons2.add(const Icon(Icons.thumb_up, size: 30, color: Colors.green));
      } else if (rand_choise == "scissors.png" && rand_choise2 == "R.png") {
        counterLose++;
        icons2.add(const Icon(Icons.thumb_down, size: 30, color: Colors.red));
      } else {
        icons2.add(const Icon(Icons.handshake, size: 30, color: Colors.yellow));
      }
      if (icons2.length >= 12) {
        AwesomeDialog(
          dismissOnTouchOutside: false,
          context: context,
          dialogType:
              counterWin > counterLose ? DialogType.success : DialogType.error,
          animType: AnimType.scale,
          title: "Game Result!",
          desc: counterWin > counterLose
              ? "Winner \nResult $counterWin / $counterLose"
              : "Looser \nResult $counterWin / $counterLose",
          descTextStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          btnOkOnPress: () {
            icons2.clear();
            counterLose = 0;
            counterWin = 0;
          },
        ).show();
      }
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1a237e),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Rock Paper Scissors"),
        backgroundColor: const Color(0xff1a237e),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              children: icons2,
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Image.asset("images/$rand_choise"),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "You",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "VS",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Expanded(
                    child: Column(
                  children: [
                    Image.asset("images/$rand_choise2"),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "System",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )
                  ],
                ))
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: InkWell(
                      splashFactory: NoSplash.splashFactory,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        random();
                        rand_choise = rand[0];
                      },
                      child: Image.asset("images/paper.png"),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: InkWell(
                      splashFactory: NoSplash.splashFactory,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        random();
                        rand_choise = rand[1];
                      },
                      child: Image.asset("images/R.png"),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: InkWell(
                      splashFactory: NoSplash.splashFactory,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        random();
                        rand_choise = rand[2];
                      },
                      child: Image.asset("images/scissors.png"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
