import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EarningsScreen extends StatefulWidget {
  const EarningsScreen({super.key});

  @override
  State<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {
  String activeTimeFrame = 'week';
  bool showFilterOptions = false;
  String selectedDateRange = 'all';
  String selectedPaymentStatus = 'all';

  final List<Transaction> transactions = [
    Transaction(
      id: 'TRX-7842',
      date: 'April 30, 2025',
      time: '10:23 AM',
      amount: 24.50,
      customer: 'Emily Johnson',
      restaurant: 'Burger King',
      restaurantImage: 'assets/images/burger_king_logo.png', // Changed to local asset
      status: 'Completed',
      type: 'Delivery',
    ),
    Transaction(
      id: 'TRX-7843',
      date: 'April 30, 2025',
      time: '09:45 AM',
      amount: 42.75,
      customer: 'Michael Williams',
      restaurant: 'Grocery Express',
      restaurantImage: 'assets/images/grocery_express_logo.png', // Changed to local asset
      status: 'Completed',
      type: 'Delivery',
    ),
    Transaction(
      id: 'TRX-7844',
      date: 'April 30, 2025',
      time: '08:30 AM',
      amount: 33.46,
      customer: 'Sarah Thompson',
      restaurant: 'Pizza Palace',
      restaurantImage: 'assets/images/pizza_palace_logo.png', // Changed to local asset
      status: 'Completed',
      type: 'Pickup',
    ),
    Transaction(
      id: 'TRX-7839',
      date: 'April 29, 2025',
      time: '19:15 PM', // Fixed time format (should be just 7:15 PM)
      amount: 22.42,
      customer: 'David Chen',
      restaurant: 'Taco Bell',
      restaurantImage: 'assets/images/taco_bell_logo.png', // Changed to local asset
      status: 'Completed',
      type: 'Delivery',
    ),
    Transaction(
      id: 'TRX-7838',
      date: 'April 29, 2025',
      time: '16:45 PM', // Fixed time format (should be just 4:45 PM)
      amount: 16.60,
      customer: 'Jessica Martinez',
      restaurant: 'Starbucks',
      restaurantImage: 'assets/images/starbucks_logo.png', // Changed to local asset
      status: 'Completed',
      type: 'Pickup',
    ),
    Transaction(
      id: 'TRX-7837',
      date: 'April 29, 2025',
      time: '14:20 PM', // Fixed time format (should be just 2:20 PM)
      amount: 29.50,
      customer: 'Robert Wilson',
      restaurant: 'Chipotle',
      restaurantImage: 'assets/images/chipotle_logo.png', // Changed to local asset
      status: 'Completed',
      type: 'Delivery',
    ),
  ];

  final List<ChartData> chartData = [
    ChartData('Mon', 120),
    ChartData('Tue', 132),
    ChartData('Wed', 101),
    ChartData('Thu', 134),
    ChartData('Fri', 90),
    ChartData('Sat', 180),
    ChartData('Sun', 210),
  ];

  void handleTimeFrameChange(String timeFrame) {
    setState(() {
      activeTimeFrame = timeFrame;
    });
  }

  void handleDateRangeChange(String range) {
    setState(() {
      selectedDateRange = range;
      showFilterOptions = false;
    });
  }

  void handlePaymentStatusChange(String status) {
    setState(() {
      selectedPaymentStatus = status;
      showFilterOptions = false;
    });
  }

  String formatCurrency(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back, color: Color(0xFF4B5563)),
                            onPressed: () {
                              // Added empty bracket to fix syntax error
                            },
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Earnings',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.notifications_outlined, color: Color(0xFF4B5563)),
                        onPressed: () {
                          // Added empty bracket to fix syntax error
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Balance Summary Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Color(0xFF4F46E5), Color(0xFF6366F1)],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Available Balance',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  const Text(
                                    '\$1,247.85',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Row(
                                      children: [
                                        Icon(Icons.arrow_upward, size: 12, color: Colors.white),
                                        SizedBox(width: 2),
                                        Text(
                                          '12% this week',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  // Added empty bracket to fix syntax error
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: const Color(0xFF4F46E5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.account_balance_wallet, size: 16),
                                    SizedBox(width: 8),
                                    Text(
                                      'Withdraw Funds',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'This Week',
                                      style: TextStyle(
                                        color: Color(0xFF6B7280),
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      '\$358.75',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.arrow_upward, size: 12, color: Color(0xFF10B981)),
                                        const SizedBox(width: 4),
                                        const Text(
                                          '8% from last week',
                                          style: TextStyle(
                                            color: Color(0xFF10B981),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'This Month',
                                      style: TextStyle(
                                        color: Color(0xFF6B7280),
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      '\$1,842.30',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.arrow_upward, size: 12, color: Color(0xFF10B981)),
                                        const SizedBox(width: 4),
                                        const Text(
                                          '15% from last month',
                                          style: TextStyle(
                                            color: Color(0xFF10B981),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Earnings Chart
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Earnings Overview',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F4F6),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                _buildTimeFrameButton('day', 'Day'),
                                _buildTimeFrameButton('week', 'Week'),
                                _buildTimeFrameButton('month', 'Month'),
                                _buildTimeFrameButton('year', 'Year'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: SizedBox(
                          height: 220,
                          child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(
                              axisLine: const AxisLine(color: Color(0xFFDDDDDD)),
                              majorGridLines: const MajorGridLines(width: 0),
                              labelStyle: const TextStyle(color: Color(0xFF666666)),
                            ),
                            primaryYAxis: NumericAxis(
                              axisLine: const AxisLine(width: 0),
                              labelFormat: '\${value}',
                              labelStyle: const TextStyle(color: Color(0xFF666666)),
                              majorTickLines: const MajorTickLines(size: 0),
                              minorTickLines: const MinorTickLines(size: 0),
                              majorGridLines: const MajorGridLines(color: Color(0xFFF0F0F0)),
                            ),
                            tooltipBehavior: TooltipBehavior(
                              enable: true,
                              format: 'point.x: \${point.y}',
                              color: Colors.white,
                              textStyle: const TextStyle(color: Color(0xFF333333)),
                              borderColor: const Color(0xFFEEEEEE),
                              borderWidth: 1,
                            ),
                            series: <CartesianSeries<ChartData, String>>[
  AreaSeries<ChartData, String>(
    dataSource: chartData,
    xValueMapper: (ChartData data, _) => data.day,
    yValueMapper: (ChartData data, _) => data.amount,
                                    color: const Color(0xFF4F46E5),
                                borderColor: const Color(0xFF4F46E5),
                                borderWidth: 3,
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFF4F46E5).withOpacity(0.3),
                                    const Color(0xFF4F46E5).withOpacity(0.05),
                                  ],
                                  stops: const [0.0, 1.0],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
  ),
],

                            // series: <ChartSeries<ChartData, String>>[
                            //   AreaSeries<ChartData, String>(
                            //     dataSource: chartData,
                            //     xValueMapper: (ChartData data, _) => data.day,
                            //     yValueMapper: (ChartData data, _) => data.amount,
                            //     color: const Color(0xFF4F46E5),
                            //     borderColor: const Color(0xFF4F46E5),
                            //     borderWidth: 3,
                            //     gradient: LinearGradient(
                            //       colors: [
                            //         const Color(0xFF4F46E5).withOpacity(0.3),
                            //         const Color(0xFF4F46E5).withOpacity(0.05),
                            //       ],
                            //       stops: const [0.0, 1.0],
                            //       begin: Alignment.topCenter,
                            //       end: Alignment.bottomCenter,
                            //     ),
                            //   ),
                            // ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Transaction History
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Transaction History',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showFilterOptions = !showFilterOptions;
                              });
                            },
                            child: const Row(
                              children: [
                                Icon(Icons.filter_alt_outlined, size: 16, color: Color(0xFF4F46E5)),
                                SizedBox(width: 4),
                                Text(
                                  'Filter',
                                  style: TextStyle(
                                    color: Color(0xFF4F46E5),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (showFilterOptions) _buildFilterOptions(),
                      const SizedBox(height: 16),
                      ...transactions.map((transaction) => _buildTransactionCard(transaction)),
                    ],
                  ),
                ),
                const SizedBox(height: 80), // Space for bottom navigation
              ],
            ),
          ),

          // Bottom Navigation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 72,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Row(
                children: [
                  _buildNavItem(Icons.home_outlined, 'Home', false),
                  _buildNavItem(Icons.list_alt_outlined, 'Orders', false),
                  _buildNavItem(Icons.account_balance_wallet, 'Earnings', true),
                  _buildNavItem(Icons.show_chart_outlined, 'Stats', false),
                  _buildNavItem(Icons.person_outline, 'Profile', false),
                ],
              ),
            ),
          ),

          // Quick Action Button
          Positioned(
            right: 16,
            bottom: 88,
            child: FloatingActionButton(
              onPressed: () {
                // Added empty bracket to fix syntax error
              },
              backgroundColor: const Color(0xFF4F46E5),
              child: const Icon(Icons.download_outlined, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeFrameButton(String value, String label) {
    return GestureDetector(
      onTap: () => handleTimeFrameChange(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: activeTimeFrame == value ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          boxShadow: activeTimeFrame == value
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: activeTimeFrame == value ? const Color(0xFF4F46E5) : const Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterOptions() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'DATE RANGE',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                _buildFilterOption('all', 'All Time'),
                _buildFilterOption('today', 'Today'),
                _buildFilterOption('week', 'This Week'),
                _buildFilterOption('month', 'This Month'),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF3F4F6)),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'PAYMENT STATUS',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                _buildFilterOption('all', 'All Statuses'),
                _buildFilterOption('completed', 'Completed'),
                _buildFilterOption('pending', 'Pending'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOption(String value, String label) {
    bool isSelected = (value == selectedDateRange && (value == 'all' || value == 'today' || value == 'week' || value == 'month')) ||
        (value == selectedPaymentStatus && (value == 'all' || value == 'completed' || value == 'pending'));

    return GestureDetector(
      onTap: () {
        if (value == 'all' || value == 'today' || value == 'week' || value == 'month') {
          handleDateRangeChange(value);
        } else {
          handlePaymentStatusChange(value);
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEEF2FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? const Color(0xFF4F46E5) : const Color(0xFF111827),
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionCard(Transaction transaction) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset(
                        transaction.restaurantImage,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 40,
                          height: 40,
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.restaurant, color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transaction.restaurant,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${transaction.date} • ${transaction.time}',
                          style: const TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formatCurrency(transaction.amount),
                      style: const TextStyle(
                        color: Color(0xFF10B981),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      transaction.id,
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person_outline, size: 14, color: Color(0xFF6B7280)),
                    const SizedBox(width: 4),
                    Text(
                      transaction.customer,
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD1FAE5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    transaction.status,
                    style: const TextStyle(
                      color: Color(0xFF10B981),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? const Color(0xFF4F46E5) : const Color(0xFF6B7280),
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? const Color(0xFF4F46E5) : const Color(0xFF6B7280),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class Transaction {
  final String id;
  final String date;
  final String time;
  final double amount;
  final String customer;
  final String restaurant;
  final String restaurantImage;
  final String status;
  final String type;

  Transaction({
    required this.id,
    required this.date,
    required this.time,
    required this.amount,
    required this.customer,
    required this.restaurant,
    required this.restaurantImage,
    required this.status,
    required this.type,
  });
}

class ChartData {
  final String day;
  final double amount;

  ChartData(this.day, this.amount);
}