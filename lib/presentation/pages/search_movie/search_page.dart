import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movieapp/domain/usecases/movie_by_title.dart';
import 'package:movieapp/presentation/components/movie_list.dart';
import 'package:movieapp/presentation/pages/search_movie/search_bloc.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchBloc _searchBloc;
  GetIt getIt = GetIt.instance;

  TextEditingController _searchTextController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _searchBloc = SearchBloc(getIt.get<MovieByTitle>());
    _scrollController.addListener(() {
      double triggerFetchMoreSize =
          0.7 * _scrollController.position.maxScrollExtent;
      if (_scrollController.position.pixels > triggerFetchMoreSize) {
        _searchBloc.nextPage();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _searchTextController,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _searchBloc.searchTitle(_searchTextController.text);
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
            ),
          ),
          MovieList(
            movieStream: _searchBloc.listMovies,
            scrollController: _scrollController,
            context: context,
          ),
        ],
      ),
    );
  }
}
