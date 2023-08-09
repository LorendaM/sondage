import 'package:sondage/models/survey_model.dart';

import '../models/image_model.dart';
import '../models/survey_question_model.dart';

List<SurveyModel> surveys = [
  SurveyModel(
    id: 1,
    title: 'A propos de gratis',
    point: 25,
    time: 3,
    description: '''Merci de participer a ce sondage. Nous vous prions de bien vouloir répondre à nos questions pour nous aider à mieux vous servir. Vous gagnerez à la fin de ce sondage des point qui vous permettrons de jouer.  ''',
    question: [
      SurveyQuestionModel(
        questionText: 'Comment avez vous connu gratis ?',
        type: QuestionType.MultipleChoice,
        requiredOptions: 2,
        options: [
          OptionModel(text: "De moi meme",),
          OptionModel(text: "Par des amis"),
          OptionModel(text: "Par un de vos partenaire"),
          OptionModel(text: "Par les résaux sociaux"),
        ],
      ),
      SurveyQuestionModel(
        questionText: "Depuis combien de temps l'utilisez-vous?",
        type: QuestionType.SingleChoice,
        requiredOptions: 1,
        options: [
          OptionModel(text: "Quelques jours",),
          OptionModel(text: "Une semaine"),
          OptionModel(text: "Deux semaines"),
          OptionModel(text: "Un mois"),
          OptionModel(text: "Plus d'un mois"),
          OptionModel(text: "Autre"),
        ],
      ),
      SurveyQuestionModel(
        questionText: 'Etes-vous satisfait de gratis ?',
        type: QuestionType.Text,
        options: [],
      ),
      SurveyQuestionModel(
        questionText: 'Quel amelioration vous aimeriez voir dans les prochaines version de gratis ?',
        type: QuestionType.SingleChoice,
        options: [
          OptionModel(text: "Oui",),
          OptionModel(text: "Non"),
          OptionModel(text: "Un peu"),
        ],
      ),
    ],
  ),
  SurveyModel(
    id: 1,
    title: 'Gratis en image',
    point: 105,
    time: 5,
    description: '''Merci de participer a ce sondage. Nous vous prions de bien vouloir répondre à nos questions pour nous aider à mieux vous servir. Vous gagnerez à la fin de ce sondage des point qui vous permettrons de jouer.  ''',
    question: [
      SurveyQuestionModel(
        questionText: 'Quel est votre préférence ?',
        type: QuestionType.SingleChoice,
        requiredOptions: 1,
        options: [
          OptionModel(
              imageModel:
              ImageModel(
                filename: "logo.png",
                mimeType: "image/png",
                extension: "png",
                type: "question_image",
              ),
              text: 'Logo A'),
          OptionModel(
              imageModel:
              ImageModel(
                filename: "logo-white.png",
                mimeType: "image/png",
                extension: "png",
                type: "question_image",
              ),
              text: 'Logo B'),
        ],
      ),
      SurveyQuestionModel(
        questionText: 'Quel est votre préféreé?',
        type: QuestionType.SingleChoice,
        requiredOptions: 1,
        options: [
          OptionModel(
              imageModel:
            ImageModel(
              filename: "gateaux_1.jpg",
              mimeType: "image/jpeg",
              extension: "jpg",
              type: "question_image",
            ),
           text: 'Gateaux A'),
          OptionModel(
              imageModel:
          ImageModel(
            filename: "gateaux_2.jpg",
            mimeType: "image/jpeg",
            extension: "jpg",
            type: "question_image",
          ),
          text: 'Gateaux B'),
        ],
      ),
    ],
  ),

];

