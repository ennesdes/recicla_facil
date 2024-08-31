class Orcamento {
  final String id;
  final String nome;
  final double valor;
  final String propostaId;

  Orcamento({
    required this.id,
    required this.nome,
    required this.valor,
    required this.propostaId,
  });

  // Método fromMap
  factory Orcamento.fromMap(Map<String, dynamic> map) {
    return Orcamento(
      id: map['id'] as String,
      nome: map['nome'] as String,
      valor: map['valor'] as double,
      propostaId: map['propostaId'] as String,
    );
  }

  // Método toMap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'valor': valor,
      'propostaId': propostaId,
    };
  }
}
