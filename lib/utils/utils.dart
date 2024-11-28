class Utils {
  static String? getGenreById(int id) {
    final Map<int, String> genreMap = {
      28: 'Action',
      12: 'Adventure',
      16: 'Animation',
      35: 'Comedy',
      80: 'Crime',
      99: 'Documentary',
      18: 'Drama',
      10751: 'Family',
      14: 'Fantasy',
      36: 'History',
      27: 'Horror',
      10402: 'Music',
      9648: 'Mystery',
      10749: 'Romance',
      878: 'Science Fiction',
      10770: 'TV Movie',
      53: 'Thriller',
      10752: 'War',
      37: 'Western'
    };

    return genreMap[id];
  }
  static Map<int, String> genreMap1 = {
    28: 'Action',
    12: 'Adventure',
    16: 'Animation',
    35: 'Comedy',
    80: 'Crime',
    27: 'Horror',
    18: 'Drama',
    10752: 'War',
  };
  static List<String> getGenre(){
    List<String> firstEightGenres = [];
    genreMap1.forEach((key, value) {
      if (firstEightGenres.length < 8) {
        firstEightGenres.add(value);
      }
    });
    return firstEightGenres;
  }
}
