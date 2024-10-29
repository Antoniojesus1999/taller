import 'dart:convert';

class PaginationResponse<T> {
  List<T>? docs;
  int? totalDocs;
  int? limit;
  int? totalPages;
  int? page;
  int? pagingCounter;
  bool? hasPrevPage;
  bool? hasNextPage;
  dynamic prevPage;
  dynamic nextPage;

  PaginationResponse({
    this.docs,
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

  factory PaginationResponse.fromRawJson(String str, T Function(Map<String, dynamic>) fromJsonT) =>
      PaginationResponse.fromJson(json.decode(str), fromJsonT);

  String toRawJson() => json.encode(toJson());

  factory PaginationResponse.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) =>
      PaginationResponse(
        docs: json["docs"] == null ? [] : List<T>.from(json["docs"].map((x) => fromJsonT(x))),
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
    "docs": docs == null ? [] : List<dynamic>.from(docs!.map((x) => (x as dynamic).toJson())),
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
    return 'PaginationResponse{docs: $docs, totalDocs: $totalDocs, limit: $limit, totalPages: $totalPages, page: $page, pagingCounter: $pagingCounter, hasPrevPage: $hasPrevPage, hasNextPage: $hasNextPage, prevPage: $prevPage, nextPage: $nextPage}';
  }
}
