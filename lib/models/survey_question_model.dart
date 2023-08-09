import 'dart:convert';
import 'image_model.dart';

SurveyQuestionModel surveyQuestionFromJson(String str) => SurveyQuestionModel.fromJson(json.decode(str));

String surveyQuestionToJson(SurveyQuestionModel data) => json.encode(data.toJson());

class SurveyQuestionModel {
  String questionText;
  QuestionType type;
  List<OptionModel> options;
  int requiredOptions;
  List<ImageModel>? imageModel;

  SurveyQuestionModel({required this.questionText,required this.type, required this.requiredOptions , required this.options, this.imageModel});

  factory SurveyQuestionModel.fromJson(Map<String, dynamic> json) {
   List<dynamic>? imageList = json['imageModel'] as List<dynamic>?;

    List<ImageModel>? imageModel;
    if (imageList != null) {
      imageModel = imageList.map((x) => ImageModel.fromJson(x)).toList();
    }

    return SurveyQuestionModel(
        questionText: json["questionText"],
        type: json["type"],
        options: json["options"],
        requiredOptions: json["requiredOptions"],
        imageModel: imageModel?? [],
    );
  }


  Map<String, dynamic> toJson() => {
    "questionText": questionText,
    "type": type,
    "options": options,
    "requiredOptions": requiredOptions,
    "imageModel": imageModel,
  };

}
class OptionModel {
  String text;
  ImageModel? imageModel;

  OptionModel({required this.text, this.imageModel});
}

enum QuestionType {
  SingleChoice,
  MultipleChoice,
  Text,
}

class QuestionResponse {
  List<String> optionResponse;
  String textResponse;

  QuestionResponse({ this.optionResponse = const [], this.textResponse = ''});
}

