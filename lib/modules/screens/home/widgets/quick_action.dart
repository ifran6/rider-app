import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16,
      bottom: 80,
      child: Column(
        children: [
          _buildActionButton(
            color: Colors.red,
            icon: FontAwesomeIcons.headset,
            onTap: () {},
          ),
          const SizedBox(height: 12),
          _buildActionButton(
            color: Colors.green,
            icon: FontAwesomeIcons.solidCommentAlt,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}