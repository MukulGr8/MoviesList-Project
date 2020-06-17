import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newProject3/Models/MovieModal.dart';

class MovieListProvider{

  Future<List<Results>> fetchAllMovie() async {

    String url = "http://api.themoviedb.org/3/movie/popular?api_key=802b2c4b88ea1183e50e6b285a27696e";

    final response = await http.get(url);

    Map result = json.decode(response.body);

    if(response.statusCode == 200){
      return MovieModal.fromJson(result).results;
    }else{
      throw Exception("Some Error Occured in MovieListProvider");
    }


  }

}