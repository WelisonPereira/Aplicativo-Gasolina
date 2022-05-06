import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  // monta o ambiente (elementos gráficos)
  runApp(
    MaterialApp(
      home: Home(), // é a rota de entrada da aplicação (Start here)
      debugShowCheckedModeBanner: false, // remove o banner de debug do App
    ),
  );
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

/// Esta classe terá todo o conteúdo da aplicação, incluindo a lógica
/// e os controles (campos de entrada) e botões de ação (clacular e o reset)
class _HomeState extends State<Home> {
  // Aqui vamos definir nossos controles de entrada (digitação de valores)
  TextEditingController alcoolController = TextEditingController();
  TextEditingController gasolinaController = TextEditingController();

  // Criação de um controle para o nosso formulário (form)
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Variável para armazenar o nosso resultado "texto a ser mostrado"
  String _resultado = '';

  // Definição dos métodos do App
  //
  // Método para calcular o combustível ideal
  void _calculaCombustivelIdeal() {
    setState(() {
      //  criando e convertendo os valores digitados
      double varAlcool =
          double.parse(alcoolController.text.replaceAll(',', '.'));

      double varGasolina =
          double.parse(gasolinaController.text.replaceAll(',', '.'));

      // Medindo a proporção dos combustíveis
      double proporcao = varAlcool / varGasolina;

      // Atualizar a variável de resposta
      _resultado =
          (proporcao < 0.7 ? 'Abasteça com Álcool' : 'Abasteça com Gasolina');
    });
  }

  // Aqui vai o método _reset()
  void _reset() {
    // Limpando os Controllers
    alcoolController.clear(); // alcoolController.text = '';
    gasolinaController.clear();

    // Atualizar o estado das demais variáveis globais
    setState(() {
      _resultado = '';
      _formKey = GlobalKey<FormState>();
    });
  }

  // Montagem do ambiente gráfico do aplicativo
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Álcool ou Gasolina',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[900],
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                //  vamos chamar um método que limpa as entradas e as variáveis
                _reset(); // escreva este método
              }),
        ],
      ),

      // Criação do corpo de entrada de dados
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.local_gas_station,
                size: 80,
                color: Colors.lightBlue[900],
              ),

              // montando os campos de edição
              TextFormField(
                controller: alcoolController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,

                // validação da entrada
                validator: (value) =>
                    value!.isEmpty ? 'Informe o valor do álcool' : null,
                decoration: const InputDecoration(
                  labelText: 'Valor do álcool',
                ),
                style: const TextStyle(color: Colors.black, fontSize: 25.0),
              ),

              TextFormField(
                controller: gasolinaController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,

                // validação da entrada
                validator: (value) =>
                    value!.isEmpty ? 'Informe o valor da gasolina' : null,
                decoration: const InputDecoration(
                  labelText: 'Valor do gasolina',
                ),
                style: const TextStyle(color: Colors.black, fontSize: 25.0),
              ),

              // criar o botão para calcular
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: Container(
                  // o mesmo que uma DIV
                  height: 50,
                  child: RawMaterialButton(
                    onPressed: () {
                      // verificações dos valores (se estão preenchidos)
                      if (_formKey.currentState!.validate())
                        _calculaCombustivelIdeal();
                    },
                    child: const Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    fillColor: Colors.lightBlue[900],
                  ),
                ),
              ),
              // Mostrando o resultado
              Text(
                _resultado,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.lightBlue[900]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
