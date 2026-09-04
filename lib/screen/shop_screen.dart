import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:first_app/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final List<String> _slider = [
  'assets/banner/banner1.jpg',
  'assets/banner/banner2.jpg',
  'assets/banner/banner3.jpg',
  'assets/banner/banner4.jpg',
];

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  int _currentSlide = 0;

  final List<Product> _exclusiveOffer = [
    Product(
      id: 1,
      name: 'Organic Bananas',
      subtitle: '7pcs, Price',
      image: 'assets/items/item1.png',
      price: 4.99,
      description: 'Fresh organic bananas',
    ),
    Product(
      id: 2,
      name: 'Red Apple',
      subtitle: '1kg, Price',
      image: 'assets/items/item2.png',
      price: 8.99,
      description: 'Crisp red apples',
    ),
    Product(
      id: 3,
      name: 'Organic Orange',
      subtitle: '100g, Price',
      image: 'assets/items/item3.png',
      price: 2.99,
      description: 'Sweet oranges',
    ),
  ];

  final List<Product> _bestSelling = [
    Product(
      id: 4,
      name: 'Red Pepper',
      subtitle: '100g, Price',
      image: 'assets/items/item4.png',
      price: 2.79,
      description: 'Fresh red pepper',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 12),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/img/logo.png', height: 30),
                  const SizedBox(height: 12),
                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_on_rounded, size: 20),
                      SizedBox(width: 4),
                      Text(
                        'Phnom Penh, Cambodia',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          height: 1.0,
                          color: Color(0xFF4C4F4D),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CupertinoSearchTextField(
                placeholder: 'Search your product',
                backgroundColor: const Color(0xFFF2F3F2),
                borderRadius: BorderRadius.circular(16),
                prefixInsets: const EdgeInsets.only(left: 16, right: 8),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
                placeholderStyle: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF7C7C7C),
                ),
              ),
            ),

            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CarouselSlider(
                  items: [
                    for (var slide in _slider)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            slide,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                  ],
                  options: CarouselOptions(
                    height: 130,
                    autoPlay: true,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() => _currentSlide = index);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _buildIndicator(),
                ),
              ],
            ),

            const SizedBox(height: 24),
            _buildSectionHeader('Exclusive Offer'),
            const SizedBox(height: 12),
            _buildProductList(_exclusiveOffer),
            const SizedBox(height: 24),
            _buildSectionHeader('Best Selling'),
            const SizedBox(height: 12),
            _buildProductList(_bestSelling),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFF181725),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Text(
              'See all',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF53B175),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList(List<Product> products) {
    return SizedBox(
      height: 250,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: products.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) => _buildProductCard(products[index]),
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E2E2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                product.image,
                fit: BoxFit.contain,
                height: 280,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF181725),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            product.subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF7C7C7C),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF181725),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: const Color(0xFF53B175),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 22),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withValues(alpha: 0.2),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              _slider.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: index == _currentSlide ? 12 : 6,
                height: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: index == _currentSlide ? Colors.green : Colors.white70,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}