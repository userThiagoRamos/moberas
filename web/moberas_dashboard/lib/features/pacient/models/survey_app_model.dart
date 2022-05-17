import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moberas_dashboard/database/globals.dart';

class SurveyAppModel {
  final String dateTime;
  final String entendimento;
  final String indicaria;
  final String navegacao;
  final String representacaoVisual;
  final String utilidade;

  SurveyAppModel(
      {this.dateTime,
      this.entendimento,
      this.indicaria,
      this.navegacao,
      this.representacaoVisual,
      this.utilidade});

  factory SurveyAppModel.fromMap(Map data) {
    return SurveyAppModel(
      dateTime: Global.SDF.format((data['date'] as Timestamp).toDate()),
      indicaria: data['indicaria'] ?? 'n/a',
      entendimento: data['entendimento'] ?? 'n/a',
      navegacao: data['navegacao'] ?? 'n/a',
      representacaoVisual: data['representacaoVisual'] ?? 'n/a',
      utilidade: data['utilidade'] ?? 'n/a',
    );
  }
}

// January 19, 2021 at 10:33:10 AM UTC-3
// (timestamp)
// entendimento
// "Concordo totalmente"
// indicaria
// "Concordo totalmente"
// navegacao
// "Concordo totalmente"
// representacao_visual
// "Concordo totalmente"
// utilidade
// "Concordo totalmente"
