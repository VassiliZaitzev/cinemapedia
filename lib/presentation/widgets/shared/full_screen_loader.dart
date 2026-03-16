import 'package:flutter/material.dart';



class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});
  

  Stream<String> getLoadingMessages() {

    final List<String> messages = [
      "Cargando Peliculas",
      "Esto está tardando más de lo esperado :c",
      "Mientras anda al baño",
      "Házte unas palomillas"
    ];

    return Stream.periodic(
      Duration(milliseconds: 1200),
      (step) {
        return messages[step];
      }
    ).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Espere por favor"),
          SizedBox(height: 20),
          const CircularProgressIndicator(strokeWidth: 2),
          SizedBox(height: 20),

          StreamBuilder(
            stream: getLoadingMessages(), 
            builder: (context, snapshot) {
              if(!snapshot.hasData) return Text("Cargando");

              return Text(snapshot.data!);
            },
          )
        ],
      ),
    );
  }
}