import 'package:recicla_facil/enum/trash_type.dart';
import 'package:recicla_facil/models/budget.dart';

class Proposal {
  final String id;
  final String nome;
  final String local;
  final TrashTypeEnum tipoColeta;
  final double quantidade;
  final List<Budget> budgets;

  Proposal({
    required this.id,
    required this.nome,
    required this.local,
    required this.tipoColeta,
    required this.quantidade,
    required this.budgets,
  });

  // Método fromMap
  factory Proposal.fromMap(Map<String, dynamic> map) {
    return Proposal(
      id: map['id'] as String,
      nome: map['nome'] as String,
      local: map['local'] as String,
      tipoColeta: TrashTypeEnum.values.firstWhere(
        (e) => e.toString().split('.').last == map['tipoColeta'],
      ),
      quantidade: map['quantidade'] as double,
      budgets: (map['budgets'] as List)
          .map((budget) => Budget.fromMap(budget))
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
      'budgets': budgets.map((budget) => budget.toMap()).toList(),
    };
  }
}
