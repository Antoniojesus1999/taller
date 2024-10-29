import 'dart:convert';

class ReparacionPagintation {
    List<ReparacionResponse>? reparaciones;
    int? totalDocs;
    int? limit;
    int? totalPages;
    int? page;
    int? pagingCounter;
    bool? hasPrevPage;
    bool? hasNextPage;
    dynamic prevPage;
    dynamic nextPage;

    ReparacionPagintation({
        this.reparaciones,
        this.totalDocs,
        this.limit,
        this.totalPages,
        this.page,
        this.pagingCounter,
        this.hasPrevPage,
        this.hasNextPage,
        this.prevPage,
        this.nextPage,
    });

    factory ReparacionPagintation.fromRawJson(String str) => ReparacionPagintation.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ReparacionPagintation.fromJson(Map<String, dynamic> json) => ReparacionPagintation(
        reparaciones: json["docs"] == null ? [] : List<ReparacionResponse>.from(json["docs"]!.map((x) => ReparacionResponse.fromJson(x))),
        totalDocs: json["totalDocs"],
        limit: json["limit"],
        totalPages: json["totalPages"],
        page: json["page"],
        pagingCounter: json["pagingCounter"],
        hasPrevPage: json["hasPrevPage"],
        hasNextPage: json["hasNextPage"],
        prevPage: json["prevPage"],
        nextPage: json["nextPage"],
    );

    Map<String, dynamic> toJson() => {
        "docs": reparaciones == null ? [] : List<dynamic>.from(reparaciones!.map((x) => x.toJson())),
        "totalDocs": totalDocs,
        "limit": limit,
        "totalPages": totalPages,
        "page": page,
        "pagingCounter": pagingCounter,
        "hasPrevPage": hasPrevPage,
        "hasNextPage": hasNextPage,
        "prevPage": prevPage,
        "nextPage": nextPage,
    };
    
  @override
  String toString() {
    return 'ReparacionModelPagintation{docs: $reparaciones, totalDocs: $totalDocs, limit: $limit, totalPages: $totalPages, page: $page, pagingCounter: $pagingCounter, hasPrevPage: $hasPrevPage, hasNextPage: $hasNextPage, prevPage: $prevPage, nextPage: $nextPage}';
  }
}

class ReparacionResponse {
    String? id;
    DateTime? fecEntrada;
    String? combustible;
    String? kilometros;
    String? seguro;
    String? chasis;
    List<Trabajo>? trabajos;
    List<Danyo>? danyos;
    String? taller;
    Vehiculo? vehiculo;
    Cliente? cliente;
    DateTime? createdAt;
    DateTime? updatedAt;

    ReparacionResponse({
        this.id,
        this.fecEntrada,
        this.combustible,
        this.kilometros,
        this.seguro,
        this.chasis,
        this.trabajos,
        this.danyos,
        this.taller,
        this.vehiculo,
        this.cliente,
        this.createdAt,
        this.updatedAt,
    });

    factory ReparacionResponse.fromRawJson(String str) => ReparacionResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ReparacionResponse.fromJson(Map<String, dynamic> json) => ReparacionResponse(
        id: json["_id"],
        fecEntrada: json["fecEntrada"] == null ? null : DateTime.parse(json["fecEntrada"]),
        combustible: json["combustible"],
        kilometros: json["kilometros"],
        seguro: json["seguro"],
        chasis: json["chasis"],
        trabajos: json["trabajos"] == null ? [] : List<Trabajo>.from(json["trabajos"]!.map((x) => Trabajo.fromJson(x))),
        danyos: json["danyos"] == null ? [] : List<Danyo>.from(json["danyos"]!.map((x) => Danyo.fromJson(x))),
        taller: json["taller"],
        vehiculo: json["vehiculo"] == null ? null : Vehiculo.fromJson(json["vehiculo"]),
        cliente: json["cliente"] == null ? null : Cliente.fromJson(json["cliente"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "fecEntrada": fecEntrada?.toIso8601String(),
        "combustible": combustible,
        "kilometros": kilometros,
        "seguro": seguro,
        "chasis": chasis,
        "trabajos": trabajos == null ? [] : List<dynamic>.from(trabajos!.map((x) => x.toJson())),
        "danyos": danyos == null ? [] : List<dynamic>.from(danyos!.map((x) => x.toJson())),
        "taller": taller,
        "vehiculo": vehiculo?.toJson(),
        "cliente": cliente?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };

  @override
  String toString() {
    return 'Doc{id: $id, fecEntrada: $fecEntrada, combustible: $combustible, kilometros: $kilometros, seguro: $seguro, chasis: $chasis, trabajos: $trabajos, danyos: $danyos, taller: $taller, vehiculo: $vehiculo, cliente: $cliente, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}

class Cliente {
    String? id;
    String? nif;
    String? nombre;
    String? apellido1;
    String? apellido2;
    String? telefono;
    String? email;
    List<dynamic>? reparaciones;
    DateTime? createdAt;
    DateTime? updatedAt;

    Cliente({
        this.id,
        this.nif,
        this.nombre,
        this.apellido1,
        this.apellido2,
        this.telefono,
        this.email,
        this.reparaciones,
        this.createdAt,
        this.updatedAt,
    });

    factory Cliente.fromRawJson(String str) => Cliente.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        id: json["id"],
        nif: json["nif"],
        nombre: json["nombre"],
        apellido1: json["apellido_1"],
        apellido2: json["apellido_2"],
        telefono: json["telefono"],
        email: json["email"],
        reparaciones: json["reparaciones"] == null ? [] : List<dynamic>.from(json["reparaciones"]!.map((x) => x)),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nif": nif,
        "nombre": nombre,
        "apellido_1": apellido1,
        "apellido_2": apellido2,
        "telefono": telefono,
        "email": email,
        "reparaciones": reparaciones == null ? [] : List<dynamic>.from(reparaciones!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
  @override
  String toString() {
    return 'Cliente{id: $id, nif: $nif, nombre: $nombre, apellido1: $apellido1, apellido2: $apellido2, telefono: $telefono, email: $email, reparaciones: $reparaciones, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}

class Danyo {
    double positionX;
    double positionY;
    double origWidth;
    double origHeight;

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
    String? descripcion;

    Trabajo({
        this.descripcion,
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

class Vehiculo {
    String? id;
    String? matricula;
    String? marca;
    String? modelo;
    List<dynamic>? reparaciones;
    DateTime? createdAt;
    DateTime? updatedAt;

    Vehiculo({
        this.id,
        this.matricula,
        this.marca,
        this.modelo,
        this.reparaciones,
        this.createdAt,
        this.updatedAt,
    });

    factory Vehiculo.fromRawJson(String str) => Vehiculo.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Vehiculo.fromJson(Map<String, dynamic> json) => Vehiculo(
        id: json["id"],
        matricula: json["matricula"],
        marca: json["marca"],
        modelo: json["modelo"],
        reparaciones: json["reparaciones"] == null ? [] : List<dynamic>.from(json["reparaciones"]!.map((x) => x)),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "matricula": matricula,
        "marca": marca,
        "modelo": modelo,
        "reparaciones": reparaciones == null ? [] : List<dynamic>.from(reparaciones!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };

  @override
  String toString() {
    return 'Vehiculo{id: $id, matricula: $matricula, marca: $marca, modelo: $modelo, reparaciones: $reparaciones, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
