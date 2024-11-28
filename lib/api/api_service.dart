import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/movies/casts.dart';
import '../models/movies/movie.dart';
import '../models/movies/review.dart';
import '../models/movies/similar.dart';
import '../models/person/person.dart';
import '../models/person/person_movie.dart';
import '../models/person/person_tv.dart';
import '../models/search/search.dart';
import '../models/trending/trending.dart';
import '../models/trending/trending_tv.dart';
import '../models/tv/cast_tv.dart';
import '../models/tv/review_tv.dart';
import '../models/tv/similar_tv.dart';
import '../models/tv/tv_model.dart';
import '../models/video/video.dart';
import '../models/video/video_tv.dart';
import 'api.dart';

class ApiService {
  static Future<List<PersonTv>?> getPersonsTv(int id,{bool sortByPopularity = true}) async {
    List<PersonTv> personTv = [];
    Set<int> tvIds = {};
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}person/$id/tv_credits?api_key=${Api.apiKey}&language=en-US'));
      var res = jsonDecode(response.body);
      res['crew'].forEach(
            (m) {
          final tvId = m['id'];
          if (!tvIds.contains(tvId)) {
            tvIds.add(tvId);
            personTv.add(
              PersonTv.fromMap(m),
            );
          }
        },
      );
      res['cast'].forEach(
            (m) {
          final tvId = m['id'];
          if (!tvIds.contains(tvId)) {
            tvIds.add(tvId);
            personTv.add(
              PersonTv.fromMap(m),
            );
          }
        },
      );
      if (sortByPopularity) {
        personTv.sort((a, b) => b.voteAverage.compareTo(a.voteAverage));
      }
      return personTv;
    } catch (e) {
      return null;
    }
  }
  static Future<List<PersonMovie>?> getPersonsMovie(int id,{bool sortByPopularity = true}) async {
    List<PersonMovie> personMovie = [];
    Set<int> movieIds = {};
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}person/$id/movie_credits?api_key=${Api.apiKey}&language=en-US'));
      var res = jsonDecode(response.body);
      res['crew'].forEach(
            (m) {
          final movieId = m['id'];
          if (!movieIds.contains(movieId)) {
            movieIds.add(movieId);
            personMovie.add(
              PersonMovie.fromMap(m),
            );
          }
        },
      );
      res['cast'].forEach(
            (m) {
          final movieId = m['id'];
          if (!movieIds.contains(movieId)) {
            movieIds.add(movieId);
            personMovie.add(
              PersonMovie.fromMap(m),
            );
          }
        },
      );
      if (sortByPopularity) {
        personMovie.sort((a, b) => b.voteAverage.compareTo(a.voteAverage));
      }
      return personMovie;
    } catch (e) {
      return null;
    }
  }
  static Future<List<Person>?> getPersons(int id) async {
    List<Person> person = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}person/$id?api_key=${Api.apiKey}&language=en-US&sort_by=popularity.desc'));
      var res = jsonDecode(response.body);
      person.add(
        Person.fromMap(res),
      );

      return person;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Trending>?> getTrending(String url) async {
    List<Trending> trends = [];
    int page = 1;
    int totalPages = 0;
    int maxPages = 10;
    try {
      do{
        http.Response response = await http.get(Uri.parse(
            '${Api.baseUrl}trending/$url/day?api_key=${Api.apiKey}&language=en-US&page=$page'));
        var res = jsonDecode(response.body);
        res['results'].forEach(
              (m) => trends.add(
            Trending.fromMap(m),
          ),
        );
        totalPages = res['total_pages'];
        page++;
      }
      while (page <= totalPages && page <= maxPages);
      return trends;
    } catch (e) {
      return null;
    }
  }
  static Future<List<TrendingTv>?> getTrendingTv() async {
    List<TrendingTv> trends = [];
    int page = 1;
    int totalPages = 0;
    int maxPages = 10;
    try {
      do{
        http.Response response = await http.get(Uri.parse(
            '${Api.baseUrl}trending/tv/day?api_key=${Api.apiKey}&language=en-US&page=$page'));
        var res = jsonDecode(response.body);
        res['results'].forEach(
              (m) => trends.add(
            TrendingTv.fromMap(m),
          ),
        );
        totalPages = res['total_pages'];
        page++;
      }
      while (page <= totalPages && page <= maxPages);
      return trends;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Movie>?> getCustomMovies(String url) async {
    List<Movie> movies = [];
    int page = 1;
    int totalPages = 0;
    int maxPages = 10;
    try {
      do{
      http.Response response = await http.get(Uri.parse(
              '${Api.baseUrl}movie/$url?api_key=${Api.apiKey}&language=en-US&page=$page'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
            (m) => movies.add(
              Movie.fromMap(m),
            ),
          );
      totalPages = res['total_pages'];
      page++;
      }
      while (page <= totalPages && page <= maxPages);
      return movies;
    } catch (e) {
      return null;
    }
  }
  static Future<List<Movie>?> getAnimeMovie(String url) async {
    List<Movie> movie = [];
    int page = 1;
    int totalPages = 0;
    int maxPages = 10;
    try {
      do{
        http.Response response = await http.get(Uri.parse(
            '${Api.baseUrl}movie/$url?&api_key=${Api.apiKey}&language=en-US&with_keywords=210024&page=$page'));
        var res = jsonDecode(response.body);
        res['results'].forEach(
              (m) => movie.add(
                Movie.fromMap(m),
          ),
        );
        totalPages = res['total_pages'];
        page++;
      }
      while (page <= totalPages && page <= maxPages);
      return movie;
    } catch (e) {
      return null;
    }
  }
  static Future<List<Similar>?> getRecMovies(int movieId) async {
    List<Similar> similar = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}movie/$movieId/recommendations?api_key=${Api.apiKey}&language=en-US'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
            (m) => similar.add(
          Similar.fromMap(m),
        ),
      );
      return similar;
    } catch (e) {
      return null;
    }
  }
  static Future<List<Review>?> getReviewMovies(int movieId) async {
    List<Review> review = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}movie/$movieId/reviews?api_key=${Api.apiKey}&language=en-US'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
            (m) => review.add(
          Review.fromMap(m),
        ),
      );
      return review;
    } catch (e) {
      return null;
    }
  }
  static Future<List<Cast>?> getCastMovies(int movieId) async {
    List<Cast> cast = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}movie/$movieId/credits?api_key=${Api.apiKey}&language=en-US'));
      var res = jsonDecode(response.body);
      res['crew'].forEach(
            (m) {
         if (m['job'] == 'Director') {
          cast.add(
            Cast.fromMap(m),
          );
          }
        },
      );
      res['cast'].forEach(
            (m) => cast.add(
          Cast.fromMap(m),
        ),
      );
      return cast;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Video>?> getVideoMovies(int movieId,) async {
    List<Video> video = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}movie/$movieId/videos?api_key=${Api.apiKey}&language=en-US'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
            (m) => video.add(
             Video.fromMap(m),
        ),
      );
      if (video.isEmpty) {
        return null;
      }
      return video;
    } catch (e) {
      return null;
    }
  }
  static Future<List<VideoTv>?> getVideoTv(int tvId,) async {
    List<VideoTv> video = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}tv/$tvId/videos?api_key=${Api.apiKey}&language=en-US'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
            (m) => video.add(
              VideoTv.fromMap(m),
        ),
      );
      if (video.isEmpty) {
        return null;
      }
      return video;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Tv>?> getCustomTvShows(String url) async {
      List<Tv> tv = [];
      int page = 1;
      int totalPages = 0;
      int maxPages = 10;
      try {
        do{
          http.Response response = await http.get(Uri.parse(
              '${Api.baseUrl}tv/$url?&api_key=${Api.apiKey}&watch_region=US&with_watch_monetization_types=flatrate&language=en-US&without_keywords=210024&without_genres=10767&page=$page'));
          var res = jsonDecode(response.body);
          res['results'].forEach(
                (m) => tv.add(
                  Tv.fromMap(m),
            ),
          );
          totalPages = res['total_pages'];
          page++;
        }
        while (page <= totalPages && page <= maxPages);
        return tv;
      } catch (e) {
        return null;
      }
    }
  static Future<List<Tv>?> getAnimeTvShows(String url) async {
      List<Tv> tv = [];
      int page = 1;
      int totalPages = 0;
      int maxPages = 10;
      try {
        do{
          http.Response response = await http.get(Uri.parse(
              '${Api.baseUrl}tv/$url?&api_key=${Api.apiKey}&language=en-US&with_keywords=210024&page=$page'));
          var res = jsonDecode(response.body);
          res['results'].forEach(
                (m) => tv.add(
                  Tv.fromMap(m),
            ),
          );
          totalPages = res['total_pages'];
          page++;
        }
        while (page <= totalPages && page <= maxPages);
        return tv;
      } catch (e) {
        return null;
      }
    }
  static Future<List<SimilarTv>?> getReTv(int movieId) async {
    List<SimilarTv> similar = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}tv/$movieId/recommendations?api_key=${Api.apiKey}&language=en-US'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
            (m) => similar.add(
              SimilarTv.fromMap(m),
        ),
      );
      return similar;
    } catch (e) {
      return null;
    }
  }
  static Future<List<ReviewTv>?> getReviewTv(int movieId) async {
    List<ReviewTv> review = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}tv/$movieId/reviews?api_key=${Api.apiKey}&language=en-US'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
            (m) => review.add(
              ReviewTv.fromMap(m),
        ),
      );
      return review;
    } catch (e) {
      return null;
    }
  }
  static Future<List<CastTv>?> getCastTv(int movieId) async {
    List<CastTv> cast = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}tv/$movieId/credits?api_key=${Api.apiKey}&language=en-US'));
      var res = jsonDecode(response.body);
      res['crew'].forEach(
            (m) {
          if (m['job'] == 'Director' || m['job'] == 'Screenplay'
              || m['job'] == 'Writer' || m['job'] == 'Producer'
              || m['job'] == 'Author'
          ) {
            cast.add(
              CastTv.fromMap(m),
            );
          }
        },
      );
      res['cast'].forEach(
            (m) => cast.add(
              CastTv.fromMap(m),
        ),
      );
      return cast;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Search>?> getSearchedMovies(String query,String lang) async {
    List<Search> search = [];
    String encodedQuery = Uri.encodeComponent(query);
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}search/multi?query=$encodedQuery&api_key=${Api.apiKey}&language=$lang&page=1'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
            (m) => search.add(
              Search.fromMap(m),
        ),
      );
      return search;
    } catch (e) {
      return null;
    }
  }
  static Future<List<Movie>?> getMovieWithGenre(int genreId) async {
    List<Movie> movie = [];
    int page = 1;
    int totalPages = 0;
    int maxPages = 3;
    try {
      do{
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}discover/movie?api_key=${Api.apiKey}&language=en-US&with_genres=$genreId&sort_by=popularity.desc&page=$page'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
            (m) => movie.add(
              Movie.fromMap(m),
        ),
      );
      totalPages = res['total_pages'];
      page++;
      }
      while (page <= totalPages && page <= maxPages);
      return movie;
    } catch (e) {
      return null;
    }
  }
  static Future<List<Tv>?> getTvWithGenre(int genreId) async {
    List<Tv> tv = [];
    int page = 1;
    int totalPages = 0;
    int maxPages = 3;
    try {
      do{
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}discover/tv?api_key=${Api.apiKey}&language=en-US&with_genres=$genreId&sort_by=popularity.desc&page=$page'));
      var res = jsonDecode(response.body);
      if (res.containsKey('results') && res['results'] is List) {
        for (var m in res['results']) {
          tv.add(Tv.fromMap(m));
        }
      }
      totalPages = res['total_pages'];
      page++;
    }
    while (page <= totalPages && page <= maxPages);
      return tv;
    } catch (e) {
      return null;
    }
  }

}

