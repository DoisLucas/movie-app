import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movieapp/domain/entities/movie.dart';
import 'package:movieapp/domain/entities/movie_details.dart';
import 'package:movieapp/domain/usecases/movie_details.dart';
import 'package:movieapp/external/imdb/imdb_base_url.dart';
import 'package:transparent_image/transparent_image.dart';

import 'movie_details_page_bloc.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;

  const MovieDetailsPage({Key key, this.movie}) : super(key: key);

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  MovieDetailsPageBloc _movieDetailsPageBloc;
  GetIt getIt = GetIt.instance;

  @override
  void initState() {
    _movieDetailsPageBloc = MovieDetailsPageBloc(getIt.get<MovieDetails>());
    _movieDetailsPageBloc.getMovieDetails(widget.movie.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: widget.movie.backdropPath != null ? 200.0 : 50,
              pinned: true,
              backgroundColor: Colors.black,
              flexibleSpace: _movieBackDrop(),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildMovieSubHeader(),
                _sectionDivider("Overview"),
                _buildOverview(),
                _sectionDivider("Genre"),
                _buildGenres(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _movieBackDrop() {
    if (widget.movie.backdropPath != null) {
      return FlexibleSpaceBar(
        background: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          width: 56,
          image: imdbBaseUrl.image_url + widget.movie.backdropPath,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _moviePoster() {
    if (widget.movie.posterPath != null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            width: MediaQuery.of(context).size.width / 3,
            image: imdbBaseUrl.image_url + widget.movie.posterPath,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildMovieSubHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _moviePoster(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  widget.movie.title,
                  overflow: TextOverflow.fade,
                  softWrap: true,
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'fontBold',
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                widget.movie.releaseDate != null
                    ? widget.movie.releaseDate.replaceAll('-', '/')
                    : "Whitout release date",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'fontMedium',
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    _buildIndicators(
                      'Vote Average',
                      widget.movie.voteAverage.toString(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    _buildIndicators(
                      'Popularity',
                      widget.movie.popularity.roundToDouble().toString(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIndicators(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          value,
          style: TextStyle(
              fontSize: 16, fontFamily: 'fontBold', color: Colors.white),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontFamily: 'fontMedium',
          ),
        ),
      ],
    );
  }

  Widget _sectionDivider(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontFamily: 'fontBold',
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildOverview() {
    return Text(
      widget.movie.overview,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: 14,
        fontFamily: 'fontMedium',
        color: Colors.white,
      ),
    );
  }

  Widget _buildGenres() {
    return StreamBuilder<MovieDetail>(
      stream: _movieDetailsPageBloc.movieDetails,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          MovieDetail movieDetail = snapshot.data;
          return Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            spacing: 10,
            runSpacing: 10,
            children: movieDetail.genres.map((genre) {
              return Container(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        genre.name,
                        style: TextStyle(
                          fontFamily: 'fontSemiBold',
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              );
            }).toList(),
          );
        } else {
          return SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.white,
              ),
            ),
          );
        }
      },
    );
  }
}
