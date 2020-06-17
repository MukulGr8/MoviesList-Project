import 'package:newProject3/Models/MovieModal.dart';
import 'package:newProject3/Services/movieListProvider.dart';

class Repository{

  MovieListProvider _movieListProvider = new MovieListProvider();

  Future<List<Results>> fetchAllMovie() => _movieListProvider.fetchAllMovie();
  
}