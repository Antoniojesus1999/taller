import 'package:taller/app/utils/string_utiles.dart';

const mapaUnidades = {
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

const mapaNumEspeciales = {
  'cero': '0',
  'diez': '10', 'once' : '11',
  'doce': '12', 'trece' : '13',
  'catorce' : '14', 'quince': '15',
  'dieciseis': '16', 'diecisiete': '17',
  'dieciocho': '18', 'diecinueve' : '19',
  'veinte': '20', 'veintiuno' : '21',
  'veintidos' : '22', 'veintitres' : '23',
  'veinticuatro' : '24', 'veinticinco' : '25',
  'veintiseis' : '26', 'veintisiete' : '27',
  'veintiocho' : '28', 'veintinueve' : '29',
};

const mapaDecenas = {
  'treinta': '30', 'cuarenta' : '40',
  'cincuenta': '50', 'sesenta' : '60',
  'setenta' : '70', 'ochenta': '80',
  'noventa': '90',
};

const mapaCentenas = {
  'cien': '100', 'ciento' : '100',
  'doscientos': '200', 'trescientos' : '300',
  'cuatrocientos' : '400', 'quinientos': '500',
  'seiscientos': '600', 'setecientos': '700',
  'sietecientos': '700', 'ochocientos': '800',
  'novecientos': '900', 'nuevecientos': '900',
};

const mapaLetras = {
  'a': 'A',
  'be': 'B', 'b': 'B',
  'ce': 'C', 'c': 'C',
  'de': 'D', 'd': 'D',
  'e': 'E',
  'efe': 'F', 'f': 'F',
  'ge': 'G', 'g': 'G', 'je': 'G',
  'hache': 'H', 'ache': 'H', 'h': 'H',
  'i': 'I',
  'jota': 'J', 'j': 'J',
  'ka': 'K', 'ca': 'K', 'k': 'K',
  'ele': 'L', 'l': 'L',
  'eme': 'M', 'm': 'M',
  'ene': 'N', 'n': 'N',
  'eñe': 'Ñ', 'ñ': 'Ñ',
  'o': 'O',
  'pe': 'P', 'p': 'P',
  'cu': 'Q', 'q': 'Q',
  'erre': 'R', 'r': 'R',
  'ese': 'S', 's': 'S',
  'te': 'T', 't': 'T',
  'u': 'U',
  'uve': 'V', 'v': 'V',
  'uve doble': 'W', 'ube doble': 'W', 'w': 'W',
  'equis': 'X', 'x': 'X',
  'i griega': 'Y', 'y': 'Y',
  'zeta': 'Z', 'ceta': 'Z', 'z': 'Z'
};

String convertirVozANif(String texto) {
  String resultado = '';
  int calculo = 0;
  bool unidades = false;
  bool decenas = false;
  bool centenas = false;
  bool yGriega = false;

  String textoClean = texto
      .replaceAll('-', ' ')
      .replaceAll(':', ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();

  final palabras = textoClean.toLowerCase().split(RegExp(r'\s+'));
  print('palabras: $palabras');
  for (int i = 0; i < palabras.length; i++) {
    print('valor de i: $i');
    final palabra = palabras[i];
    print('valor de palabra : $palabra');
    if (i == 0) {
      if (int.tryParse(palabra) != null) {
        if (calculo > 0) {
          resultado += calculo.toString();
        }
        resultado += palabra;
      } else if (palabra == 'mil') {
        resultado += 'ERRMIL';
        break;
      } else if (mapaLetras.containsKey(palabra)) {
        resultado += mapaLetras[palabra]!;
      } else if (mapaNumEspeciales.containsKey(palabra)) {
        resultado += mapaNumEspeciales[palabra]!;
      } else {
        if (mapaCentenas.containsKey(palabra)) {
          calculo += int.parse(mapaCentenas[palabra]!);
          centenas = true;
        }

        if (mapaDecenas.containsKey(palabra)) {
          calculo += int.parse(mapaDecenas[palabra]!);
          decenas = true;
        }

        if (mapaUnidades.containsKey(palabra)) {
          calculo += int.parse(mapaUnidades[palabra]!);
          unidades = true;
        }
      }
    } else if (i < palabras.length -1) {
      if (contieneLetrasYNumeros(palabra)) {
        print('Error: ERRDIC0');
        resultado += 'ERRDIC';
        break;
      } else if (int.tryParse(palabra) != null) {
        resultado += palabra;
      } else if (palabra == 'mil') {
        resultado += 'ERRMIL';
        break;
      } else if (palabra == 'ciento' && (unidades && !centenas && !decenas)) {
        calculo = calculo * 100;
        unidades = false;
        centenas = true;
      } else if (mapaLetras.containsKey(palabra)) {
        if (palabra == 'y') {
          yGriega = true;
        } else {
          print('Error: ERRDIC1');
          resultado += 'ERRDIC';
          break;
        }
      } else if (mapaNumEspeciales.containsKey(palabra)) {
        if (yGriega) {
          print('Error: ERRDIC2');
          resultado += 'ERRDIC';
          break;
        }

        if (calculo > 0) {
          if (centenas) {
            calculo += int.parse(mapaNumEspeciales[palabra]!);
            resultado += calculo.toString();
          } else {
            resultado += calculo.toString();
            resultado += mapaNumEspeciales[palabra]!;
          }
        } else {
          resultado += mapaNumEspeciales[palabra]!;
        }

        calculo = 0;
        centenas = false;
        decenas = false;
        unidades = false;

      } else {
        if (yGriega) {
          if (mapaCentenas.containsKey(palabra) || mapaDecenas.containsKey(palabra) || !mapaUnidades.containsKey(palabra)) {
            print('Error: ERRDIC3');
            resultado += 'ERRDIC';
            break;
          } else {
            calculo += int.parse(mapaUnidades[palabra]!);
            resultado += calculo.toString();
            calculo = 0;
            centenas = false;
            decenas = false;
            unidades = false;
            yGriega = false;
          }
        } else {
          if (mapaCentenas.containsKey(palabra)) {
            if (centenas || decenas || unidades) {
              resultado += calculo.toString();
              calculo = int.parse(mapaCentenas[palabra]!);
              decenas = false;
              unidades = false;
            } else {
              calculo += int.parse(mapaCentenas[palabra]!);
              centenas = true;
            }
          }

          if (mapaDecenas.containsKey(palabra)) {
            if (decenas || unidades) {
              resultado += calculo.toString();
              calculo = int.parse(mapaDecenas[palabra]!);
              centenas = false;
              unidades = false;
            } else {
              calculo += int.parse(mapaDecenas[palabra]!);
              decenas = true;
            }
          }

          if (mapaUnidades.containsKey(palabra)) {
            if (unidades) {
              resultado += calculo.toString();
              calculo = int.parse(mapaUnidades[palabra]!);
              centenas = false;
              decenas = false;
            } else {
              calculo += int.parse(mapaUnidades[palabra]!);
              unidades = true;
            }
          }
        }
      }
    } else {
      if (contieneLetrasYNumeros(palabra)) {
        print('Error: ERRDIC4');
        resultado += 'ERRDIC';
        break;
      } else if (int.tryParse(palabra) != null) {
        if (calculo > 0) {
          resultado += calculo.toString();
        }
        resultado += palabra;
      } else if (palabra == 'mil') {
        resultado += 'ERRMIL';
        break;
      } else if (mapaLetras.containsKey(palabra)) {
        if (calculo > 0) {
          resultado += calculo.toString();
        }

        resultado += mapaLetras[palabra]!;

      } else if (mapaNumEspeciales.containsKey(palabra)) {
        if (yGriega) {
          print('Error: ERRDIC5');
          resultado += 'ERRDIC';
          break;
        }

        if (calculo > 0) {
          if (centenas) {
            calculo += int.parse(mapaNumEspeciales[palabra]!);
            resultado += calculo.toString();
          } else {
            resultado += calculo.toString();
            resultado += mapaNumEspeciales[palabra]!;
          }
        } else {
          resultado += mapaNumEspeciales[palabra]!;
        }

      } else {
        if (mapaCentenas.containsKey(palabra)) {
          if (centenas || decenas || unidades) {
            resultado += calculo.toString();
          }
          resultado += mapaCentenas[palabra]!;
        }

        if (mapaDecenas.containsKey(palabra)) {
          if (decenas || unidades) {
            resultado += calculo.toString();
            resultado += mapaDecenas[palabra]!;
          } else {
            calculo += int.parse(mapaDecenas[palabra]!);
            resultado += calculo.toString();
          }
        }

        if (mapaUnidades.containsKey(palabra)) {
          if (unidades) {
            resultado += calculo.toString();
            resultado += mapaUnidades[palabra]!;
          } else {
            calculo += int.parse(mapaUnidades[palabra]!);
            resultado += calculo.toString();
          }
        }
      }
    }
  }

  return resultado;
}

String convertirVozATlf(String texto) {
  String resultado = '';
  int calculo = 0;
  bool unidades = false;
  bool decenas = false;
  bool centenas = false;
  bool yGriega = false;

  String textoClean = texto
      .replaceAll('-', ' ')
      .replaceAll(':', ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();

  final palabras = textoClean.toLowerCase().split(RegExp(r'\s+'));
  print('palabras: $palabras');
  for (int i = 0; i < palabras.length; i++) {
    print('valor de i: $i');
    final palabra = palabras[i];
    print('valor de palabra : $palabra');

    if (i < palabras.length -1) {
      if (palabra == 'mil') {
        resultado += 'ERRMIL';
        break;
      } else if (palabra == 'ciento' && (unidades && !centenas && !decenas)) {
        calculo = calculo * 100;
        unidades = false;
        centenas = true;
      } else if (mapaLetras.containsKey(palabra)) {
        if (palabra == 'y') {
          yGriega = true;
        } else {
          resultado += 'ERRTLF';
          break;
        }
      } else if (mapaNumEspeciales.containsKey(palabra)) {
        if (yGriega) {
          print('Error: ERRDIC1');
          resultado += 'ERRDIC';
          break;
        }

        if (calculo > 0) {
          if (centenas) {
            calculo += int.parse(mapaNumEspeciales[palabra]!);
            resultado += calculo.toString();
          } else {
            resultado += calculo.toString();
            resultado += mapaNumEspeciales[palabra]!;
          }
        } else {
          resultado += mapaNumEspeciales[palabra]!;
        }

        calculo = 0;
        centenas = false;
        decenas = false;
        unidades = false;

      } else {
        if (yGriega) {
          if (mapaCentenas.containsKey(palabra) || mapaDecenas.containsKey(palabra) || !mapaUnidades.containsKey(palabra)) {
            print('Error: ERRDIC2');
            resultado += 'ERRDIC';
            break;
          } else {
            calculo += int.parse(mapaUnidades[palabra]!);
            resultado += calculo.toString();
            calculo = 0;
            centenas = false;
            decenas = false;
            unidades = false;
            yGriega = false;
          }
        } else {
          if (mapaCentenas.containsKey(palabra)) {
            if (centenas || decenas || unidades) {
              resultado += calculo.toString();
              calculo = int.parse(mapaCentenas[palabra]!);
              decenas = false;
              unidades = false;
            } else {
              calculo += int.parse(mapaCentenas[palabra]!);
              centenas = true;
            }
          }

          if (mapaDecenas.containsKey(palabra)) {
            if (decenas || unidades) {
              resultado += calculo.toString();
              calculo = int.parse(mapaDecenas[palabra]!);
              centenas = false;
              unidades = false;
            } else {
              calculo += int.parse(mapaDecenas[palabra]!);
              decenas = true;
            }
          }

          if (mapaUnidades.containsKey(palabra)) {
            if (unidades) {
              resultado += calculo.toString();
              calculo = int.parse(mapaUnidades[palabra]!);
              centenas = false;
              decenas = false;
            } else {
              calculo += int.parse(mapaUnidades[palabra]!);
              unidades = true;
            }
          }
        }
      }
    } else {
      if (palabra == 'mil') {
        resultado += 'ERRMIL';
        break;
      } else if (mapaNumEspeciales.containsKey(palabra)) {
        if (yGriega) {
          print('Error: ERRDIC3');
          resultado += 'ERRDIC';
          break;
        }

        if (calculo > 0) {
          if (centenas) {
            calculo += int.parse(mapaNumEspeciales[palabra]!);
            resultado += calculo.toString();
          } else {
            resultado += calculo.toString();
            resultado += mapaNumEspeciales[palabra]!;
          }
        } else {
          resultado += mapaNumEspeciales[palabra]!;
        }
      } else {
        if (mapaCentenas.containsKey(palabra)) {
          if (centenas || decenas || unidades) {
            resultado += calculo.toString();
          }
          resultado += mapaCentenas[palabra]!;
        }

        if (mapaDecenas.containsKey(palabra)) {
          if (decenas || unidades) {
            resultado += calculo.toString();
            resultado += mapaDecenas[palabra]!;
          } else {
            calculo += int.parse(mapaDecenas[palabra]!);
            resultado += calculo.toString();
          }
        }

        if (mapaUnidades.containsKey(palabra)) {
          if (unidades) {
            resultado += calculo.toString();
            resultado += mapaUnidades[palabra]!;
          } else {
            calculo += int.parse(mapaUnidades[palabra]!);
            resultado += calculo.toString();
          }
        }
      }
    }
  }

  return resultado;
}