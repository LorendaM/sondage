import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:sondage/views/pages/survey_desc_screen.dart';
import 'package:sondage/views/widgets/text_widget.dart';

import '../../data/survey_data.dart';
import '../../utils/constant.dart';
import '../../utils/localstorage.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  @override
  Widget build(BuildContext context) {
    String title = "";
    return Scaffold(
        body: Builder(
          builder: (context) {
            List searchList = surveys
                .where((element) => element.title
                .toString()
              .toUpperCase()
              .contains(title.toUpperCase()))
            .toList();
            return SafeArea(
              child: Helper.backApp(
                  children: [
                Container(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                       Padding(
                         padding: const EdgeInsets.only(left: 15, right: 15),
                         child: Container(
                           alignment: Alignment.center,
                           decoration: BoxDecoration(
                               border: Border.all(
                                   color: Colors.grey),
                               color: LocalStorage.isDarkTheme
                                   ?Colors.white.withOpacity(0.03)
                                   :Colors.black.withOpacity(0.03),
                               borderRadius:
                               const BorderRadius.all(Radius.circular(8))),
                           height: 62,
                           child: TextField(
                             decoration: InputDecoration(
                               border: OutlineInputBorder(
                                 borderSide:
                                 BorderSide(color: LocalStorage.isDarkTheme ? Colors.transparent : Colors.grey.shade200, width: 1),
                                 borderRadius: BorderRadius.circular(5),
                               ),
                               enabledBorder: OutlineInputBorder(
                                   borderSide:
                                   BorderSide(color: LocalStorage.isDarkTheme ? Colors.transparent : Colors.grey.shade200, width: 1),
                                   borderRadius: BorderRadius.circular(5)),
                               filled: LocalStorage.isDarkTheme,
                               hintText: "Rechercher ",
                               prefixIcon: Icon(Icons.search),
                               hintStyle: TextStyle(fontSize: 13.1),
                               fillColor: LocalStorage.isDarkTheme ? Colors.white10 : Colors.grey.shade100,
                             ),
                           ),
                         ),
                       ),
                      Expanded(
                          child: Padding(
                              padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(
                                      decelerationRate: ScrollDecelerationRate.fast),
                                  itemCount: surveys.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    var element = surveys[index];

                                    return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(
                                                  () =>  SurveyDescScreen(surveyModel: element,),
                                              transition: Transition.circularReveal);
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                                color: LocalStorage.isDarkTheme
                                                    ?Colors.white.withOpacity(0.03)
                                                    :Colors.black.withOpacity(0.03),
                                                borderRadius:
                                                const BorderRadius.all(Radius.circular(8))),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                        height: 80,
                                                        width: 100,
                                                        child: Image(
                                                            image: AssetImage("assets/images/todo-list-icon-17.jpg"))
                                                    ),
                                                    const SizedBox(
                                                        height: 30,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        CustomText(
                                                          data:element.title,
                                                          //"Bienvenue dans la communaute Gratis, dites-nous en plus!",
                                                          color: Helper.textColor,
                                                          textSize: 19,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        CustomText(
                                                          data: "${element.point} points",
                                                          color: Helper.textColor,
                                                          textSize: 17,
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                CustomText(
                                                  data:
                                                  '''Nouvelle enquete !''',
                                                  color: Helper.textColor,
                                                  textSize: 17,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                CustomText(
                                                  data:
                                                  '''Completez-la maintenant''',
                                                  color: Helper.textColor,
                                                  textSize: 17,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                const Divider(
                                                  height: 5,
                                                  color: Colors.black,
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                CustomText(
                                                  data: "${element.time} minutes de votre temps",
                                                  color: Helper.textColor,
                                                  textSize: 17,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ]);
                                  }))
                      )
                    ],
                  ),
                ),
              ]),
            );
          }
        ));
  }
}
