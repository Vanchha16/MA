import 'package:flutter/material.dart';

import 'account_screen.dart';
import 'cart_screen.dart';
import 'explore_screen.dart';
import 'favorite_screen.dart';
import 'shop_screen.dart';

class NavItem {
  final String icon;
  final String label;

  const NavItem({
    required this.icon,
    required this.label,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;

  final List<NavItem> _navItems = const [
    NavItem(icon: 'assets/icon/Shop.png', label: 'Shop'),
    NavItem(icon: 'assets/icon/Search.png', label: 'Explore'),
    NavItem(icon: 'assets/icon/Cart.png', label: 'Cart'),
    NavItem(icon: 'assets/icon/Favorite.png', label: 'Favourite'),
    NavItem(icon: 'assets/icon/Account.png', label: 'Account'),
  ];

  final List<Widget> _screens = const [
    ShopScreen(),
    ExploreScreen(),
    CartScreen(),
    FavoriteScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedTab,
        children: _screens,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 15,
            spreadRadius: 0,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              for (int i = 0; i < _navItems.length; i++)
                _buildNavItem(i, _navItems[i].icon, _navItems[i].label),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String iconPath, String label) {
    final isSelected = _selectedTab == index;
    final color = isSelected
        ? const Color(0xFF53B175)
        : const Color(0xFF181725);

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedTab = index;
          });
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(iconPath, width: 24, height: 24, color: color),
              const SizedBox(height: 4),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
