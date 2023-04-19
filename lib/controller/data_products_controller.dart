import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../class/product_class.dart';
import '../class/provider_total_cart.dart';
import '../main.dart';

class DataProductsState extends State<DataProducts> {
  List<Products> _products = [];
  static String imagenURL =
      'https://staticuestudio.blob.core.windows.net/buhomag/2016/03/01195417/pexels-com.jpg';

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
    return _products.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: _products.length,
            itemBuilder: (context, index) {
              final product = _products[index];
              return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
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
                          image: NetworkImage(product.image ?? imagenURL),
                          placeholder: const AssetImage('assets/loading.gif'),
                          fit: BoxFit.cover,
                          height: 260,
                        ),
                        Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text("\$${product.price}",
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                softWrap: false,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.purple))),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Text(product.description ?? 'Sin descripcion'),
                        ),
                        TextButton(
                            onPressed: () {
                              Provider.of<Counter>(context, listen: false).increment();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    "El producto se agrego al carrito: ${product.title}"),
                              ));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Icon(Icons.shopping_cart),
                                Text('Agregar al carrito'),
                              ],
                            ))
                      ],
                    ),
                  ));
            },
          );
  }
}