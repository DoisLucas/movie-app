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

  const MovieList({
    Key key,
    this.movieStream,
    this.context,
    this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Movie>>(
        stream: movieStream,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return _buildLoading();
          } else {
            if (snapshot.data.isEmpty) {
              return _buildSearchText();
            }
            List<Movie> movies = snapshot.data;
            return Expanded(
              child: ListView.builder(
                itemCount: movies.length,
                physics: BouncingScrollPhysics(),
                controller: scrollController,
                itemBuilder: (context, index) {
                  Movie movie = movies[index];
                  return _movieCard(movie);
                },
              ),
            );
          }
        });
  }

  Widget _buildPosterMovie(Movie movie) {
    if (movie.posterPath != null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            width: 56,
            image: ImdbBaseUrl.image_url + movie.posterPath,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _movieCard(Movie movie) {
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
              _buildPosterMovie(movie),
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
                          style:
                              TextStyle(fontSize: 17, fontFamily: 'fontBold'),
                        ),
                      ),
                      Text(
                        movie.releaseDate != null
                            ? movie.releaseDate.replaceAll('-', '/')
                            : "Whitout release date",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                            fontFamily: 'fontMedium'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width - 128,
                          color: Colors.black12,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          _buildIndicators(
                            'Vote Average',
                            movie.voteAverage.toString(),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          _buildIndicators(
                            'Popularity',
                            movie.popularity.roundToDouble().toString(),
                          ),
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
  }

  Widget _buildIndicators(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'fontBold',
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black54,
            fontFamily: 'fontMedium',
          ),
        ),
      ],
    );
  }

  Widget _buildLoading() {
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
  }

  Widget _buildSearchText() {
    return Expanded(
      child: Center(
        child: Text(
          "Do a new search\n to view the movies!",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'fontSemiBold',
          ),
        ),
      ),
    );
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
