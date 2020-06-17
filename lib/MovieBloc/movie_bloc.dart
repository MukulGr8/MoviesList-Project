import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newProject3/Models/MovieModal.dart';
import 'package:newProject3/MovieBloc/movie_events.dart';
import 'package:newProject3/MovieBloc/movie_state.dart';
import 'package:newProject3/Services/repository.dart';

class MovieBloc extends Bloc<MovieEvents,MovieStates>{
  final Repository repository;
  MovieBloc({this.repository});

  @override
  // TODO: implement initialState
  MovieStates get initialState => MovieLoad();

  @override
  Stream<MovieStates> mapEventToState(MovieEvents event) async* {
    // TODO: implement mapEventToState
    try {
      if(event is MovieIntailized){
        yield MovieLoad();
  
        final List<Results> movies = await repository.fetchAllMovie();
  
        if(movies.length > 0){
          yield MovieFetched(results: movies);
        }else{
          yield MovieEmpty();
        }
      }
    } catch (error) {
      print(error);
      yield MovieError();
    }
  }
}