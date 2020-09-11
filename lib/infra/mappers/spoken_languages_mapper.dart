import 'package:movieapp/domain/entities/spoken_languages.dart';

class SpokenLanguagesMapper extends SpokenLanguages {
  final String iso6391;
  final String name;

  SpokenLanguagesMapper({
    this.iso6391,
    this.name,
  });

  static SpokenLanguagesMapper fromJson(Map<String, dynamic> json) {
    return SpokenLanguagesMapper(
      iso6391: json['iso_639_1'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['iso_639_1'] = this.iso6391;
    data['name'] = this.name;
    return data;
  }
}
