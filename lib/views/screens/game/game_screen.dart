import 'dart:math';

import 'package:animal_game/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Helper/GenerateAnimalList.dart';
import '../../../models/Animal.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool finishGame = false;
  bool btnResumeVisibility = true;
  String messageTitle = "";
  Color messageColor = Colors.red;
  int wrongAnswer = 0;
  int correctAnswer = 0;
  int round = 1;
  static Random rnd = Random();

  List<Animal> list = GenerateAnimalList().getRandomAnimal();
  String strAnimalName = (GenerateAnimalList().getRandomAnimal()..shuffle())
      .elementAt(rnd.nextInt(6))
      .name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.jpeg"),
                fit: BoxFit.cover)),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomText(text: "${'correct'.tr} : $correctAnswer"),
                      CustomText(text: "${'wrong'.tr} : $wrongAnswer / 3 "),
                      CustomText(text: "${'round'.tr} : $round"),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              endGame();
                            });
                          },
                          icon: const Icon(Icons.restart_alt)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GridView.builder(
                    itemCount: list.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1 / 1,
                            crossAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      return IgnorePointer(
                        ignoring: finishGame,
                        child: Draggable(
                            feedback: Opacity(
                              opacity: 0.8,
                              child: Image.asset(
                                list[index].image,
                                width: 96,
                              ),
                            ),
                            data: list[index].name,
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40))),
                              elevation: 4,
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                    color: Colors.lightGreen),
                                // color: Colors.green.shade200,
                                child: Image.asset(
                                  list[index].image,
                                  width: 32,
                                ),
                              ),
                            )),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 50),
              DragTarget(
                onWillAccept: (data) => true,
                onAccept: (data) {
                  setState(() {
                    if (data == strAnimalName) {
                      // print("Correct");
                      generateSnackbar('correct'.tr, Colors.green);
                      correctAnswer++;
                    } else {
                      // print("Wrong");
                      generateSnackbar('wrong'.tr, Colors.redAccent);
                      wrongAnswer++;
                      if (wrongAnswer == 3) {
                        btnResumeVisibility = false;
                        finishGame = true;
                        endGame();
                      }
                    }
                    list = GenerateAnimalList().getRandomAnimal();
                    Random rnd = Random();
                    strAnimalName =
                        (list..shuffle()).elementAt(rnd.nextInt(6)).name;
                    round++;
                  });
                },
                builder: (context, candidateData, rejectedData) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/cave.png")),
                        ),
                        alignment: Alignment.center,
                        width: 250,
                        height: 200,
                      ),
                      Stack(alignment: Alignment.center, children: [
                        Image.asset("assets/images/wood_arrow.png", width: 130),
                        Positioned(
                          top: 40,
                          left: 25,
                          child: SizedBox(
                            width: 100,
                            child: Center(
                              child: Text(
                                textAlign: TextAlign.center,
                                strAnimalName,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ],
                  );
                },
              ),
              const SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }

  void generateSnackbar(
    String message,
    Color color,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 500),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(bottom: 200, left: 150, right: 150),
      content: Text(message, textAlign: TextAlign.center),
    ));
  }

  void restartGame() {
    list = GenerateAnimalList().getRandomAnimal();
    strAnimalName = (list..shuffle()).elementAt(rnd.nextInt(6)).name;
    btnResumeVisibility = true;
    round = 1;
    correctAnswer = 0;
    wrongAnswer = 0;
    finishGame = false;
  }

  void endGame() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Column(
              children: [
                Center(
                    child: CustomText(
                  text: 'game_over'.tr,
                )),
                const Divider(
                  color: Colors.black,
                )
              ],
            ),
            content: SizedBox(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CustomText(text: "${'max_round'.tr} : ${round - 1}"),
                  CustomText(text: "${'your_rank'.tr} : $correctAnswer"),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              Navigator.of(context).pop(true);
                              restartGame();
                            });
                          },
                          child: CustomText(
                            text: 'restart'.tr,
                          )),
                      Visibility(
                          visible: btnResumeVisibility,
                          child: const SizedBox(
                            width: 20,
                          )),
                      Visibility(
                        visible: btnResumeVisibility,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: CustomText(
                              text: 'resume'.tr,
                            )),
                      )
                    ],
                  )
                ],
              ),
            ));
      },
    );
  }
}
