import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/model/product_model.dart';
import 'package:ecommerce/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final showDiscountedPrice =
        Provider.of<ProductProvider>(context).showDiscountedPrice;

    return Card(
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            alignment: Alignment.center,
            imageUrl: product.images![0]!,
            height: 120,
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: double.infinity,
                height: 120,
                color: Colors.grey[300],
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.title!,
              maxLines: 2,
              style: const TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              product.description!,
              maxLines: 3,
              style: const TextStyle(fontWeight: FontWeight.normal),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: showDiscountedPrice
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text(
                          '\$${product.price}',
                          style: const TextStyle(
                              decoration: TextDecoration.lineThrough),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '\$${product.discountedPrice.toStringAsFixed(2)}',
                          style: const TextStyle(color: Colors.black),
                        ),
                        Text(
                          ' ${product.discountPercentage}% off',
                          style: const TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  )
                : Text('\$${product.price}'),
          ),
        ],
      ),
    );
  }
}
