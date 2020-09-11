import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movieapp/domain/entities/movie.dart';
import 'package:movieapp/domain/entities/movie_details.dart';
import 'package:movieapp/domain/usecases/movie_details.dart';

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
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
      body: StreamBuilder<MovieDetail>(
          stream: _movieDetailsPageBloc.movieDetails,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Text("nulo");
            } else {
              MovieDetail movieDetail = snapshot.data;
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text("Teste"),
                    Text(movieDetail.title),
                    Text(movieDetail.genres[0].name),
                  ],
                ),
              );
            }
          }),
    );
  }
}
