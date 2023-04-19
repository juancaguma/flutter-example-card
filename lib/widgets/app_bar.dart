import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../class/provider_total_cart.dart';

AppBar AppBarList(BuildContext context) {
    return AppBar(
      title: const Text(
        'Lista de productos',
      ),
      actions: <Widget>[
        Stack(children: <Widget>[
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
          Positioned(
              top: 0.0,
              right: 0.0,
              child: Container(
                padding: const EdgeInsets.all(1.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                constraints: const BoxConstraints(
                  minWidth: 16.0,
                  minHeight: 16.0,
                ),
                child: Consumer<Counter>(
                  builder: (BuildContext context, counter, child) { 
                  return
                    Text(
                      '${counter.count}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                      textAlign: TextAlign.center,
                    );
                   },
                ),
              ))
        ]),
      ],
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.of(context).pop(),
      ),
      
      
      automaticallyImplyLeading: true,
    );
  }