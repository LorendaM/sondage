import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sondage/views/pages/survey_question_screen.dart';
import 'package:sondage/views/widgets/floating_button_widget.dart';
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
                    FloatingButtonWidget(
                      color: Helper.kPrimaryColor,
                      onPressed: (){
                        Get.back();
                      },
                      icon: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_back)),
                      child: CustomText(
                        data: "Retour",
                        color: Colors.white,
                        textSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 55,
                      width:  130,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(
                                  () => SurveyQuestionScreen(surveyModel: widget.surveyModel,
                              ),
                              transition: Transition.circularReveal);
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Helper.kPrimaryColor),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                                side: BorderSide(
                                  color: Helper.kPrimaryColor,
                                )
                            ),
                            ),
                            elevation: MaterialStateProperty.all(0)
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              data: "Suivant",
                              color: Colors.white,
                              textSize: 16,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_forward,
                              ),
                            ),
                          ],
                        ),
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
