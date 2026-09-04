import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryItem {
  final int id;
  final String name;
  final String? image;
  final IconData? icon;
  final Color color;

  const CategoryItem({
    required this.id,
    required this.name,
    this.image,
    this.icon,
    required this.color,
  });
}

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<CategoryItem> _categories = const [
    CategoryItem(
      id: 1,
      name: 'Fresh Fruits\n& Vegetable',
      image: 'assets/items/item4.png',
      color: Color(0xFF53B175),
    ),
    CategoryItem(
      id: 2,
      name: 'Cooking Oil\n& Ghee',
      icon: Icons.water_drop_outlined,
      color: Color(0xFFF8A44C),
    ),
    CategoryItem(
      id: 3,
      name: 'Meat & Fish',
      icon: Icons.set_meal_outlined,
      color: Color(0xFFF7A593),
    ),
    CategoryItem(
      id: 4,
      name: 'Bakery & Snacks',
      icon: Icons.bakery_dining_outlined,
      color: Color(0xFFD3B0E0),
    ),
    CategoryItem(
      id: 5,
      name: 'Dairy & Eggs',
      icon: Icons.egg_outlined,
      color: Color(0xFFFDE598),
    ),
    CategoryItem(
      id: 6,
      name: 'Beverages',
      icon: Icons.local_cafe_outlined,
      color: Color(0xFFB7DFF5),
    ),
    CategoryItem(
      id: 7,
      name: 'Fresh Apples\n& Fruits',
      image: 'assets/items/item1.png',
      color: Color(0xFF836AF6),
    ),
    CategoryItem(
      id: 8,
      name: 'Tomatoes &\nProduce',
      image: 'assets/items/item2.png',
      color: Color(0xFFF8A44C),
    ),
    CategoryItem(
      id: 9,
      name: 'Bell Peppers &\nGreens',
      image: 'assets/items/item3.png',
      color: Color(0xFF53B175),
    ),
    CategoryItem(
      id: 10,
      name: 'Fast Food &\nSnacks',
      icon: Icons.fastfood_outlined,
      color: Color(0xFFD3B0E0),
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<CategoryItem> get _filteredCategories {
    if (_searchQuery.isEmpty) return _categories;
    return _categories
        .where((item) =>
            item.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredCategories;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            const Center(
              child: Text(
                'Find Products',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF181725),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CupertinoSearchTextField(
                controller: _searchController,
                placeholder: 'Search Store',
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
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.trim();
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: filtered.isEmpty
                  ? _buildEmptyState()
                  : GridView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.88,
                      ),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        return _buildCategoryCard(filtered[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(CategoryItem category) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Selected: ${category.name.replaceAll('\n', ' ')}',
              style: const TextStyle(fontFamily: 'Poppins'),
            ),
            duration: const Duration(milliseconds: 900),
            backgroundColor: const Color(0xFF53B175),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: category.color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: category.color.withValues(alpha: 0.65),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: category.image != null
                    ? Image.asset(
                        category.image!,
                        height: 75,
                        fit: BoxFit.contain,
                      )
                    : Container(
                        width: 68,
                        height: 68,
                        decoration: BoxDecoration(
                          color: category.color.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          category.icon,
                          size: 36,
                          color: category.color,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              category.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF181725),
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFF2F3F2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.search_off_rounded,
                size: 40,
                color: Color(0xFF7C7C7C),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'No Categories Found',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF181725),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Try searching for fruits, vegetables, oil, bakery, or beverages.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Color(0xFF7C7C7C),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _searchController.clear();
                setState(() {
                  _searchQuery = '';
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF53B175),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                elevation: 0,
              ),
              child: const Text(
                'Clear Search',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}