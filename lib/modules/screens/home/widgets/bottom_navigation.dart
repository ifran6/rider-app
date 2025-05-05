import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigation extends StatelessWidget {
  final String activeTab;
  final Function(String) onTabChanged;

  const BottomNavigation({
    super.key,
    required this.activeTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey[200]!),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        height: 64,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              icon: FontAwesomeIcons.home,
              label: 'Home',
              isActive: activeTab == 'home',
              onTap: () => onTabChanged('home'),
            ),
            _buildNavItem(
              icon: FontAwesomeIcons.listAlt,
              label: 'Orders',
              isActive: activeTab == 'orders',
              onTap: () => onTabChanged('orders'),
            ),
            _buildNavItem(
              icon: FontAwesomeIcons.wallet,
              label: 'Earnings',
              isActive: activeTab == 'earnings',
              onTap: () => onTabChanged('earnings'),
            ),
            _buildNavItem(
              icon: FontAwesomeIcons.chartLine,
              label: 'Stats',
              isActive: activeTab == 'stats',
              onTap: () => onTabChanged('stats'),
            ),
            _buildNavItem(
              icon: FontAwesomeIcons.user,
              label: 'Profile',
              isActive: activeTab == 'profile',
              onTap: () => onTabChanged('profile'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 64,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isActive ? Colors.indigo[600] : Colors.grey[500],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isActive ? Colors.indigo[600] : Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}