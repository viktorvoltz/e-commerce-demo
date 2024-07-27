import 'package:ecommerce/pages/widgets/product_card.dart';
import 'package:ecommerce/provider/product_provider.dart';
import 'package:ecommerce/provider/user_provider.dart';
import 'package:ecommerce/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      //String name = Provider.of<UserProvider>(context, listen: false).user!.name;
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     behavior: SnackBarBehavior.floating,
      //     content: Text(
      //       'welcome $name',
      //     ),
      //   ),
      // );
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'e-Shop',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ColorConstants.systemBlue,
      ),
      body: productProvider.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : productProvider.errorMessage != null
              ? Center(
                  child: Text(productProvider.errorMessage!),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0,
                    childAspectRatio: 2 / 3,
                  ),
                  itemCount: productProvider.products.length,
                  itemBuilder: (context, index) {
                    final product = productProvider.products[index];
                    return AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        double startDelayFactor = 0.1 * index;
                        double endDelayFactor = 0.2;
                        return FadeTransition(
                          opacity: Tween(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                              parent: _controller,
                              curve: Interval(
                                startDelayFactor,
                                1.0 - endDelayFactor,
                                curve: Curves.easeInOut,
                              ),
                            ),
                          ),
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.3),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: _controller,
                                curve: Interval(
                                  startDelayFactor,
                                  1.0 - endDelayFactor,
                                  curve: Curves.easeInOut,
                                ),
                              ),
                            ),
                            child: ProductCard(product: product),
                          ),
                        );
                      },
                      child: ProductCard(product: product),
                    );
                  },
                ),
    );
  }
}
