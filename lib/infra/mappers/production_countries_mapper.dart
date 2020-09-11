import 'package:movieapp/domain/entities/production_countries.dart';

class ProductionCountriesMapper extends ProductionCountries {
  final String iso31661;
  final String name;

  ProductionCountriesMapper({
    this.iso31661,
    this.name,
  });

  static ProductionCountriesMapper fromJson(Map<String, dynamic> json) {
    return ProductionCountriesMapper(
      iso31661: json['iso_3166_1'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iso_3166_1'] = this.iso31661;
    data['name'] = this.name;
    return data;
  }
}
