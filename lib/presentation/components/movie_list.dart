import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/domain/entities/movie.dart';
import 'package:movieapp/external/imdb/imdb_base_url.dart';
import 'package:movieapp/presentation/pages/movie_details/movie_details_page.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieList extends StatelessWidget {
  final Stream movieStream;
  final BuildContext context;
  final ScrollController scrollController;

  const MovieList(
      {Key key, this.movieStream, this.context, this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Movie>>(
        stream: movieStream,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Expanded(
              child: Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
            );
          } else {
            if (snapshot.data.isEmpty) {
              return Expanded(
                child: Center(
                  child: Text(
                    "Do a new search\n to view the movies!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'fontSemiBold'),
                  ),
                ),
              );
            }

            List<Movie> movies = snapshot.data;
            return Expanded(
              child: ListView.builder(
                itemCount: movies.length,
                physics: BouncingScrollPhysics(),
                controller: scrollController,
                itemBuilder: (context, index) {
                  Movie movie = movies[index];
                  return GestureDetector(
                    onTap: () {
                      handleTapMovie(movie);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(3),
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            movie.posterPath != null
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(3),
                                      ),
                                      child: FadeInImage.memoryNetwork(
                                        placeholder: kTransparentImage,
                                        width: 56,
                                        image: imdbBaseUrl.image_url +
                                            movie.posterPath,
                                      ),
                                    ),
                                  )
                                : Container(),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        movie.title,
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'fontBold'),
                                      ),
                                    ),
                                    Text(
                                      movie.releaseDate.replaceAll('-', '/'),
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black54,
                                          fontFamily: 'fontMedium'),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 1,
                                      width: MediaQuery.of(context).size.width -
                                          128,
                                      color: Colors.black12,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '${movie.voteAverage}',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'fontBold',
                                              ),
                                            ),
                                            Text(
                                              'Vote Average',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54,
                                                fontFamily: 'fontMedium',
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '${movie.popularity.roundToDouble()}',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'fontBold',
                                              ),
                                            ),
                                            Text(
                                              'Popularity',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54,
                                                fontFamily: 'fontMedium',
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        });
  }

  void handleTapMovie(Movie movie) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => MovieDetailsPage(
          movie: movie,
        ),
      ),
    );
  }
}
