import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/domain/entities/movie.dart';
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
                  return GestureDetector(
                    onTap: () {
                      handleTapMovie(movies[index]);
                    },
                    child: Column(
                      children: <Widget>[
                        Text(movies[index].title),
                        Text(movies[index].overview),
                      ],
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
