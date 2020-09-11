import 'package:movieapp/domain/entities/genres.dart';

class GenresMapper extends Genres {
  final int id;
  final String name;

  GenresMapper({
    this.id,
    this.name,
  });

  static GenresMapper fromJson(Map<String, dynamic> json) {
    return GenresMapper(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
