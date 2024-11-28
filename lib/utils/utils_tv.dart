class UtilsTv {
  static String? getGenreById(int id) {
    final Map<int, String> genreMap = {
      10759: 'Action & Adventure',
      16: 'Animation',
      35: 'Comedy',
      80: 'Crime',
      99: 'Documentary',
      18: 'Drama',
      10751: 'Family',
      9648: 'Mystery',
      10764: 'Reality',
      27: 'Horror',
      10765: 'Sci-Fi & Fantasy',
      10762: 'Kids',
      10766: 'Soap',
      10763: 'News',
      10767: 'Talk',
      10768: 'War & Politics',
      37: 'Western'
    };

    return genreMap[id];
  }
  static Map<int, String> genreTvMap1 = {
    10759: 'Action & Adventure',
    10768: 'War & Politics',
    16: 'Animation',
    35: 'Comedy',
    80: 'Crime',
    10765: 'Sci-Fi & Fantasy',
    27: 'Horror',
    18: 'Drama',
  };
  static List<String> getTvGenre(){
    List<String> firstEightGenres = [];
    genreTvMap1.forEach((key, value) {
      if (firstEightGenres.length < 8) {
        firstEightGenres.add(value);
      }
    });
    return firstEightGenres;
  }
}
