import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movieapp/domain/usecases/movie_upcoming.dart';
import 'package:movieapp/presentation/components/movie_list.dart';
import 'package:movieapp/presentation/pages/search_movie/search_page.dart';

import 'home_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _homeBloc;
  GetIt getIt = GetIt.instance;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _homeBloc = HomeBloc(getIt.get<MoviesUpcoming>());
    _homeBloc.getMoviesUpcoming();
    _scrollController.addListener(() {
      double triggerFetchMoreSize =
          0.7 * _scrollController.position.maxScrollExtent;
      if (_scrollController.position.pixels > triggerFetchMoreSize) {
        _homeBloc.nextPage();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _homeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie App"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              handleTapSearch();
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          MovieList(
            context: context,
            movieStream: _homeBloc.listMovies,
            scrollController: _scrollController,
          )
        ],
      ),
    );
  }

  void handleTapSearch() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => SearchPage(),
      ),
    );
  }
}
