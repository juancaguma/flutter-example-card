import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'class/product_class.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBarScreen(), body: const DataProducts());
  }
}

class DataProducts extends StatefulWidget {
  const DataProducts({super.key});

  @override
  State<DataProducts> createState() => _DataProductsState();
}

class _DataProductsState extends State<DataProducts> {
  List<Products> _products = [];
  static String imagenURL = 'https://staticuestudio.blob.core.windows.net/buhomag/2016/03/01195417/pexels-com.jpg';

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products/'));
    final List<dynamic> data = json.decode(response.body);
    setState(() {
      _products = data.map((json) => Products.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
    _products.isEmpty ? const Center(
      child: CircularProgressIndicator(),
    )  :
     ListView.builder(
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final product = _products[index];
        return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            margin: const EdgeInsets.all(15),
            elevation: 10,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(product.title),
                  ),
                  FadeInImage(
                    image: NetworkImage(
                        product.image ?? imagenURL),
                    placeholder: const AssetImage('assets/loading.gif'),
                    fit: BoxFit.cover,
                    height: 260,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text("${product.price} Pesos",
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        softWrap: false,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.amberAccent))),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(product.description ?? 'Sin descripcion'),
                  )
                ],
              ),
            ));
      },
    );
  }
}

class AppBarScreen extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  AppBarScreen({Key? key})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Lista de productos',
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.of(context).pop(),
      ),
      automaticallyImplyLeading: true,
    );
  }
}
