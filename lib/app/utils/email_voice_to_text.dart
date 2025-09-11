import 'package:diacritic/diacritic.dart';

class ResultadoEmail {
  final String? email;
  final bool contieneNumeroMayorQueNueve;

  ResultadoEmail({
    required this.email,
    required this.contieneNumeroMayorQueNueve,
  });
}

ResultadoEmail procesarEmailDictado(String entrada) {
  // Palabras que indican números mayores a 9 (dictadas)
  final palabrasNumerosInvalidos = [
    'diez', 'once', 'doce', 'trece', 'catorce', 'quince',
    'dieciséis', 'dieciseis', 'diecisiete', 'dieciocho',
    'diecinueve', 'veinte', 'veinti', 'treinta', 'cuarenta', 'cincuenta',
    'sesenta', 'setenta', 'ochenta', 'noventa', 'cien', 'ciento', 'mil'
  ];

  // Reemplazos de expresiones habladas por símbolos reales
  final reemplazos = {
    'arroba': '@',
    'punto': '.',
    'guion bajo': '_',
    'guión bajo': '_',
    '- bajo': '_',
    'guion': '-',
    'guión': '-',
    'cero': '0',
    'uno': '1',
    'dos': '2', 'do': '2',
    'tres': '3', 'tre': '3',
    'cuatro': '4',
    'cinco': '5',
    'seis': '6', 'cei': '6', 'ceis': '6',
    'siete': '7', 'ciete': '7',
    'ocho': '8', 'osho': '8',
    'nueve': '9',
  };

  // Normalización del texto
  String texto = removeDiacritics(entrada.toLowerCase());

  // Detectar si hay algún número en palabra mayor que 9
  bool contieneNumeroMayor = palabrasNumerosInvalidos.any((palabra) => texto.contains(palabra));

  // Aplicar los reemplazos
  reemplazos.forEach((clave, valor) {
    texto = texto.replaceAll(clave, valor);
  });

  // Limpiar espacios extra y caracteres no válidos
  texto = texto.replaceAll(RegExp(r'\s+'), '');
  texto = texto.replaceAll(RegExp(r'[^a-z0-9@._\-]'), '');

  // Validar formato de email
  final esValido = RegExp(
    r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$',
    caseSensitive: false,
  ).hasMatch(texto);

  return ResultadoEmail(
    email: esValido ? texto : null,
    contieneNumeroMayorQueNueve: contieneNumeroMayor,
  );
}
