import 'package:first_app/models/product.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  // 🔢 quantity selector state
  int _quantity = 1;

  // ❤️ favorite toggle state
  bool _isFavorite = false;

  // 📖 "Product Detail" expand/collapse state (open by default, matching screenshot)
  bool _isDetailExpanded = true;

  static const Color primaryGreen = Color(0xFF53B175);

  void _incrementQuantity() {
    setState(() => _quantity++);
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() => _quantity--);
    }
  }

  void _toggleFavorite() {
    setState(() => _isFavorite = !_isFavorite);
  }

  void _toggleDetail() {
    setState(() => _isDetailExpanded = !_isDetailExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageHeader(context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleRow(),
                  const SizedBox(height: 4),
                  const Text(
                    '1kg, Price',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  _buildQuantityAndPriceRow(),
                  const SizedBox(height: 20),
                  const Divider(height: 1),
                  _buildProductDetailSection(),
                  const Divider(height: 1),
                  _buildSimpleRow(
                    title: 'Nutritions',
                    trailing: const Text(
                      '100g',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ),
                  const Divider(height: 1),
                  _buildReviewRow(),
                  const Divider(height: 1),
                  const SizedBox(height: 24),
                  _buildAddToBasketButton(),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🖼️ Top image with back button, share button, and dot indicator
  Widget _buildImageHeader(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
      child: Stack(
        children: [
          Image.asset(
            'assets/img/product_1.png',
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
          ),
          // ⬅️ Back button
          Positioned(
            top: 48,
            left: 16,
            child: _circleIconButton(
              icon: Icons.arrow_back_ios_new,
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
          // 📤 Share button
          Positioned(
            top: 48,
            right: 16,
            child: _circleIconButton(
              icon: Icons.ios_share,
              onTap: () {
                // TODO: wire up Share.share() from the share_plus package
              },
            ),
          ),
          // ⚪⚪⚪ Dot page indicator
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                final bool isActive = index == 0;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: isActive ? 18 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: isActive ? primaryGreen : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(3),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  // ⬅️/📤 small circular icon button used on top of the image
  Widget _circleIconButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: Colors.black87),
      ),
    );
  }

  // 🏷️ Title + favorite heart icon
  Widget _buildTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Naturel Red Apple',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: _toggleFavorite,
          child: Icon(
            _isFavorite ? Icons.favorite : Icons.favorite_border,
            color: _isFavorite ? Colors.red : Colors.black54,
          ),
        ),
      ],
    );
  }

  // ➖ 1️⃣ ➕ quantity stepper + price on the right
  Widget _buildQuantityAndPriceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _stepperButton(icon: Icons.remove, onTap: _decrementQuantity),
            Container(
              width: 44,
              alignment: Alignment.center,
              child: Text(
                '$_quantity',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            _stepperButton(
              icon: Icons.add,
              onTap: _incrementQuantity,
              filled: true,
            ),
          ],
        ),
        const Text(
          '\$4.99',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _stepperButton({
    required IconData icon,
    required VoidCallback onTap,
    bool filled = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: filled ? primaryGreen.withOpacity(0.15) : Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Icon(
          icon,
          size: 16,
          color: filled ? primaryGreen : Colors.black54,
        ),
      ),
    );
  }

  // 📖 Expandable "Product Detail" section
  Widget _buildProductDetailSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: _toggleDetail,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Product Detail',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                AnimatedRotation(
                  turns: _isDetailExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(Icons.keyboard_arrow_down),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox(width: double.infinity),
          secondChild: Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Text(
              'Apples Are Nutritious. Apples May Be Good For Weight '
              'Loss. Apples May Be Good For Your Heart. As Part Of A '
              'Healthful And Varied Diet.',
              style: TextStyle(
                fontSize: 13.5,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),
          ),
          crossFadeState: _isDetailExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
      ],
    );
  }

  // ⭐ Review row with a 5-star rating
  Widget _buildReviewRow() {
    return _buildSimpleRow(
      title: 'Review',
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          5,
          (index) => const Icon(Icons.star, size: 16, color: Colors.orange),
        ),
      ),
    );
  }

  // ▶️ generic tappable row used by Nutritions + Review
  Widget _buildSimpleRow({required String title, required Widget trailing}) {
    return InkWell(
      onTap: () {
        // TODO: navigate to the relevant detail screen
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                trailing,
                const SizedBox(width: 4),
                const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 🟢 Full-width "Add To Basket" button
  Widget _buildAddToBasketButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: () {
          // TODO: add {product, quantity} to the cart (via Provider/Bloc or API call)
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: const Text(
          'Add To Basket',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}