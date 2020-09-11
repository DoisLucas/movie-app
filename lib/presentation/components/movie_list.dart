import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/domain/entities/movie.dart';
import 'package:movieapp/external/imdb/imdb_base_url.dart';
import 'package:movieapp/presentation/pages/movie_details/movie_details_page.dart';

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
            return Container(
              child: Text("Teste"),
            );
          } else {
            List<Movie> movies = snapshot.data;
            return Expanded(
              child: ListView.builder(
                itemCount: movies.length,
                shrinkWrap: true,
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
                                      child: Image.network(
                                          imdbBaseUrl.image_url +
                                              movie.posterPath),
                                    ),
                                  )
                                : Container(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    movie.title,
                                    style: TextStyle(
                                        fontSize: 16, fontFamily: 'fontBold'),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.date_range,
                                        color: Colors.black,
                                        size: 15,
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        movie.releaseDate.replaceAll('-', '/'),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'fontMedium'),
                                      ),
                                    ],
                                  ),
                                ],
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
