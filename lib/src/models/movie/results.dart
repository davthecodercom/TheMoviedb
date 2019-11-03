
class Results {

  final double popularity;
  final int vote_count;
  final bool video;
  final String poster_path;
  final int id;
  final bool adult;
  final String backdrop_path;
  final String original_language;
  final String original_title;
  final List<int> genre_ids;
  final String title;
  final String vote_average;
  final String overview;
  final String release_date;

	Results.fromJsonMap(Map<String, dynamic> map): 
		popularity = map["popularity"],
		vote_count = map["vote_count"],
		video = map["video"],
		poster_path = map["poster_path"],
		id = map["id"],
		adult = map["adult"],
		backdrop_path = map["backdrop_path"],
		original_language = map["original_language"],
		original_title = map["original_title"],
		genre_ids = List<int>.from(map["genre_ids"]),
		title = map["title"],
		vote_average = map["vote_average"].toString(),
		overview = map["overview"],
		release_date = map["release_date"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['popularity'] = popularity;
		data['vote_count'] = vote_count;
		data['video'] = video;
		data['poster_path'] = poster_path;
		data['id'] = id;
		data['adult'] = adult;
		data['backdrop_path'] = backdrop_path;
		data['original_language'] = original_language;
		data['original_title'] = original_title;
		data['genre_ids'] = genre_ids;
		data['title'] = title;
		data['vote_average'] = vote_average;
		data['overview'] = overview;
		data['release_date'] = release_date;
		return data;
	}
}
