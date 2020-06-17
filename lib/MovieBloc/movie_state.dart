import 'package:newProject3/Models/MovieModal.dart';

abstract class MovieStates{}

class MovieLoad extends MovieStates{}
class MovieError extends MovieStates{}
class MovieFetched extends MovieStates{
  final List<Results> results;
  MovieFetched({this.results});
}
class MovieEmpty extends MovieStates{}
// class MovieLoad extends MovieStates{}