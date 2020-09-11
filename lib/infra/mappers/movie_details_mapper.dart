import 'package:movieapp/domain/entities/movie_details.dart';
import 'package:movieapp/infra/mappers/production_companies_mapper.dart';
import 'package:movieapp/infra/mappers/production_countries_mapper.dart';
import 'package:movieapp/infra/mappers/spoken_languages_mapper.dart';

import 'belongs_to_collection_mapper.dart';
import 'genres_mapper.dart';

class MovieDetailMapper extends MovieDetail {
  bool adult; //
  String backdropPath; //
  BelongsToCollectionMapper belongsToCollection;
  int budget;
  List<GenresMapper> genres;
  String homepage;
  int id;
  String imdbId;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  List<ProductionCompaniesMapper> productionCompanies;
  List<ProductionCountriesMapper> productionCountries;
  String releaseDate;
  int revenue;
  int runtime;
  List<SpokenLanguagesMapper> spokenLanguages;
  String status;
  String tagline;
  String title;
  bool video;
  double voteAverage;

  MovieDetailMapper({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
  });

  static MovieDetailMapper fromJson(Map<String, dynamic> json) {
    MovieDetailMapper movieDetail = MovieDetailMapper();

    movieDetail.adult = json['adult'];
    movieDetail.backdropPath = json['backdrop_path'];
    movieDetail.belongsToCollection = json['belongs_to_collection'] != null
        ? BelongsToCollectionMapper.fromJson(json['belongs_to_collection'])
        : null;
    movieDetail.budget = json['budget'];
    if (json['genres'] != null) {
      movieDetail.genres = List<GenresMapper>();
      json['genres'].forEach((v) {
        movieDetail.genres.add(
          GenresMapper.fromJson(v),
        );
      });
    }
    movieDetail.homepage = json['homepage'];
    movieDetail.id = json['id'];
    movieDetail.imdbId = json['imdb_id'];
    movieDetail.originalLanguage = json['original_language'];
    movieDetail.originalTitle = json['original_title'];
    movieDetail.overview = json['overview'];
    movieDetail.popularity = json['popularity'].toDouble();
    movieDetail.posterPath = json['poster_path'];
    if (json['production_companies'] != null) {
      movieDetail.productionCompanies = List<ProductionCompaniesMapper>();
      json['production_companies'].forEach((v) {
        movieDetail.productionCompanies.add(
          ProductionCompaniesMapper.fromJson(v),
        );
      });
    }
    if (json['production_countries'] != null) {
      movieDetail.productionCountries = List<ProductionCountriesMapper>();
      json['production_countries'].forEach((v) {
        movieDetail.productionCountries.add(
          ProductionCountriesMapper.fromJson(v),
        );
      });
    }
    movieDetail.releaseDate = json['release_date'];
    movieDetail.revenue = json['revenue'];
    movieDetail.runtime = json['runtime'];
    if (json['spoken_languages'] != null) {
      movieDetail.spokenLanguages = List<SpokenLanguagesMapper>();
      json['spoken_languages'].forEach((v) {
        movieDetail.spokenLanguages.add(
          SpokenLanguagesMapper.fromJson(v),
        );
      });
    }
    movieDetail.status = json['status'];
    movieDetail.tagline = json['tagline'];
    movieDetail.title = json['title'];
    movieDetail.video = json['video'];
    movieDetail.voteAverage = json['vote_average'].toDouble();
    return movieDetail;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    if (this.belongsToCollection != null) {
      data['belongs_to_collection'] = this.belongsToCollection.toJson();
    }
    data['budget'] = this.budget;
    if (this.genres != null) {
      data['genres'] = this.genres.map((v) => v.toJson()).toList();
    }
    data['homepage'] = this.homepage;
    data['id'] = this.id;
    data['imdb_id'] = this.imdbId;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['overview'] = this.overview;
    data['popularity'] = this.popularity;
    data['poster_path'] = this.posterPath;
    if (this.productionCompanies != null) {
      data['production_companies'] =
          this.productionCompanies.map((v) => v.toJson()).toList();
    }
    if (this.productionCountries != null) {
      data['production_countries'] =
          this.productionCountries.map((v) => v.toJson()).toList();
    }
    data['release_date'] = this.releaseDate;
    data['revenue'] = this.revenue;
    data['runtime'] = this.runtime;
    if (this.spokenLanguages != null) {
      data['spoken_languages'] =
          this.spokenLanguages.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['tagline'] = this.tagline;
    data['title'] = this.title;
    data['video'] = this.video;
    data['vote_average'] = this.voteAverage;
    return data;
  }
}
