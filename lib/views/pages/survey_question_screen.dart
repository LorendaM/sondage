import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sondage/views/pages/survey_result_screen.dart';
import 'package:sondage/views/widgets/text_widget.dart';

import '../../data/survey_data.dart';
import '../../models/survey_model.dart';
import '../../models/survey_question_model.dart';
import '../../utils/constant.dart';
import '../../utils/localstorage.dart';
import '../widgets/floating_button_widget.dart';

class SurveyQuestionScreen extends StatefulWidget {
  SurveyQuestionScreen(
      {super.key, required this.surveyModel, this.currentSurveyQuestion});

  SurveyModel surveyModel;
  SurveyQuestionModel? currentSurveyQuestion;

  @override
  State<SurveyQuestionScreen> createState() => _SurveyQuestionScreenState();
}

class _SurveyQuestionScreenState extends State<SurveyQuestionScreen> {
  int currentQuestionIndex = 0;
  List<String> selectedOptions = [];
  String otherOptionText = '';
  TextEditingController controller = TextEditingController();
  TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<SurveyQuestionModel> listOfQuestions = [];
  List<QuestionResponse> userResponses = [];

  @override
  void initState() {
    super.initState();
    listOfQuestions = widget.surveyModel.question;

    userResponses = List.generate(
        listOfQuestions.length,
        (_) => QuestionResponse(
            optionResponse: selectedOptions, textResponse: otherOptionText));
  }

  @override
  Widget build(BuildContext context) {
    SurveyQuestionModel currentSurveyQuestion =
        widget.surveyModel.question[currentQuestionIndex];
    return Scaffold(
      body: SafeArea(
        child: Helper.backApp(children: [
          Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomText(
                            data: currentSurveyQuestion.questionText,
                            color: Helper.textColor,
                            textSize: 20,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          if (currentSurveyQuestion.type ==
                                  QuestionType.MultipleChoice ||
                              currentSurveyQuestion.type ==
                                  QuestionType.SingleChoice)
                            Expanded(
                              child: ListView.builder(
                                itemCount: currentSurveyQuestion.options.length,
                                itemBuilder: (context, index) {
                                  final option =currentSurveyQuestion.options[index];
                                  final bool checked =selectedOptions.contains(option.text);
                                  final bool isSelected =
                                      selectedOptions.contains(option.imageModel?.filename);
                                  final imageModel = option.imageModel;
                                  if (imageModel != null) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      InkWell(
                                        onTap: () {
                                          if (currentSurveyQuestion.type ==
                                              QuestionType.MultipleChoice) {
                                            if (selectedOptions.length <
                                                currentSurveyQuestion
                                                    .requiredOptions) {
                                              setState(() {
                                                if (isSelected) {
                                                  selectedOptions
                                                      .remove(imageModel.filename);
                                                } else {
                                                  selectedOptions.add(imageModel.filename);
                                                }
                                              });
                                            } else {
                                              Helper.showToast(
                                                  'Vous pouvez sélectionner au maximum ${currentSurveyQuestion.requiredOptions} réponses.');
                                            }
                                          } else if (currentSurveyQuestion
                                                  .type ==
                                              QuestionType.SingleChoice) {
                                            setState(() {
                                              selectedOptions.clear();
                                              selectedOptions.add(imageModel.filename);
                                            });
                                          }
                                        },
                                        child: Container(
                                          height: 200,
                                          //alignment: Alignment.centerLeft,
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 2,
                                                color: Colors.grey.shade300),
                                            color: isSelected
                                                ? Helper.kPrimaryColor
                                                : Colors.grey.withOpacity(0.03),
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(8)),
                                          ),
                                          child: Column(
                                            children: [
                                                CustomText(
                                                  data: option.text,
                                                  color: Helper.textColor,
                                                  textSize: 17,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  width: 300,
                                                  height: 150,
                                                  child: Image.asset(
                                                    "assets/images/${imageModel.filename}",
                                                    fit: BoxFit.fitWidth,
                                                  )
                                                )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      )
                                    ],
                                  );
                                  }
                                  else {
                                    return Column(
                                      children: [

                                        InkWell(
                                          onTap: () {
                                            /*if (currentSurveyQuestion.type ==
                                                QuestionType.MultipleChoice) {
                                              if (selectedOptions.length <
                                                  currentSurveyQuestion
                                                      .requiredOptions) {
                                                setState(() {
                                                  if (checked) {
                                                    selectedOptions
                                                        .remove(option.text);
                                                  } else {
                                                    selectedOptions.add(option.text);
                                                  }
                                                });
                                              } else {
                                                Helper.showToast(
                                                    'Vous pouvez sélectionner au maximum ${currentSurveyQuestion.requiredOptions} réponses.');
                                              }
                                            }*/
                                            if (currentSurveyQuestion.type == QuestionType.MultipleChoice) {
                                              if (selectedOptions.contains(option.text)) {
                                                setState(() {
                                                  selectedOptions.remove(option.text);
                                                });
                                              } else {
                                                if (selectedOptions.length < currentSurveyQuestion.requiredOptions) {
                                                  setState(() {
                                                    selectedOptions.add(option.text);
                                                  });
                                                } else {
                                                  Helper.showToast(
                                                      'Vous pouvez sélectionner au maximum ${currentSurveyQuestion.requiredOptions} réponses.'
                                                  );
                                                }
                                              }
                                            }
                                            else if (currentSurveyQuestion
                                                .type ==
                                                QuestionType.SingleChoice) {
                                              setState(() {
                                                selectedOptions.clear();
                                                selectedOptions.add(option.text);
                                              });
                                            }
                                          },
                                          child: Container(
                                            height: 60,
                                            alignment: Alignment.centerLeft,
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 2,
                                                  color: Colors.grey.shade300),
                                              color: checked
                                                  ? Helper.kPrimaryColor
                                                  : Colors.grey.withOpacity(0.03),
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(8)),
                                            ),
                                            child: CustomText(
                                                data: option.text,
                                                color: Helper.textColor,
                                                textSize: 17,
                                              ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        )
                                      ],
                                    );
                                  }
                                },
                              ),
                            )
                          else
                            Container(
                              height: 62,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  color: LocalStorage.isDarkTheme
                                      ? Colors.white.withOpacity(0.03)
                                      : Colors.black.withOpacity(0.03),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8))),
                              child: TextField(
                                controller: controller,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: LocalStorage.isDarkTheme
                                            ? Colors.transparent
                                            : Colors.grey.shade200,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: LocalStorage.isDarkTheme
                                              ? Colors.transparent
                                              : Colors.grey.shade200,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(5)),
                                  filled: LocalStorage.isDarkTheme,
                                  hintText: "Saisissez votre réponse ",
                                  hintStyle: const TextStyle(fontSize: 16),
                                  fillColor: LocalStorage.isDarkTheme
                                      ? Colors.white10
                                      : Colors.grey.shade100,
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingButtonWidget(
                      color: Helper.kPrimaryColor,
                      onPressed: () {
                        _retour();
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
                      width: 130,
                      child: ElevatedButton(
                        onPressed: () {
                          //_nextQuestion();
                          _suivant();
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Helper.kPrimaryColor),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  side: BorderSide(
                                    color: Helper.kPrimaryColor,
                                  )),
                            ),
                            elevation: MaterialStateProperty.all(0)),
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
          ),
        ]),
      ),
    );
  }

  _retour() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    } else {
      Get.back();
    }
  }

  _nextQuestion() {
    if (widget.currentSurveyQuestion?.type == QuestionType.MultipleChoice ||
        widget.currentSurveyQuestion?.type == QuestionType.SingleChoice) {
      if (selectedOptions.isNotEmpty) {
        if (selectedOptions.length ==
            widget.currentSurveyQuestion!.requiredOptions) {
          print(
              'Réponses de l\'utilisateur pour la question ${currentQuestionIndex + 1}: $selectedOptions');
          if (selectedOptions.contains("Autre")) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Option Autre"),
                  content: Container(
                    height: 62,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: LocalStorage.isDarkTheme
                          ? Colors.white.withOpacity(0.03)
                          : Colors.black.withOpacity(0.03),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: TextFormField(
                      controller: _controller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Veuillez compléter ce champ";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: LocalStorage.isDarkTheme
                                ? Colors.transparent
                                : Colors.grey.shade200,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: LocalStorage.isDarkTheme
                                ? Colors.transparent
                                : Colors.grey.shade200,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        filled: LocalStorage.isDarkTheme,
                        hintText: "Saisissez votre réponse",
                        hintStyle: const TextStyle(fontSize: 13.1),
                        fillColor: LocalStorage.isDarkTheme
                            ? Colors.white10
                            : Colors.grey.shade100,
                      ),
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          otherOptionText = _controller.text;
                          Navigator.pop(context);
                          onTextResponseChanged(
                              currentQuestionIndex, otherOptionText);
                          // Passer à la question suivante
                          _proceedToNextQuestion();
                        } else {
                          Get.snackbar(
                            'Réponse manquante',
                            'Veuillez saisir une réponse.',
                          );
                        }
                      },
                      child: Text("OK"),
                    ),
                  ],
                );
              },
            );
            return;
          } else {
            _proceedToNextQuestion();
          }
        } else {
          Helper.showToast(
              'Veuillez sélectionner ${widget.currentSurveyQuestion?.requiredOptions} réponses pour cette question.');
        }
        /*else if (currentQuestionIndex < widget.surveyModel.questions.length - 1) {
          // Enregistrer la réponse de l'utilisateur dans userResponses
          userResponses.add(QuestionResponse(
            questionIndex: currentQuestionIndex,
            response: _controller.text,
          ));
          setState(() {
            currentQuestionIndex++;
            selectedOptions.clear();
          });
        } else {
          // Enregistrer la dernière réponse de l'utilisateur avant de passer à l'écran de résultats
          userResponses.add(QuestionResponse(
            questionIndex: currentQuestionIndex,
            response: _controller.text,
          ));
          Get.to(
                () => SurveyResultScreen(
              surveyModel: widget.surveyModel,
              userResponses: userResponses,
              totalQuestions: widget.surveyModel.questions.length,
            ),
            transition: Transition.circularReveal,
          );
        }*/
      } else {
        Get.snackbar(
          'Réponse manquante',
          'Veuillez sélectionner au moins une réponse.',
        );
        return;
      }
    } else if (widget.currentSurveyQuestion?.type == QuestionType.Text) {
      if (otherOptionText.isNotEmpty) {
        onOptionSelected(currentQuestionIndex, selectedOptions);
        print('**********************');
        print('Réponse de l\'utilisateur pour la question ${currentQuestionIndex + 1}: $otherOptionText');
        print('**********************');
        _proceedToNextQuestion();
      } else {
        Get.snackbar(
          'Réponse manquante',
          'Veuillez saisir une réponse.',
        );
      }
      return;
    }
    _proceedToNextQuestion();
  }

  _suivant() {
    /*if (userResponses[currentQuestionIndex].optionResponse.isNotEmpty||
        userResponses[currentQuestionIndex].textResponse.isNotEmpty){
      if (widget.currentSurveyQuestion?.type == QuestionType.MultipleChoice ||
          widget.currentSurveyQuestion?.type == QuestionType.SingleChoice) {
        if (selectedOptions.isNotEmpty) {
          if (selectedOptions.length ==widget.currentSurveyQuestion?.requiredOptions) {

            print('Réponses de l\'utilisateur pour la question ${currentQuestionIndex + 1}: $selectedOptions');
            if (selectedOptions.contains("Autre")) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Option Autre"),
                    content: Container(
                      height: 62,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: LocalStorage.isDarkTheme
                            ? Colors.white.withOpacity(0.03)
                            : Colors.black.withOpacity(0.03),
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: TextFormField(
                        controller: _controller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Veuillez compléter ce champ";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: LocalStorage.isDarkTheme
                                  ? Colors.transparent
                                  : Colors.grey.shade200,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: LocalStorage.isDarkTheme
                                  ? Colors.transparent
                                  : Colors.grey.shade200,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          filled: LocalStorage.isDarkTheme,
                          hintText: "Saisissez votre réponse",
                          hintStyle: const TextStyle(fontSize: 13.1),
                          fillColor: LocalStorage.isDarkTheme
                              ? Colors.white10
                              : Colors.grey.shade100,
                        ),
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          if (_controller.text.isNotEmpty) {
                            otherOptionText = _controller.text;
                            Navigator.pop(context);
                            onTextResponseChanged(
                                currentQuestionIndex, otherOptionText);
                            // Passer à la question suivante
                            _proceedToNextQuestion();
                          } else {
                            Get.snackbar(
                              'Réponse manquante',
                              'Veuillez saisir une réponse.',
                            );
                          }
                        },
                        child: Text("OK"),
                      ),
                    ],
                  );
                },
              );
              return;
            }
            else {
              _proceedToNextQuestion();
            }
          }
          else {
            Helper.showToast(
                'Veuillez sélectionner ${widget.currentSurveyQuestion?.requiredOptions} réponses pour cette question.');
          }
        }
        else {
          Get.snackbar(
            'Réponse manquante',
            'Veuillez sélectionner au moins une réponse.',
          );
          return;
        }
      }
      else{
        if (otherOptionText.isNotEmpty) {
          onOptionSelected(currentQuestionIndex, selectedOptions);
          print('**********************');
          print('Réponse de l\'utilisateur pour la question ${currentQuestionIndex + 1}: $otherOptionText');
          print('**********************');
          _proceedToNextQuestion();
        }
        else {
          Get.snackbar(
            'Réponse manquante',
            'Veuillez saisir une réponse.',
          );
        }
        return Get.snackbar(
          'Réponse manquante',
          'Veuillez saisir une réponse.',
        );
      }
    }
    else{
      Get.snackbar(
        'Réponse manquante',
        'Il faut au moins une réponse.',
      );
    }*/
    if (userResponses[currentQuestionIndex].optionResponse.isNotEmpty ||
        userResponses[currentQuestionIndex].textResponse.isNotEmpty) {
      if (widget.currentSurveyQuestion?.type == QuestionType.MultipleChoice ||
          widget.currentSurveyQuestion?.type == QuestionType.SingleChoice) {
        if (selectedOptions.isNotEmpty) {
          if (selectedOptions.length ==
              widget.currentSurveyQuestion?.requiredOptions) {
            print(
                'Réponses de l\'utilisateur pour la question ${currentQuestionIndex + 1}: $selectedOptions');
            if (selectedOptions.contains("Autre")) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    // ... (rest of the dialog setup)
                  );
                },
              );
              return;
            } else {
              _proceedToNextQuestion();
            }
          } else {
            Helper.showToast(
                'Veuillez sélectionner ${widget.currentSurveyQuestion?.requiredOptions} réponses pour cette question.');
          }
        } else {
          Get.snackbar(
            'Réponse manquante',
            'Veuillez sélectionner au moins une réponse.',
          );
          return;
        }
      } else {
        if (otherOptionText.isNotEmpty) {
          onOptionSelected(currentQuestionIndex, selectedOptions);
          print('**********************');
          print(
              'Réponse de l\'utilisateur pour la question ${currentQuestionIndex + 1}: $otherOptionText');
          print('**********************');
          _proceedToNextQuestion();
        } else {
          Get.snackbar(
            'Réponse manquante',
            'Veuillez saisir une réponse.',
          );
        }
      }
    } else {
      Get.snackbar(
        'Réponse manquante',
        'Il faut au moins une réponse.',
      );
    }

  }

  onOptionSelected(int questionIndex, List<String> selectedOptions) {
    setState(() {
      userResponses[questionIndex].optionResponse = selectedOptions;
      print('Question $questionIndex - Options: $selectedOptions');
    });
  }

  onTextResponseChanged(int questionIndex, String textResponse) {
    setState(() {
      userResponses[questionIndex].textResponse = textResponse;
      print('Question $questionIndex - Text Response: $textResponse');
    });
  }

  _proceedToNextQuestion() {
    if (currentQuestionIndex < widget.surveyModel.question.length - 1) {
      setState(() {
        currentQuestionIndex++;
        onOptionSelected(currentQuestionIndex, selectedOptions);
        onTextResponseChanged(currentQuestionIndex, otherOptionText);
        selectedOptions.clear();
      });
    } else {
      Get.to(
          () => SurveyResultScreen(
                userResponses: userResponses,
                questions: widget.surveyModel.question,
              ),
          transition: Transition.circularReveal);
    }
  }
}
