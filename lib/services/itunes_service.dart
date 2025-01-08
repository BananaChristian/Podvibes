import 'dart:convert';
import 'package:http/http.dart' as http;

class ItunesService {
  static const _baseUrl='https://itunes.apple.com/search';
  static const _baseLookupUrl='https://itunes.apple.com/lookup';

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

  Future<List<dynamic>> fetchEpisodes(int collectionId) async{
    final url='$_baseLookupUrl?id=$collectionId&entity=podcastEpisode';
    final response=await http.get(Uri.parse(url));

    if (response.statusCode==200){
      final data=json.decode(response.body);
      return (data['results']??[]).where((item)=>item['wrapperType']=='podcastEpisode').toList();
    }else{
      throw Exception('Failed to load episodes');
    }
  }

}