import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/src/models/category_models.dart';
import '../models/news_models.dart';

final _URL_NEWS = 'https://newsapi.org/v2/';
final _APIKEY = '83be0ed831ed47968303f3aff1c20391';


class NewsService with ChangeNotifier{
    
    List<Article> headlines = [];
    String _selectedCategory = 'business';
    bool _isLoading = true;

    List<Category> categories = [
      Category(  FontAwesomeIcons.building , 'business'),
      Category( FontAwesomeIcons.tv , 'entertainment'),
      Category(  FontAwesomeIcons.addressCard, 'general'),
      Category( FontAwesomeIcons.headSideVirus, 'health'),
      Category( FontAwesomeIcons.vials , 'science'),
      Category( FontAwesomeIcons.baseball, 'sports'),
      Category( FontAwesomeIcons.memory, 'technology'),

    ];
    Map<String , List<Article>> categoryArticles = {};

    NewsService(){

    getTopHeadLines();


      categories.forEach((item) {
       categoryArticles[item.name] =  [];
      });

      getArticlesByCategory( _selectedCategory );
      
    }

    bool get isLoading => _isLoading;

    String get selectedCategory =>_selectedCategory;

    set selectedCategory( String valor){
      _selectedCategory = valor;

      _isLoading = true;
      getArticlesByCategory( valor );
      notifyListeners();
    }

    List<Article>? get getArticulosCategoriaSeleccionada => categoryArticles[ selectedCategory];

    getTopHeadLines() async {

    final url = Uri.parse('$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=ar');
    final resp = await http.get(url );

    final newResponse  = newResponseFromJson(resp.body );
    headlines.addAll(newResponse.articles);
    notifyListeners();
    }


    getArticlesByCategory( String category) async {
        

        if( categoryArticles[category]!.isNotEmpty){
          this._isLoading = false;
          notifyListeners();
          return categoryArticles[category];
        }

        final url = Uri.parse('$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=ar&category=$category');
        final resp = await http.get(url );

        final newResponse  = newResponseFromJson(resp.body );
        categoryArticles[category]?.addAll( newResponse.articles);
        _isLoading = false;
      
        notifyListeners();
    }
}