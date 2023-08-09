
import 'dart:math';

import 'package:animation_wrappers/animations/scale_animation.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sondage/views/pages/survey_screen.dart';
import 'package:sondage/views/widgets/button_widget.dart';
import 'package:sondage/views/widgets/text_widget.dart';

import '../../models/survey_model.dart';
import '../../models/survey_question_model.dart';
import '../../utils/constant.dart';
import '../../utils/localstorage.dart';

class SurveyResultScreen extends StatefulWidget {
  final List<SurveyQuestionModel> questions;
  final List<QuestionResponse> userResponses;

  SurveyResultScreen({
    required this.userResponses,
    required this.questions,
  });

  @override
  State<SurveyResultScreen> createState() => _SurveyResultScreenState();
}

class _SurveyResultScreenState extends State<SurveyResultScreen> {
  late ConfettiController confettiController;

  @override
  void initState() {
    super.initState();
    confettiController =
        ConfettiController(duration: const Duration(seconds: 10));
    confettiController.play();
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int totalQuestions = widget.questions.length;
    double progress = widget.userResponses.length / totalQuestions;

    return Scaffold(
      body: SafeArea(
        child: Helper.backApp(children: [
          Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.asset(
                          "assets/images/logo.png",
                          fit: BoxFit.fitWidth,
                        )
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      data: "!!! Felicitation Username !!!",
                      color: Helper.textColor,
                      textSize: 20,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomText(
                      data: "Merci d'avoir participe a ce sondage!",
                      color: Helper.textColor,
                      textSize: 20,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                LinearProgressIndicator(
                  value: widget.userResponses.length / totalQuestions,
                  backgroundColor: Helper.kPrimaryColor,
                ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomText(
                      data:
                      '''Gardez un oeil sur l\'application nous vous informerons des nouvelles possibilite de participer a des sondage et de gagner des points. Vous trouverez tous les sondages auxquels vous n\'avez pas encore participer''',
                      color: Helper.textColor,
                      textSize: 18,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomText(
                      data: "A bientot sur Gratis",
                      color: Helper.textColor,
                      textSize: 20,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                Get.to(
                () => const SurveyScreen(),
                transition: Transition
                    .circularReveal);
                },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Helper.kPrimaryColor),
                        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        ),
                        elevation: MaterialStateProperty.all(0)
                    ),
                    child: CustomText(
                      data: "Continuer",
                      color: Helper.textColor,
                      textSize: 16,
                    ),
                  ),
                )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            child: SizedBox(
              height: Get.height,
              child: RotatedBox(
                quarterTurns: 1,
                child: ConfettiWidget(
                  maxBlastForce: 5,
                  minBlastForce: 1,
                  emissionFrequency: 0.9,
                  gravity: 0.9,
                  numberOfParticles: 20,
                  blastDirection: pi,
                  confettiController: confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: true,
                  colors: const [Colors.green,Colors.blue,Colors.pink, Colors.orange,Colors.purple
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}


