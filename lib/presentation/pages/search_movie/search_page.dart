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
    return SafeArea(
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildSearchBar(),
        _buildLineDivider(),
        StreamBuilder<String>(
          stream: _searchBloc.titleSearch,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Container();
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'fontSemiBold',
                      fontSize: 16,
                    ),
                    text: "Resultados para: ",
                    children: <TextSpan>[
                      TextSpan(
                        text: '${snapshot.data}',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'fontBold',
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
        MovieList(
          movieStream: _searchBloc.listMovies,
          scrollController: _scrollController,
          context: context,
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: _searchTextController,
                  onSubmitted: (_) {
                    _searchBloc.searchTitle(_searchTextController.text);
                  },
                  textInputAction: TextInputAction.search,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'fontMedium',
                  ),
                  decoration: InputDecoration.collapsed(
                    hintText: 'Search movie by title',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: 'fontMedium',
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _searchBloc.searchTitle(_searchTextController.text);
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(45),
                  ),
                ),
                child: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLineDivider() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      height: 1,
    );
  }
}
