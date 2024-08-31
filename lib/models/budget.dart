class Budget {
  final String id;
  final String nome;
  final double valor;
  final String proposalId;

  Budget({
    required this.id,
    required this.nome,
    required this.valor,
    required this.proposalId,
  });

  factory Budget.fromMap(Map<String, dynamic> map) {
    return Budget(
      id: map['id'] as String,
      nome: map['nome'] as String,
      valor: map['valor'] as double,
      proposalId: map['proposalId'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'valor': valor,
      'proposalId': proposalId,
    };
  }
}
