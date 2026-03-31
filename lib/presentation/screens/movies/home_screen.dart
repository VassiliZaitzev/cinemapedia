import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static String name = "home_screen";
  final Widget childView;
  const HomeScreen({
    super.key,
    required this.childView
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text("Home Screen"),
      ),*/
      //body: HomeView(),
      body: childView,
      bottomNavigationBar: CustomButtonNavigation()
    );
  }
}
