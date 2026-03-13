import 'package:flutter/material.dart';

class CustomButtonNavigation extends StatelessWidget {
  
  const CustomButtonNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          label: "Inicio",
          icon: Icon(Icons.home_max)
        ),
        BottomNavigationBarItem(
          label: "Categorías",
          icon: Icon(Icons.label_outlined)
        ),
        BottomNavigationBarItem(
          label: "Favoritos",
          icon: Icon(Icons.favorite_outline)
        )
      ]
    );
  }
}