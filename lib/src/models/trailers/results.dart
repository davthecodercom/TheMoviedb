
class Results {

  final String id;
  final String iso_639_1;
  final String iso_3166_1;
  final String key;
  final String name;
  final String site;
  final int size;
  final String type;

	Results.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		iso_639_1 = map["iso_639_1"],
		iso_3166_1 = map["iso_3166_1"],
		key = map["key"],
		name = map["name"],
		site = map["site"],
		size = map["size"],
		type = map["type"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['iso_639_1'] = iso_639_1;
		data['iso_3166_1'] = iso_3166_1;
		data['key'] = key;
		data['name'] = name;
		data['site'] = site;
		data['size'] = size;
		data['type'] = type;
		return data;
	}
}
