import 'package:flutter/material.dart';

class FavoritesView extends StatelessWidget {
  static String name = "favorites_view";
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Views"),
      ),
      body: Center(
        child: const Text("Favoritos"),
      ),
    );
  }
}