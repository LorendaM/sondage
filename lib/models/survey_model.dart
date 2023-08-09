import 'dart:convert';
import 'package:sondage/models/survey_question_model.dart';

SurveyModel surveyFromJson(String str) => SurveyModel.fromJson(json.decode(str));

String surveyToJson(SurveyModel data) => json.encode(data.toJson());

class SurveyModel{
  int id;
  String title;
  String description;
  int point;
  int time;
  List<SurveyQuestionModel> question;
  List<List<String>> ?userResponses;

  SurveyModel({
    required this.id,
    required this.title,
    required this.description,
    required this.point,
    required this.time,
    required this.question,
     this.userResponses,

  });

  factory SurveyModel.fromJson(Map<String, dynamic> json) => SurveyModel(
    id: json["id"],
    time: json["time"],
    title: json["title"],
    description: json["description"],
    point: json["point"],
    question: json["question"],
    userResponses: json["userResponses"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "time": time,
    "description": description,
    "point": point,
    "question": question,
    "userResponses": userResponses,
  };
}


