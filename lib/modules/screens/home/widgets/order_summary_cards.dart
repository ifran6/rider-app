import 'package:flutter/material.dart';

class OrderSummaryCards extends StatelessWidget {
  const OrderSummaryCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            _buildSummaryCard(
              title: 'Active Orders',
              value: '2',
              subtext: '+1 new',
              subtextColor: Colors.green[500]!,
            ),
            _buildSummaryCard(
              title: 'Completed Today',
              value: '7',
              subtext: 'orders',
              subtextColor: Colors.grey[500]!,
            ),
            _buildSummaryCard(
              title: 'Today\'s Earnings',
              value: '\$87.50',
            ),
            _buildSummaryCard(
              title: 'Rating',
              value: '4.8',
              showStar: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    String? subtext,
    Color? subtextColor,
    bool showStar = false,
  }) {
    return Container(
      width: 128,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (showStar) ...[
                const SizedBox(width: 4),
                Icon(
                  Icons.star,
                  size: 12,
                  color: Colors.amber[400],
                ),
              ],
              if (subtext != null) ...[
                const SizedBox(width: 8),
                Text(
                  subtext,
                  style: TextStyle(
                    fontSize: 12,
                    color: subtextColor,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}