import 'package:aurify/presentation/bloc/media_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/main.dart';

void main() {
  runApp(const Musicate());
}

class Musicate extends StatelessWidget {
  const Musicate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => MediaBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: ThisApp(),
      ),
    );
  }
}

class ThisApp extends StatelessWidget {
  const ThisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Aurify")),
      body: Center(
        child: ElevatedButton(onPressed: (){
          context.read<MediaBloc>().add(ScanMedia());

        }, child: Text("Scan For Media"))
      ),
    );
  }
}
