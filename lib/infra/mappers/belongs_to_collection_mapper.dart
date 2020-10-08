import 'package:movieapp/domain/entities/belongs_to_collection.dart';

class BelongsToCollectionMapper extends BelongsToCollection {
  int id;
  String name;
  String posterPath;
  String backdropPath;

  BelongsToCollectionMapper(
      {this.id, this.name, this.posterPath, this.backdropPath});

  static BelongsToCollectionMapper fromJson(Map<String, dynamic> json) {
    return BelongsToCollectionMapper(
      id: json['id'],
      name: json['name'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['poster_path'] = this.posterPath;
    data['backdrop_path'] = this.backdropPath;
    return data;
  }
}
