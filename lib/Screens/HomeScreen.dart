import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newProject3/Models/MovieModal.dart';
import 'package:newProject3/MovieBloc/movie_bloc.dart';
import 'package:newProject3/MovieBloc/movie_events.dart';
import 'package:newProject3/MovieBloc/movie_state.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<MovieBloc>(context).add(MovieIntailized());
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: 100.0),
          child: new Container(
            child: new Column(
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),

                Text(
                  "Movies List",
                  style: new TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),


                SizedBox(
                  height: 10.0,
                ),


                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  child: new Container(
                    height: 5,
                    width: width,
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),


                Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 20),
                    height: height - 100,
                    child: BlocBuilder(
                      bloc: BlocProvider.of<MovieBloc>(context),
                      builder: (context, state) {
                        if (state is MovieLoad) {
                          return LoadingListView();
                        } else if (state is MovieEmpty) {
                          return Text(
                            "Nothing to show",
                            style: new TextStyle(fontSize: 30),
                          );
                        } else {
                          final stateasMovieLoaded = state as MovieFetched;
                          final movies = stateasMovieLoaded.results;
                          print(movies.length);
                          return ShowMoviesList(
                            movies: movies,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShowMoviesList extends StatefulWidget {
  final List<Results> movies;
  ShowMoviesList({this.movies});
  @override
  _ShowMoviesListState createState() => _ShowMoviesListState();
}

class _ShowMoviesListState extends State<ShowMoviesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      // shrinkWrap: true,
      itemBuilder: (BuildContext context, index) {
        Results movie = widget.movies[index];
        return GestureDetector(
          onTap: (){
            final snackBar = SnackBar(content: Text('${movie.title}'));
            Scaffold.of(context).showSnackBar(snackBar);
          },
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                'https://image.tmdb.org/t/p/w185${movie.poster_path}',
                fit: BoxFit.cover,
                width: 150.0,
              ),
            ),
            title: Text(
              movie.title,
              style: new TextStyle(
                fontSize: 20,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(movie.original_title,
                style: new TextStyle(fontSize: 15),
                overflow: TextOverflow.ellipsis),
          ),
        );
      },
      separatorBuilder: (BuildContext context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Divider(
            height: 8.0,
            color: Colors.black54,
          ),
        );
      },
      itemCount: widget.movies.length,
    );
  }
}

class LoadingListView extends StatefulWidget {
  @override
  _LoadingListViewState createState() => _LoadingListViewState();
}

class _LoadingListViewState extends State<LoadingListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context,i){
      return Shimmer.fromColors(
          period: Duration(milliseconds: 3000),
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Container(
            margin: EdgeInsets.all(4.0),
            height: MediaQuery.of(context).size.height * 0.19,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.16,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color(0xFF333333),
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 0,
                  height: MediaQuery.of(context).size.height * 0.19,
                  width: MediaQuery.of(context).size.height * 0.16,
                  child: Container(
                    width: 145,
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                        color: Color(0xFF333333),
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
          ),
        );
    });
  }
}
