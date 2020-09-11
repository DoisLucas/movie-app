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
      backgroundColor: Colors.black,
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                pinned: true,
                backgroundColor: Colors.black,
                flexibleSpace: FlexibleSpaceBar(
                  background: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    width: 56,
                    image: imdbBaseUrl.image_url + widget.movie.backdropPath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      widget.movie.posterPath != null
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(3),
                                ),
                                child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  width: MediaQuery.of(context).size.width / 3,
                                  image: imdbBaseUrl.image_url +
                                      widget.movie.posterPath,
                                ),
                              ),
                            )
                          : Container(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.movie.title,
                              overflow: TextOverflow.fade,
                              softWrap: true,
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'fontBold',
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.movie.releaseDate.replaceAll('-', '/'),
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'fontMedium',
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '${widget.movie.voteAverage}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'fontBold',
                                          color: Colors.white),
                                    ),
                                    Text(
                                      'Vote Average',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontFamily: 'fontMedium',
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '${widget.movie.popularity.roundToDouble()}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'fontBold',
                                          color: Colors.white),
                                    ),
                                    Text(
                                      'Popularity',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'fontMedium',
                                          color: Colors.white),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 0, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Overview',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'fontBold',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        widget.movie.overview,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'fontMedium',
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          'Genre',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'fontBold',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      StreamBuilder<MovieDetail>(
                          stream: _movieDetailsPageBloc.movieDetails,
                          builder: (context, snapshot) {
                            if (snapshot.data != null) {
                              MovieDetail movieDetail = snapshot.data;
                              return Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: movieDetail.genres.map((e) {
                                  return Container(
                                    height: 40,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        e.name,
                                        style: TextStyle(
                                          fontFamily: 'fontSemiBold',
                                        ),
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
                          }),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
