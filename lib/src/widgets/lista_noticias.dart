import 'package:flutter/material.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:newsapp/src/theme/tema.dart';


class ListaNoticias extends StatelessWidget {

  final List<Article> noticias;

  const ListaNoticias( this.noticias);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: noticias.length,
      itemBuilder: (BuildContext context , int index){

          return _Noticia(noticia: noticias[index], index: index);
      }
      );
  }
}


class _Noticia extends StatelessWidget {

  final Article noticia;
  final int index;
  
  const _Noticia({required this.noticia, required this.index});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: <Widget>[
        _TarjetaTopBar( noticia , index,),

        _TarjetaTitulo( noticia),

        _TarjetaImagen( noticia),
        _TarjetaBody( noticia),
        _TarjetaBotones()
      ],
    );
  }
}
class _TarjetaBotones extends StatelessWidget {
  const _TarjetaBotones({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
      
         RawMaterialButton(
          onPressed: (){},
          fillColor: miTema.colorScheme.secondary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: const Icon(Icons.star_border),
          ),
          const SizedBox( width: 10),
          RawMaterialButton(
          onPressed: (){},
          fillColor: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: const Icon(Icons.more),
          )
          
        ],
      )
    );
  }
}
class _TarjetaBody extends StatelessWidget {
   final Article noticia;

  const _TarjetaBody(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text( (noticia.description != null ) ? noticia.description : ''),
    );
  }
}
class _TarjetaImagen extends StatelessWidget {
  final Article noticia;
  const _TarjetaImagen(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: ClipRRect(
        borderRadius: const BorderRadius.all( Radius.circular(50)),
        child: Container(
          child:( noticia.urlToImage != null ) 
                  ? FadeInImage(
                      placeholder: const AssetImage( 'assets/img/giphy.gif' ), 
                      image: NetworkImage( noticia.urlToImage )
                    )
                  : const Image( image: AssetImage('assets/img/no-image.png'), )
            ),
      ),
    );
  
  }
}
class _TarjetaTitulo extends StatelessWidget {
  
  final Article noticia;

  const _TarjetaTitulo( this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only( bottom: 15),
      padding: const EdgeInsets.symmetric( horizontal: 10),
      child : 
     
        Text(noticia.title , style:  const TextStyle( fontSize: 20 , fontWeight: FontWeight.w400),)
      
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {

  final Article noticia;
  final int index;
  const _TarjetaTopBar( 
    this.noticia, this.index,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
           padding: const EdgeInsets.symmetric( horizontal : 10),
           margin: const EdgeInsets.only( bottom: 10),
           child:  Row(
            children: [
             Text('${ index + 1}.'  , style: TextStyle( color: miTema.colorScheme.secondary),),
             Text(noticia.author)
            ],
           ),
    );
  }
}