import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product-details',
          arguments: product, // Passing the product as an argument
        );
      },
      child: Card(
        color: Colors.white,
        shadowColor: Colors.blue,
        surfaceTintColor: Colors.black,
        key: ValueKey(product.id),
        margin: EdgeInsets.all(8.0),
        child: ListTile(
          leading: SizedBox(
            width: 70,
            height: 70,
            child: CachedNetworkImage(
              key: ValueKey(product.partImage),
              imageUrl: product.partImage,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          title: Text(product.description ?? 'No name Available'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  Text(
                    ' ${product.productRating}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              Text(
                "Price: ₹${product.price}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
