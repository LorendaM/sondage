import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sondage/views/pages/survey_question_screen.dart';
import 'package:sondage/views/widgets/button_widget.dart';
import 'package:sondage/views/widgets/back_button_widget.dart';
import 'package:sondage/views/widgets/text_widget.dart';

import '../../data/survey_data.dart';
import '../../models/survey_model.dart';
import '../../utils/constant.dart';

class SurveyDescScreen extends StatefulWidget {
   SurveyDescScreen({super.key,required this.surveyModel,});
  SurveyModel surveyModel;
  @override
  State<SurveyDescScreen> createState() => _SurveyDescScreenState();
}

class _SurveyDescScreenState extends State<SurveyDescScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Helper.backApp(
            children: [
        Container(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Expanded(child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child:
                  Center(
                    child: CustomText(
                      data: widget.surveyModel.description,
                      color: Helper.textColor,
                      textSize: 20,
                    ),
                  ),
              )),

              Padding(
                padding: const EdgeInsets.only( left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomElevatedButtonBack(
                      onPressed: (){
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                      child: CustomText(
                        data: "Retour",
                        color: Colors.white,
                        textSize: 16,
                      ),
                    ),
                    CustomElevatedButton(
                        onPressed: (){
                          Get.to(
                                  () => SurveyQuestionScreen(surveyModel: widget.surveyModel,
                              ),
                              transition: Transition.circularReveal);
                        },
                      icon: const Icon(
                      Icons.arrow_forward,
                    ),
                        child: CustomText(
                          data: "Suivant",
                          color: Colors.white,
                          textSize: 16,
                        ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          )
          ),


        ]),
      ),
    );
  }
}
