import 'package:flutter/material.dart';

class CategoryItem {
  final int id;
  final String name;
  final String image;
  final Color backgroundColor;
  final Color borderColor;

  const CategoryItem({
    required this.id,
    required this.name,
    required this.image,
    required this.backgroundColor,
    required this.borderColor,
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

  final List<CategoryItem> _categories = [
    CategoryItem(
      id: 1,
      name: 'Fresh Produce &\nVegetables',
      image: 'assets/explore/pngfuel 6.png',
      backgroundColor: const Color(0xFF53B175).withValues(alpha: 0.10),
      borderColor: const Color(0xFF53B175).withValues(alpha: 0.65),
    ),
    CategoryItem(
      id: 2,
      name: 'Oils, Condiments\n& Cooking\nEssentials',
      image: 'assets/explore/Cooking Oil.png',
      backgroundColor: const Color(0xFFF8A44C).withValues(alpha: 0.10),
      borderColor: const Color(0xFFF8A44C).withValues(alpha: 0.65),
    ),
    CategoryItem(
      id: 3,
      name: 'Fresh Meat,\nSeafood &\nPoultry',
      image: 'assets/explore/Meat & Fish.png',
      backgroundColor: const Color(0xFFF7A593).withValues(alpha: 0.15),
      borderColor: const Color(0xFFF7A593).withValues(alpha: 0.65),
    ),
    CategoryItem(
      id: 4,
      name: 'Bakery, Breads &\nGrains',
      image: 'assets/explore/Bakery.png',
      backgroundColor: const Color(0xFFD3B0E0).withValues(alpha: 0.20),
      borderColor: const Color(0xFFD3B0E0).withValues(alpha: 0.75),
    ),
    CategoryItem(
      id: 5,
      name: 'Dairy & Eggs',
      image: 'assets/explore/Dairy & Eggs.png',
      backgroundColor: const Color(0xFFFDE598).withValues(alpha: 0.22),
      borderColor: const Color(0xFFFDE598).withValues(alpha: 0.90),
    ),
    CategoryItem(
      id: 6,
      name: 'Beverages &\nDrinks',
      image: 'assets/explore/Beverages.png',
      backgroundColor: const Color(0xFFB7DFF5).withValues(alpha: 0.22),
      borderColor: const Color(0xFFB7DFF5).withValues(alpha: 0.85),
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
                  letterSpacing: 0.2,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F3F2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    Image.asset(
                      'assets/icon/mingcute_search-line.png',
                      width: 18,
                      height: 18,
                      color: const Color(0xFF181725),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value.trim();
                          });
                        },
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF181725),
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Search Store',
                          hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF7C7C7C),
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                    if (_searchQuery.isNotEmpty)
                      IconButton(
                        icon: const Icon(
                          Icons.clear_rounded,
                          size: 18,
                          color: Color(0xFF7C7C7C),
                        ),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    else
                      const SizedBox(width: 12),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
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
                        childAspectRatio: 0.84,
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
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
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
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        decoration: BoxDecoration(
          color: category.backgroundColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: category.borderColor,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  category.image,
                  height: 76,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              category.name,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF181725),
                height: 1.22,
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
              width: 76,
              height: 76,
              decoration: const BoxDecoration(
                color: Color(0xFFF2F3F2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.search_off_rounded,
                size: 38,
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
              'Try searching for vegetables, cooking oil, meat, bakery, dairy, or beverages.',
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