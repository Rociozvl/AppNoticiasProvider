import 'package:flutter/material.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

import '../services/news_services.dart';

class Tab1Page extends StatefulWidget {
   
 
  
  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    
   final newsService = Provider.of<NewsService>(context);
    return Scaffold(
      body: (newsService.headlines.isEmpty) ? 
      const Center(
        child: CircularProgressIndicator(),
      )
      : ListaNoticias(newsService.headlines)
    );
  }
  
  @override
  // mantenemos el estado al hacer scrollr
  bool get wantKeepAlive => true;
}