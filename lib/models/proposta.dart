import 'package:recicla_facil/enum/trash_type.dart';
import 'orcamento.dart'; // Certifique-se de importar a classe Orcamento

class Proposta {
  final String id;
  final String nome;
  final String local;
  final TrashTypeEnum tipoColeta;
  final double quantidade;
  final List<Orcamento> orcamentos;

  Proposta({
    required this.id,
    required this.nome,
    required this.local,
    required this.tipoColeta,
    required this.quantidade,
    required this.orcamentos,
  });

  // Método fromMap
  factory Proposta.fromMap(Map<String, dynamic> map) {
    return Proposta(
      id: map['id'] as String,
      nome: map['nome'] as String,
      local: map['local'] as String,
      tipoColeta: TrashTypeEnum.values.firstWhere(
        (e) => e.toString().split('.').last == map['tipoColeta'],
      ),
      quantidade: map['quantidade'] as double,
      orcamentos: (map['orcamentos'] as List)
          .map((orcamento) => Orcamento.fromMap(orcamento))
          .toList(),
    );
  }

  // Método toMap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'local': local,
      'tipoColeta': tipoColeta.toString().split('.').last,
      'quantidade': quantidade,
      'orcamentos': orcamentos.map((orcamento) => orcamento.toMap()).toList(),
    };
  }
}
