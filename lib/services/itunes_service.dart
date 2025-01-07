import 'dart:convert';
import 'package:http/http.dart' as http;

class ItunesService {
  static const _baseUrl='https://itunes.apple.com/search';

  Future<List<dynamic>> fetchPodcasts(String query) async{
    final url=query.isEmpty?'$_baseUrl?media=podcast&limit=20':'$_baseUrl?media=podcast&term=$query&limit=20';
    final response=await http.get(Uri.parse(url));

    if(response.statusCode==200){
      final data=json.decode(response.body);
      return data['results']??[];
    }else{
      throw Exception('Failed to load podcasts');
    }
  }

}