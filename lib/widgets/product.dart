import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(product.id),
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: SizedBox(
          width: 50, // Set the desired width for the leading widget
          height: 50, // Set the desired height for the leading widget
          child: CachedNetworkImage(
            key: ValueKey(product.partImage),
            imageUrl: product.partImage,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        title: Text(product.description),
        subtitle: Text("Price: \$${product.price}"),
        trailing: IconButton(
          icon: Icon(Icons.arrow_forward),
          onPressed: () {},
        ),
      ),
    );
  }
}
