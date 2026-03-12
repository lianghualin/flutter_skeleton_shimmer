// example/lib/pages/product_cards_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_skeleton_shimmer/flutter_skeleton_shimmer.dart';

class ProductCardsPage extends StatelessWidget {
  final bool isLoading;
  const ProductCardsPage({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(12),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 0.7,
      children: [
        _productCard(context, 'Wireless Headphones', '\$89.99', 4),
        _productCard(context, 'Smart Watch', '\$199.99', 5),
        _productCard(context, 'Bluetooth Speaker', '\$49.99', 3),
        _productCard(context, 'Phone Case', '\$24.99', 4),
      ],
    );
  }

  Widget _productCard(BuildContext context, String name, String price, int stars) {
    return Shimmerize(
      enabled: isLoading,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Bone(
              width: double.infinity,
              height: 120,
              child: Container(
                height: 120,
                color: const Color(0xFFE8E0F0),
                child: const Center(
                    child: Icon(Icons.image, size: 40, color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: Theme.of(context).textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Bone(
                    width: 70,
                    height: 24,
                    borderRadius: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(price,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              )),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(
                      5,
                      (i) => Bone.circle(
                        size: 16,
                        child: Icon(
                          i < stars ? Icons.star : Icons.star_border,
                          size: 16,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
