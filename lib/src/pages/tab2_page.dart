import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_models.dart';

import 'package:newsapp/src/services/news_services.dart';
import 'package:newsapp/src/theme/tema.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({super.key});

  @override
  Widget build(BuildContext context) {

     final newsService = Provider.of<NewsService>(context);
    return  SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
                const _ListaCategorias(),
                if ( !newsService.isLoading )
              Expanded(
                child: ListaNoticias( newsService.getArticulosCategoriaSeleccionada! )
              ),

            if ( newsService.isLoading )
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              )
            )
          ],
          )
        ),
    );
    
  }
}
class _ListaCategorias extends StatelessWidget {
  const _ListaCategorias({super.key});

  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 85,
      child: ListView.builder( 
      
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,          
                  itemCount: categories.length,
                  itemBuilder: (BuildContext contex , int index){
      
                    final cName = categories[index].name;
      
                    return Padding(
                      padding: const EdgeInsets.all(8),
                       child: Column(
                          children: <Widget>[
                            // Icon(categories[index].icon),
                            _CategoryButtom( categories[index]),
                            const SizedBox( height: 5,),
                            Text('${cName[0].toUpperCase()}${cName.substring(1)} '),
                          ],
                        ),
                      );
                      
      
      
                  },
                  ),
    );
  }
}
class _CategoryButtom extends StatelessWidget {


  final Category categoria;
  const _CategoryButtom( this.categoria);

  @override
  Widget build(BuildContext context) {
    final newsService= Provider.of<NewsService>(context  );
    return GestureDetector(
      onTap: (){
        //print('Hola Mundo');
        final newsResponse = Provider.of<NewsService>(context , listen : false);
        newsResponse.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric( horizontal: 10),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
      
        ),
        child: Icon(
          categoria.icon,
          color: ( newsService.selectedCategory == categoria.name)
          ? miTema.colorScheme.secondary 
          : Colors.black54
        ),
        ),
    );
  }
}