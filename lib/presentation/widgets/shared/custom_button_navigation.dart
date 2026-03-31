import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomButtonNavigation extends StatelessWidget {
  final int currentIndex;
  const CustomButtonNavigation({
    required this.currentIndex,
    super.key
  });

  void onItemTapped(BuildContext context, int index){
    context.go("/home/$index");
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (value) {
        onItemTapped(context, value);
      },
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