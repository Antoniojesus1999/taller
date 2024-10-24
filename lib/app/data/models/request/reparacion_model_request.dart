import 'dart:convert';

class ReparacionRequest {
    final DateTime? fecEntrada;
    final String? combustible;
    final String? kilometros;
    final String? seguro;
    final String? chasis;
    final List<Trabajo>? trabajos;
    final List<Danyo>? danyos;
    final String taller;
    final String cliente;
    final String vehiculo;

    ReparacionRequest({
        this.fecEntrada,
        this.combustible,
        this.kilometros,
        this.seguro,
        this.chasis,
        this.trabajos,
        this.danyos,
        required this.taller,
        required this.cliente,
        required this.vehiculo,
    });

    factory ReparacionRequest.fromRawJson(String str) => ReparacionRequest.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ReparacionRequest.fromJson(Map<String, dynamic> json) => ReparacionRequest(
        fecEntrada: json["fecEntrada"] == null ? null : DateTime.parse(json["fecEntrada"]),
        combustible: json["combustible"],
        kilometros: json["kilometros"],
        seguro: json["seguro"],
        chasis: json["chasis"],
        trabajos: List<Trabajo>.from(json["trabajos"].map((x) => Trabajo.fromJson(x))),
        danyos: List<Danyo>.from(json["danyos"].map((x) => Danyo.fromJson(x))),
        taller: json["taller"],
        cliente: json["cliente"],
        vehiculo: json["vehiculo"],
    );

    Map<String, dynamic> toJson() => {
       "fecEntrada": fecEntrada?.toIso8601String(),
        "combustible": combustible,
        "kilometros": kilometros,
        "seguro": seguro,
        "chasis": chasis,
        "trabajos": trabajos == null ? [] : List<dynamic>.from(trabajos!.map((x) => x.toJson())),
        "danyos": danyos == null ? [] : List<Danyo>.from(danyos!.map((x) => x.toJson())),
        "taller": taller,
        "cliente": cliente,
        "vehiculo": vehiculo,
    };
  
    @override
    String toString() {
      return 'ReparacionRequest{fecEntrada: $fecEntrada, combustible: $combustible, kilometros: $kilometros, seguro: $seguro, chasis: $chasis, trabajos: $trabajos, danyos: $danyos, taller: $taller, cliente: $cliente, vehiculo: $vehiculo}';
   }
}

class Danyo {
    final String positionX;
    final String positionY;
    final String origWidth;
    final String origHeight;

    Danyo({
        required this.positionX,
        required this.positionY,
        required this.origWidth,
        required this.origHeight,
    });

    factory Danyo.fromRawJson(String str) => Danyo.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Danyo.fromJson(Map<String, dynamic> json) => Danyo(
        positionX: json["positionX"],
        positionY: json["positionY"],
        origWidth: json["origWidth"],
        origHeight: json["origHeight"],
    );

    Map<String, dynamic> toJson() => {
        "positionX": positionX,
        "positionY": positionY,
        "origWidth": origWidth,
        "origHeight": origHeight,
    };

    @override
    String toString() {
    return 'Danyo{positionX: $positionX, positionY: $positionY, origWidth: $origWidth, origHeight: $origHeight}';
  }
}

class Trabajo {
    final String descripcion;

    Trabajo({
        required this.descripcion,
    });

    factory Trabajo.fromRawJson(String str) => Trabajo.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Trabajo.fromJson(Map<String, dynamic> json) => Trabajo(
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "descripcion": descripcion,
    };
    @override
    String toString() {
    return 'Trabajo{descripcion: $descripcion}';
  }
}