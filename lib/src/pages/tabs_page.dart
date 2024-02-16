import 'package:flutter/material.dart';
import 'package:newsapp/src/pages/tab1_page.dart';
import 'package:newsapp/src/pages/tab2_page.dart';

import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return   ChangeNotifierProvider(
      create: (_)=> _NavegacionModel(),
      child: const Scaffold(
       body : _Paginas(),
       bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  const _Navegacion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

  final navegacionModel = Provider.of<_NavegacionModel>(context);
 

    return BottomNavigationBar(
      onTap: (i) => navegacionModel.paginaActual = i,
      currentIndex: navegacionModel.paginaActual,
      items: const [
      BottomNavigationBarItem(icon: Icon(Icons.person) , label: 'For you'),
      BottomNavigationBarItem(icon: Icon(Icons.public) , label: 'Headers')
    ]);
  }
}

class _Paginas extends StatelessWidget {
  const _Paginas({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return PageView(
      controller: navegacionModel.pageController,
    //physics: const BouncingScrollPhysics(),
    physics: const NeverScrollableScrollPhysics(),
       children: <Widget>[
         Tab1Page(),
         Tab2Page()
         ],
     );
  }
}


class _NavegacionModel with ChangeNotifier{
   int _paginaActual = 0;
   PageController _pageController =  PageController();
   int get paginaActual => _paginaActual;

   

   set paginaActual(int valor){
    _paginaActual = valor;
    _pageController.animateToPage(valor, duration:const Duration( milliseconds: 250) , curve: Curves.easeInOut  );
    notifyListeners();
}
   PageController get pageController => _pageController;
}