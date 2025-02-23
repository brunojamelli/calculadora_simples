import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Simples',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Tela1(),
    );
  }
}

class Tela1 extends StatefulWidget {
  @override
  _Tela1State createState() => _Tela1State();
}

class _Tela1State extends State<Tela1> {
  double x = 0.0;
  double y = 0.0;
  double resultado = 0.0;

  void _calcular() {
    setState(() {
      resultado = x + y; // Calcula a soma
    });
  }

  void _navegarParaTela2(BuildContext context, String tipo) async {
    // Navega para a Tela 2 e aguarda o resultado
    final valor = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Tela2(tipo: tipo),
      ),
    );

    // Atualiza o valor de x ou y com o valor retornado
    if (valor != null) {
      setState(() {
        if (tipo == 'x') {
          x = valor;
        } else {
          y = valor;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora Simples - Tela 1'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _navegarParaTela2(context, 'x'),
              child: Text('Calcular X'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _navegarParaTela2(context, 'y'),
              child: Text('Calcular Y'),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _calcular,
              child: Text('Calcular Soma'),
            ),
            SizedBox(height: 20),
            Text(
              'Resultado: $resultado',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class Tela2 extends StatefulWidget {
  final String tipo; // 'x' ou 'y'

  Tela2({required this.tipo});

  @override
  _Tela2State createState() => _Tela2State();
}

class _Tela2State extends State<Tela2> {
  final TextEditingController _controller = TextEditingController();

  void _salvar() {
    double valor = double.tryParse(_controller.text) ?? 0.0;
    Navigator.pop(context, valor); // Retorna o valor para a Tela 1
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digite ${widget.tipo.toUpperCase()}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Digite ${widget.tipo.toUpperCase()}',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _salvar,
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}