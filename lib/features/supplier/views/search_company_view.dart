import 'package:flutter/material.dart';

class SearchCompanyView extends StatefulWidget {
  const SearchCompanyView({super.key});

  @override
  SearchCompanyViewState createState() => SearchCompanyViewState();
}

class SearchCompanyViewState extends State<SearchCompanyView> {
  String selectedType = 'Tipo 1'; // Tipo selecionado
  final TextEditingController searchController = TextEditingController();

  List<String> companyResults = []; // Lista de resultados da busca

  void searchCompanies() {
    // Função para buscar empresas (substitua por sua lógica)
    setState(() {
      companyResults = [
        'Empresa 1',
        'Empresa 2',
        'Empresa 3',
      ];
    });
  }

  void openProposalModal(String companyName) {
    showDialog(
      context: context,
      builder: (context) {
        return ProposalModal(companyName: companyName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Empresa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: selectedType,
              onChanged: (String? newValue) {
                setState(() {
                  selectedType = newValue!;
                });
              },
              items: <String>['Tipo 1', 'Tipo 2', 'Tipo 3']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Buscar por nome',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: searchCompanies,
              child: const Text('Buscar'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: companyResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(companyResults[index]),
                    onTap: () {
                      openProposalModal(companyResults[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProposalModal extends StatelessWidget {
  final String companyName;
  final TextEditingController kilosController = TextEditingController();
  final TextEditingController observationController = TextEditingController();

  ProposalModal({super.key, required this.companyName});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Criar Proposta para $companyName'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: kilosController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Quantidade de Kilos',
            ),
          ),
          TextField(
            controller: observationController,
            decoration: const InputDecoration(
              labelText: 'Observação',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Fechar o modal
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            // Lógica para salvar a proposta (substitua pela sua lógica)
            print('Empresa: $companyName');
            print('Kilos: ${kilosController.text}');
            print('Observação: ${observationController.text}');
            Navigator.of(context).pop(); // Fechar o modal após salvar
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
