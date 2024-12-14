import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});
  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final String _limpar = 'Limpar';
  String _expressao = '';
  String _resultado = '';

  void pressionarBotao(String valor) {
    setState(() {
      if (valor == _limpar) {
        _expressao = '';
        _resultado = ''; // Limpa o resultado ao pressionar "Limpar"
      } else if (valor == '=') {
        _calcularResultado();
      } else {
        _expressao += valor;
      }
    });
  }

  void _calcularResultado() {
    try {
      // Substitui os operadores para os padrões aceitos pelo ExpressionEvaluator
      String expressaoCorrigida = _expressao.replaceAll('x', '*').replaceAll('÷', '/');

      // Avalia a expressão
      Expression expression = Expression.parse(expressaoCorrigida);
      const evaluator = ExpressionEvaluator();
      var resultado = evaluator.eval(expression, {});

      // Atualiza o resultado com o valor calculado
      setState(() {
        _resultado = resultado.toString();
      });
    } catch (e) {
      // Se ocorrer algum erro, exibe uma mensagem
      setState(() {
        _resultado = 'Erro, não foi possível calcular';
      });
    }
  }

  Widget _botao(String valor) {
    return TextButton(
      child: Text(
        valor,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () => pressionarBotao(valor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Text(
            _expressao,
            style: const TextStyle(fontSize: 24),
          ),
        ),
        Expanded(
          child: Text(
            _resultado,
            style: const TextStyle(fontSize: 24),
          ),
        ),
        Expanded(
          flex: 5,
          child: GridView.count(
            crossAxisCount: 5,
            childAspectRatio: 2,
            children: [
              _botao('7'),
              _botao('8'),
              _botao('9'),
              _botao('x'),
              _botao(','),
              _botao('4'),
              _botao('5'),
              _botao('6'),
              _botao('-'),
              _botao('+'),
              _botao('1'),
              _botao('2'),
              _botao('3'),
              _botao('÷'),
              _botao('='),
              _botao('0'),
            ],
          ),
        ),
        Expanded(child: _botao(_limpar))
      ],
    );
  }
}
