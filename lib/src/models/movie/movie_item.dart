import 'package:themoviedb_flutter/src/models/movie/results.dart';

class MovieItem {

  final int page;
  final int total_results;
  final int total_pages;
  final List<Results> results;

	MovieItem.fromJsonMap(Map<String, dynamic> map):
		page = map["page"],
		total_results = map["total_results"],
		total_pages = map["total_pages"],
		results = List<Results>.from(map["results"].map((it) => Results.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['page'] = page;
		data['total_results'] = total_results;
		data['total_pages'] = total_pages;
		data['results'] = results != null ? 
			this.results.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
