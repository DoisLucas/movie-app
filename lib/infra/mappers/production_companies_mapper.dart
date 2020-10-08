import 'package:movieapp/domain/entities/production_companies.dart';

class ProductionCompaniesMapper extends ProductionCompanies {
  final int id;
  final String logoPath;
  final String name;
  final String originCountry;

  ProductionCompaniesMapper({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  static ProductionCompaniesMapper fromJson(Map<String, dynamic> json) {
    return ProductionCompaniesMapper(
      id: json['id'],
      logoPath: json['logo_path'],
      name: json['name'],
      originCountry: json['origin_country'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['logo_path'] = this.logoPath;
    data['name'] = this.name;
    data['origin_country'] = this.originCountry;
    return data;
  }
}
