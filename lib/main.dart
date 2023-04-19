import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'class/provider_total_cart.dart';
import 'controller/data_products_controller.dart';
import 'widgets/app_bar_list.dart';
import 'widgets/bottom_navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => Counter(),
      child: MaterialApp(
        title: 'Ecommerce test',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBarScreen(),
      body: const DataProducts(),
      bottomNavigationBar: const ButtonNavigationBar(),
    );
  }

 
}

class DataProducts extends StatefulWidget {
  const DataProducts({super.key});

  @override
  State<DataProducts> createState() => DataProductsState();
}
