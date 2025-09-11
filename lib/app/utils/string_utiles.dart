String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}

String convertirPalabrasATlf(String texto) {
  final mapa = {
    'cero': '0',
    'uno': '1',
    'dos': '2', 'do': '2',
    'tres': '3', 'tre': '3',
    'cuatro': '4',
    'cinco': '5',
    'seis': '6', 'cei': '6', 'ceis': '6',
    'siete': '7', 'ciete': '7',
    'ocho': '8', 'osho': '8',
    'nueve': '9'
  };

  if (contieneNumeroInvalido(texto)) {
    return 'ERROR';
  }

  final palabras = texto.toLowerCase().split(RegExp(r'\s+'));
  final numeros = palabras.map((p) => mapa[p]).where((n) => n != null).join();
  return numeros;
}

bool contieneNumeroInvalido (String texto) {
  final palabrasNumerosInvalidos = [
    'diez', 'once', 'doce', 'trece', 'catorce', 'quince',
    'dieciséis', 'dieciseis', 'diecisiete', 'dieciocho',
    'diecinueve', 'veinte', 'veinti', 'treinta', 'cuarenta', 'cincuenta',
    'sesenta', 'setenta', 'ochenta', 'noventa', 'cien', 'ciento', 'mil'
  ];

  return palabrasNumerosInvalidos.any((palabra) => texto.contains(palabra));
}

bool contieneLetrasYNumeros(String input) {
  final regex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d).+$');
  return regex.hasMatch(input);
}

bool contieneSoloNumeros(String input) {
  final regex = RegExp(r'^[0-9]+$'); // solo dígitos del 0 al 9
  return regex.hasMatch(input);
}