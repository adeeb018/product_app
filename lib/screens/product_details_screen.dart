

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductDetailsPage extends StatelessWidget {

  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the arguments passed to this screen
    final Product product = ModalRoute.of(context)?.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Center(
                child: CachedNetworkImage(
                  key: ValueKey(product.partImage),
                  imageUrl: product.partImage,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              // Product Name
              SizedBox(height: 16.0),
              Text(
                product.partsName ?? "No name available",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Product Description
              SizedBox(height: 8.0),
              Text(
                product.description,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[700],
                ),
              ),
              // Product Price
              SizedBox(height: 8.0),
              Text(
                'Price: ₹${product.price}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              // Offer Price (if available)
              if (product.offerPrice != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.0),
                    Text(
                      'Offer Price: ₹${product.offerPrice}',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              // Product Rating
              SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  Text(
                    ' ${product.productRating}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              // Offer Status
              SizedBox(height: 8.0),
              Text(
                product.isOffer ? 'This product is on offer!' : 'No current offer',
                style: TextStyle(
                  fontSize: 16.0,
                  color: product.isOffer ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}