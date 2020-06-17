import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newProject3/MovieBloc/movie_bloc.dart';
import 'package:newProject3/Screens/HomeScreen.dart';
import 'package:newProject3/Services/repository.dart';

void main() {
  Repository repository = new Repository();
  runApp(MyApp(repository: repository));
}

class MyApp extends StatefulWidget {
  final Repository repository;
  MyApp({this.repository});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 MovieBloc  movieBloc;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieBloc = MovieBloc(repository: widget.repository);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers:[

          BlocProvider<MovieBloc>(
            create: (context) => movieBloc,
          ),

        ],
        child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
