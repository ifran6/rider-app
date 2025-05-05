import 'package:flutter/material.dart';
import 'package:rider_app/modules/views/earning_screen.dart';
import 'package:rider_app/modules/views/order_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class DeliveryApp extends StatefulWidget {
  const DeliveryApp({super.key});

  @override
  State<DeliveryApp> createState() => DeliveryAppState();
}

class DeliveryAppState extends State<DeliveryApp> with TickerProviderStateMixin {
  bool _isOnline = true;
  String _activeTab = 'home';
  bool _showNotifications = false;
  late TabController _tabController;

  // Screens mapping with animation support
  final Map<String, Widget> _screens = {
    'home': const DashboardContent(),
    'orders': OrderScreen(),
    'earnings': const EarningsScreen(),
    // 'stats': const StatsScreen(),
    // 'profile': const ProfileScreen(),
  };

  // For tab persistence
  final List<String> _tabOrder = ['home', 'orders', 'earnings', 'stats', 'profile'];
  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: _tabOrder.indexOf(_activeTab),
      length: _tabOrder.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  final List<Map<String, dynamic>> _notifications = [
    {
      'id': 1,
      'type': 'order',
      'message': 'New order request from Burger King',
      'time': '2 mins ago',
      'icon': Icons.shopping_bag,
      'color': Colors.blue,
    },
    {
      'id': 2,
      'type': 'system',
      'message': 'System maintenance scheduled for tonight',
      'time': '15 mins ago',
      'icon': Icons.settings,
      'color': Colors.orange,
    },
    {
      'id': 3,
      'type': 'incentive',
      'message': 'Complete 5 more deliveries to earn \$15 bonus!',
      'time': '1 hour ago',
      'icon': Icons.card_giftcard,
      'color': Colors.green,
    }
  ];
  
  final List<Map<String, dynamic>> _activeOrders = [
    {
      'id': 'ORD-7842',
      'restaurant': 'Burger King',
      'location': '123 Main St',
      'customer': 'Emily Johnson',
      'address': '456 Oak Avenue, Apt 7B',
      'items': '2x Whopper, 1x Large Fries, 1x Coke',
      'estimatedTime': '25 mins',
      'distance': '2.3 miles',
      'payment': '\$24.50 (Paid)',
      'status': 'Pickup',
      'statusColor': Colors.blue,
      'icon': Icons.restaurant,
    },
    {
      'id': 'ORD-7843',
      'restaurant': 'Grocery Express',
      'location': '789 Market St',
      'customer': 'Michael Williams',
      'address': '321 Pine Road',
      'items': 'Groceries (8 items)',
      'estimatedTime': '35 mins',
      'distance': '3.1 miles',
      'payment': '\$42.75 (Paid)',
      'status': 'En Route',
      'statusColor': Colors.orange,
      'icon': Icons.shopping_basket,
    }
  ];

  void _toggleOnlineStatus() {
    setState(() {
      _isOnline = !_isOnline;
    });
  }

  void _toggleNotifications() {
    setState(() {
      _showNotifications = !_showNotifications;
    });
  }

  void _changeTab(String tab) {
    setState(() {
      _activeTab = tab;
      _tabController.animateTo(_tabOrder.indexOf(tab));
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Stack(
  //       children: [
  //         // Main content
  //         Column(
  //           children: [
  //             // Status bar (fixed at top)
  //             Container(
  //               height: 90,
  //               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 boxShadow: [
  //                   BoxShadow(
  //                     color: Colors.black.withOpacity(0.05),
  //                     blurRadius: 4,
  //                     offset: const Offset(0, 2),
  //                   ),
  //                 ],
  //               ),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Row(
  //                     children: [
  //                       Row(
  //                         children: [
  //                           Container(
  //                             width: 12,
  //                             height: 12,
  //                             margin: const EdgeInsets.only(right: 8),
  //                             decoration: BoxDecoration(
  //                               color: _isOnline ? Colors.green : Colors.grey,
  //                               shape: BoxShape.circle,
  //                             ),
  //                           ),
  //                           Text(
  //                             _isOnline ? 'Online' : 'Offline',
  //                             style: TextStyle(
  //                               fontWeight: FontWeight.w500,
  //                               color: _isOnline ? Colors.green : Colors.grey,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       const SizedBox(width: 16),
  //                       GestureDetector(
  //                         onTap: _toggleOnlineStatus,
  //                         child: Container(
  //                           width: 48,
  //                           height: 24,
  //                           padding: const EdgeInsets.all(2),
  //                           decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(12),
  //                             color: _isOnline ? Colors.indigo : Colors.grey[300],
  //                           ),
  //                           child: AnimatedAlign(
  //                             duration: const Duration(milliseconds: 200),
  //                             alignment: _isOnline ? Alignment.centerRight : Alignment.centerLeft,
  //                             child: Container(
  //                               width: 20,
  //                               height: 20,
  //                               decoration: const BoxDecoration(
  //                                 color: Colors.white,
  //                                 shape: BoxShape.circle,
  //                                 boxShadow: [
  //                                   BoxShadow(
  //                                     color: Colors.black12,
  //                                     blurRadius: 2,
  //                                     offset: Offset(0, 1),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   Row(
  //                     children: [
  //                       // Notification button with badge
  //                       Stack(
  //                         children: [
  //                           IconButton(
  //                             onPressed: _toggleNotifications,
  //                             icon: const Icon(Icons.notifications_none, size: 24),
  //                             color: Colors.grey[700],
  //                           ),
  //                           Positioned(
  //                             right: 8,
  //                             top: 8,
  //                             child: Container(
  //                               width: 16,
  //                               height: 16,
  //                               decoration: const BoxDecoration(
  //                                 color: Colors.red,
  //                                 shape: BoxShape.circle,
  //                               ),
  //                               child: const Center(
  //                                 child: Text(
  //                                   '3',
  //                                   style: TextStyle(
  //                                     color: Colors.white,
  //                                     fontSize: 10,
  //                                     fontWeight: FontWeight.bold,
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       // Profile
  //                       Row(
  //                         children: [
  //                           Container(
  //                             width: 32,
  //                             height: 32,
  //                             margin: const EdgeInsets.only(right: 8),
  //                             decoration: BoxDecoration(
  //                               shape: BoxShape.circle,
  //                               image: const DecorationImage(
  //                                 image: NetworkImage(
  //                                   'https://readdy.ai/api/search-image?query=professional%20headshot%20portrait%20of%20a%20young%20male%20delivery%20driver%20with%20short%20dark%20hair%20wearing%20a%20blue%20uniform%20cap%2C%20friendly%20smile%2C%20high%20quality%20photorealistic%2C%20isolated%20on%20white%20background%2C%20centered%20composition&width=100&height=100&seq=1&orientation=squarish',
  //                                 ),
  //                                 fit: BoxFit.cover,
  //                               ),
  //                             ),
  //                           ),
  //                           const Text(
  //                             'James Wilson',
  //                             style: TextStyle(
  //                               fontWeight: FontWeight.w500,
  //                               fontSize: 14,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
              
  //             // Main scrollable content
  //             Expanded(
  //               child: SingleChildScrollView(
  //                 padding: const EdgeInsets.only(bottom: 72),
  //                 child: Column(
  //                   children: [
  //                     // Order summary cards
  //                     Container(
  //                       padding: const EdgeInsets.all(16),
  //                       child: SingleChildScrollView(
  //                         scrollDirection: Axis.horizontal,
  //                         child: Row(
  //                           children: [
  //                             _buildSummaryCard(
  //                               title: 'Active Orders',
  //                               value: '2',
  //                               trend: '+1 new',
  //                               trendColor: Colors.green,
  //                             ),
  //                             const SizedBox(width: 16),
  //                             _buildSummaryCard(
  //                               title: 'Completed Today',
  //                               value: '7',
  //                               trend: 'orders',
  //                               trendColor: Colors.grey,
  //                             ),
  //                             const SizedBox(width: 16),
  //                             _buildSummaryCard(
  //                               title: "Today's Earnings",
  //                               value: '\$87.50',
  //                               trend: '',
  //                               trendColor: Colors.grey,
  //                             ),
  //                             const SizedBox(width: 16),
  //                             _buildSummaryCard(
  //                               title: 'Rating',
  //                               value: '4.8',
  //                               trend: '',
  //                               trendColor: Colors.grey,
  //                               icon: Icons.star,
  //                               iconColor: Colors.amber,
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
                      
  //                     // Map integration
  //                     Container(
  //                       margin: const EdgeInsets.symmetric(horizontal: 16),
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius: BorderRadius.circular(8),
  //                         boxShadow: [
  //                           BoxShadow(
  //                             color: Colors.black.withOpacity(0.05),
  //                             blurRadius: 4,
  //                             offset: const Offset(0, 2),
  //                           ),
  //                         ],
  //                       ),
  //                       child: Column(
  //                         children: [
  //                           // Map image
  //                           Container(
  //                             height: 200,
  //                             decoration: const BoxDecoration(
  //                               image: DecorationImage(
  //                                 image: NetworkImage(
  //                                   'https://readdy.ai/api/search-image?query=city%20map%20view%20with%20GPS%20navigation%20route%20highlighted%20in%20blue%2C%20showing%20streets%2C%20buildings%2C%20and%20points%20of%20interest%2C%20with%20a%20current%20location%20marker%20and%20destination%20pin%2C%20clean%20modern%20design%2C%20digital%20interface%2C%20high%20detail%20quality&width=375&height=250&seq=2&orientation=landscape',
  //                                 ),
  //                                 fit: BoxFit.cover,
  //                               ),
  //                             ),
  //                             child: Stack(
  //                               children: [
  //                                 Positioned(
  //                                   top: 8,
  //                                   right: 8,
  //                                   child: Container(
  //                                     decoration: BoxDecoration(
  //                                       color: Colors.white,
  //                                       borderRadius: BorderRadius.circular(8),
  //                                       boxShadow: [
  //                                         BoxShadow(
  //                                           color: Colors.black.withOpacity(0.1),
  //                                           blurRadius: 4,
  //                                           offset: const Offset(0, 2),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                     child: Row(
  //                                       mainAxisSize: MainAxisSize.min,
  //                                       children: [
  //                                         IconButton(
  //                                           onPressed: () {},
  //                                           icon: const Icon(Icons.my_location, size: 20, color: Colors.indigo),
  //                                         ),
  //                                         IconButton(
  //                                           onPressed: () {},
  //                                           icon: const Icon(Icons.layers, size: 20, color: Colors.grey),
  //                                         ),
  //                                         IconButton(
  //                                           onPressed: () {},
  //                                           icon: const Icon(Icons.local_fire_department, size: 20, color: Colors.grey),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 Positioned(
  //                                   bottom: 8,
  //                                   right: 8,
  //                                   child: Container(
  //                                     width: 40,
  //                                     height: 40,
  //                                     decoration: BoxDecoration(
  //                                       color: Colors.indigo,
  //                                       shape: BoxShape.circle,
  //                                       boxShadow: [
  //                                         BoxShadow(
  //                                           color: Colors.black.withOpacity(0.2),
  //                                           blurRadius: 4,
  //                                           offset: const Offset(0, 2),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                     child: const Icon(Icons.directions, color: Colors.white),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                           // Map footer
  //                           Padding(
  //                             padding: const EdgeInsets.all(16),
  //                             child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 Column(
  //                                   crossAxisAlignment: CrossAxisAlignment.start,
  //                                   children: [
  //                                     const Text(
  //                                       'Current Area',
  //                                       style: TextStyle(
  //                                         fontWeight: FontWeight.w500,
  //                                         fontSize: 14,
  //                                       ),
  //                                     ),
  //                                     const SizedBox(height: 4),
  //                                     Text(
  //                                       'Downtown Financial District',
  //                                       style: TextStyle(
  //                                         fontSize: 12,
  //                                         color: Colors.grey[600],
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                                 Container(
  //                                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //                                   decoration: BoxDecoration(
  //                                     color: Colors.green[50],
  //                                     borderRadius: BorderRadius.circular(12),
  //                                   ),
  //                                   child: Text(
  //                                     'High Demand',
  //                                     style: TextStyle(
  //                                       fontSize: 12,
  //                                       color: Colors.green[600],
  //                                       fontWeight: FontWeight.w500,
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
                      
  //                     const SizedBox(height: 16),
                      
  //                     // Active orders
  //                     Container(
  //                       margin: const EdgeInsets.symmetric(horizontal: 16),
  //                       child: Column(
  //                         children: [
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               const Text(
  //                                 'Active Orders',
  //                                 style: TextStyle(
  //                                   fontWeight: FontWeight.w600,
  //                                   fontSize: 18,
  //                                 ),
  //                               ),
  //                               GestureDetector(
  //                                 onTap: () {},
  //                                 child: Text(
  //                                   'View All',
  //                                   style: TextStyle(
  //                                     fontSize: 12,
  //                                     color: Colors.indigo[600],
  //                                     fontWeight: FontWeight.w500,
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                           const SizedBox(height: 12),
  //                           Column(
  //                             children: _activeOrders.map((order) => _buildOrderCard(order)).toList(),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
                      
  //                     const SizedBox(height: 16),
                      
  //                     // Performance metrics
  //                     Container(
  //                       margin: const EdgeInsets.symmetric(horizontal: 16),
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius: BorderRadius.circular(8),
  //                         boxShadow: [
  //                           BoxShadow(
  //                             color: Colors.black.withOpacity(0.05),
  //                             blurRadius: 4,
  //                             offset: const Offset(0, 2),
  //                           ),
  //                         ],
  //                       ),
  //                       child: Column(
  //                         children: [
  //                           // Header
  //                           Padding(
  //                             padding: const EdgeInsets.all(16),
  //                             child: Text(
  //                               'Weekly Performance',
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.w600,
  //                                 fontSize: 16,
  //                                 color: Colors.grey[800],
  //                               ),
  //                             ),
  //                           ),
  //                           // Chart
  //                           SizedBox(
  //                             height: 180,
  //                             child: SfCartesianChart(
  //                               margin: const EdgeInsets.all(0),
  //                               primaryXAxis: CategoryAxis(
  //                                 axisLine: const AxisLine(width: 0),
  //                                 majorGridLines: const MajorGridLines(width: 0),
  //                                 labelStyle: TextStyle(
  //                                   fontSize: 10,
  //                                   color: Colors.grey[600],
  //                                 ),
  //                               ),
  //                               primaryYAxis: NumericAxis(
  //                                 axisLine: const AxisLine(width: 0),
  //                                 majorTickLines: const MajorTickLines(size: 0),
  //                                 majorGridLines: MajorGridLines(
  //                                   width: 1,
  //                                   color: Colors.grey[100]!,
  //                                 ),
  //                                 labelStyle: TextStyle(
  //                                   fontSize: 10,
  //                                   color: Colors.grey[600],
  //                                 ),
  //                               ),
  //                               series: <ColumnSeries<Map<String, dynamic>, String>>[
  //                                 ColumnSeries<Map<String, dynamic>, String>(
  //                                   dataSource: [
  //                                     {'day': 'Mon', 'earnings': 78},
  //                                     {'day': 'Tue', 'earnings': 92},
  //                                     {'day': 'Wed', 'earnings': 85},
  //                                     {'day': 'Thu', 'earnings': 130},
  //                                     {'day': 'Fri', 'earnings': 110},
  //                                     {'day': 'Sat', 'earnings': 142},
  //                                     {'day': 'Sun', 'earnings': 96},
  //                                   ],
  //                                   xValueMapper: (data, _) => data['day'],
  //                                   yValueMapper: (data, _) => data['earnings'],
  //                                   width: 0.6,
  //                                   color: Colors.indigo,
  //                                 ),
  //                               ],
  //                               tooltipBehavior: TooltipBehavior(
  //                                 enable: true,
  //                                 format: '\$point.y',
  //                               ),
  //                             ),
  //                           ),
  //                           // Metrics
  //                           Container(
  //                             decoration: BoxDecoration(
  //                               border: Border(
  //                                 top: BorderSide(
  //                                   color: Colors.grey[200]!,
  //                                   width: 1,
  //                                 ),
  //                               ),
  //                             ),
  //                             child: Row(
  //                               children: [
  //                                 Expanded(
  //                                   child: Container(
  //                                     padding: const EdgeInsets.all(12),
  //                                     decoration: BoxDecoration(
  //                                       border: Border(
  //                                         right: BorderSide(
  //                                           color: Colors.grey[200]!,
  //                                           width: 1,
  //                                         ),
  //                                       ),
  //                                     ),
  //                                     child: Column(
  //                                       children: [
  //                                         Text(
  //                                           'Acceptance Rate',
  //                                           style: TextStyle(
  //                                             fontSize: 12,
  //                                             color: Colors.grey[600],
  //                                           ),
  //                                         ),
  //                                         const SizedBox(height: 4),
  //                                         const Text(
  //                                           '92%',
  //                                           style: TextStyle(
  //                                             fontWeight: FontWeight.w500,
  //                                             fontSize: 16,
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 Expanded(
  //                                   child: Container(
  //                                     padding: const EdgeInsets.all(12),
  //                                     decoration: BoxDecoration(
  //                                       border: Border(
  //                                         right: BorderSide(
  //                                           color: Colors.grey[200]!,
  //                                           width: 1,
  //                                         ),
  //                                       ),
  //                                     ),
  //                                     child: Column(
  //                                       children: [
  //                                         Text(
  //                                           'On-time Delivery',
  //                                           style: TextStyle(
  //                                             fontSize: 12,
  //                                             color: Colors.grey[600],
  //                                           ),
  //                                         ),
  //                                         const SizedBox(height: 4),
  //                                         const Text(
  //                                           '95%',
  //                                           style: TextStyle(
  //                                             fontWeight: FontWeight.w500,
  //                                             fontSize: 16,
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 Expanded(
  //                                   child: Container(
  //                                     padding: const EdgeInsets.all(12),
  //                                     child: Column(
  //                                       children: [
  //                                         Text(
  //                                           'Customer Rating',
  //                                           style: TextStyle(
  //                                             fontSize: 12,
  //                                             color: Colors.grey[600],
  //                                           ),
  //                                         ),
  //                                         const SizedBox(height: 4),
  //                                         Row(
  //                                           mainAxisAlignment: MainAxisAlignment.center,
  //                                           children: const [
  //                                             Text(
  //                                               '4.8',
  //                                               style: TextStyle(
  //                                                 fontWeight: FontWeight.w500,
  //                                                 fontSize: 16,
  //                                               ),
  //                                             ),
  //                                             SizedBox(width: 2),
  //                                             Icon(
  //                                               Icons.star,
  //                                               size: 16,
  //                                               color: Colors.amber,
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     const SizedBox(height: 16),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
          
  //         // Quick actions (floating buttons)
  //         Positioned(
  //           right: 16,
  //           bottom: 80,
  //           child: Column(
  //             children: [
  //               FloatingActionButton(
  //                 onPressed: () {},
  //                 backgroundColor: Colors.red,
  //                 mini: true,
  //                 child: const Icon(Icons.headset, size: 20),
  //               ),
  //               const SizedBox(height: 12),
  //               FloatingActionButton(
  //                 onPressed: () {},
  //                 backgroundColor: Colors.green,
  //                 mini: true,
  //                 child: const Icon(Icons.message, size: 20),
  //               ),
  //             ],
  //           ),
  //         ),
          
  //         // Notifications panel
  //         if (_showNotifications) ...[
  //           Positioned(
  //             top: 56,
  //             right: 16,
  //             width: 320,
  //             child: Material(
  //               elevation: 4,
  //               borderRadius: BorderRadius.circular(8),
  //               child: Column(
  //                 children: [
  //                   // Header
  //                   Container(
  //                     padding: const EdgeInsets.all(16),
  //                     decoration: BoxDecoration(
  //                       color: Colors.indigo,
  //                       borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
  //                     ),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         const Text(
  //                           'Notifications',
  //                           style: TextStyle(
  //                             color: Colors.white,
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                         Container(
  //                           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
  //                           decoration: BoxDecoration(
  //                             color: Colors.white,
  //                             borderRadius: BorderRadius.circular(12),
  //                           ),
  //                           child: Text(
  //                             '3 new',
  //                             style: TextStyle(
  //                               color: Colors.indigo[600],
  //                               fontSize: 12,
  //                               fontWeight: FontWeight.w500,
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   // Notifications list
  //                   Container(
  //                     constraints: const BoxConstraints(maxHeight: 384),
  //                     child: ListView.builder(
  //                       shrinkWrap: true,
  //                       itemCount: _notifications.length,
  //                       itemBuilder: (context, index) {
  //                         final notification = _notifications[index];
  //                         return ListTile(
  //                           contentPadding: const EdgeInsets.all(12),
  //                           leading: Container(
  //                             width: 36,
  //                             height: 36,
  //                             decoration: BoxDecoration(
  //                               color: notification['color'].withOpacity(0.1),
  //                               shape: BoxShape.circle,
  //                             ),
  //                             child: Icon(
  //                               notification['icon'],
  //                               color: notification['color'],
  //                               size: 18,
  //                             ),
  //                           ),
  //                           title: Text(
  //                             notification['message'],
  //                             style: const TextStyle(
  //                               fontSize: 14,
  //                               fontWeight: FontWeight.w500,
  //                             ),
  //                           ),
  //                           subtitle: Padding(
  //                             padding: const EdgeInsets.only(top: 4),
  //                             child: Text(
  //                               notification['time'],
  //                               style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: Colors.grey[600],
  //                               ),
  //                             ),
  //                           ),
  //                           onTap: () {},
  //                         );
  //                       },
  //                     ),
  //                   ),
  //                   // Footer
  //                   Container(
  //                     padding: const EdgeInsets.all(12),
  //                     decoration: BoxDecoration(
  //                       color: Colors.grey[50],
  //                       borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
  //                       border: Border(
  //                         top: BorderSide(
  //                           color: Colors.grey[200]!,
  //                           width: 1,
  //                         ),
  //                       ),
  //                     ),
  //                     child: Center(
  //                       child: Text(
  //                         'View all notifications',
  //                         style: TextStyle(
  //                           color: Colors.indigo[600],
  //                           fontWeight: FontWeight.w500,
  //                           fontSize: 14,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ],
  //     ),
      
  //     // Bottom navigation bar
  //     bottomNavigationBar: Container(
  //       height: 72,
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         border: Border(
  //           top: BorderSide(
  //             color: Colors.grey[200]!,
  //             width: 1,
  //           ),
  //         ),
  //       ),
  //       child: Row(
  //         children: [
  //           _buildBottomNavItem(Icons.home, 'Home', 'home'),
  //           _buildBottomNavItem(Icons.list_alt, 'Orders', 'order'),
  //           _buildBottomNavItem(Icons.wallet, 'Earnings', 'earnings'),
  //           _buildBottomNavItem(Icons.bar_chart, 'Stats', 'stats'),
  //           _buildBottomNavItem(Icons.person, 'Profile', 'profile'),
  //         ],
  //       ),
  //     ),
  //   );
  // }


    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: _bucket,
        child: Stack(
          children: [
            // Main content with tab switching
            _buildActiveScreen(),
            
            // Status bar (fixed at top)
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: StatusBar(), // Extracted to separate widget
            ),
            
            // Quick actions (floating buttons)
            Positioned(
              right: 16,
              bottom: 80,
              child: Column(
                children: [
                  FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Colors.red,
                    mini: true,
                    child: const Icon(Icons.headset, size: 20),
                  ),
                  const SizedBox(height: 12),
                  FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Colors.green,
                    mini: true,
                    child: const Icon(Icons.message, size: 20),
                  ),
                ],
              ),
            ),
            
            // Notifications panel
            if (_showNotifications) _buildNotificationsPanel(),
          ],
        ),
      ),
      
      bottomNavigationBar: Container(
        height: 72,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey[200]!,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            _buildBottomNavItem(Icons.home, 'Home', 'home'),
            _buildBottomNavItem(Icons.list_alt, 'Orders', 'orders'),
            _buildBottomNavItem(Icons.wallet, 'Earnings', 'earnings'),
            _buildBottomNavItem(Icons.bar_chart, 'Stats', 'stats'),
            _buildBottomNavItem(Icons.person, 'Profile', 'profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveScreen() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      child: Container(
        key: ValueKey<String>(_activeTab),
        child: _screens[_activeTab] ?? _screens['home']!,
      ),
    );
  }

  Widget _buildNotificationsPanel() {
    return Positioned(
      top: 56,
      right: 16,
      width: 320,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Notifications',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '3 new',
                      style: TextStyle(
                        color: Colors.indigo[600],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Notifications list
            Container(
              constraints: const BoxConstraints(maxHeight: 384),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _notifications.length,
                itemBuilder: (context, index) {
                  final notification = _notifications[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: notification['color'].withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        notification['icon'],
                        color: notification['color'],
                        size: 18,
                      ),
                    ),
                    title: Text(
                      notification['message'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        notification['time'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    onTap: () {},
                  );
                },
              ),
            ),
            // Footer
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
                border: Border(
                  top: BorderSide(
                    color: Colors.grey[200]!,
                    width: 1,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  'View all notifications',
                  style: TextStyle(
                    color: Colors.indigo[600],
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildSummaryCard({
    required String title,
    required String value,
    required String trend,
    required Color trendColor,
    IconData? icon,
    Color? iconColor,
  }) {
    return Container(
      width: 128,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
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
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
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
            if (trend.isNotEmpty) ...[
              const SizedBox(width: 4),
              Text(
                trend,
                style: TextStyle(
                  fontSize: 12,
                  color: trendColor,
                ),
              ),
            ],
            if (icon != null) ...[
              const SizedBox(width: 4),
              Icon(
                icon,
                size: 16,
                color: iconColor,
              ),
            ],
          ],
        ),
      ],
    ),
  );
}

Widget _buildOrderCard(Map<String, dynamic> order) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        // Order header
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.indigo[50],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      order['icon'],
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order['restaurant'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        order['location'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
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
                    order['id'],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: order['statusColor'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      order['status'],
                      style: TextStyle(
                        fontSize: 12,
                        color: order['statusColor'],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // Order details
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              // Customer info
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.person,
                    size: 20,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order['customer'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          order['address'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Items
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.shopping_bag,
                    size: 20,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      order['items'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Order meta
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 3,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        order['estimatedTime'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.directions,
                        size: 16,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        order['distance'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.payment,
                        size: 16,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        order['payment'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // Order actions
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: BorderSide(color: Colors.grey[300]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.phone,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Contact',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check,
                        size: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        order['status'] == 'Pickup' ? 'Picked Up' : 'Delivered',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildBottomNavItem(IconData icon, String label, String tab) {
  return Expanded(
    child: InkWell(
      onTap: () => _changeTab(tab),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: _activeTab == tab ? Colors.indigo : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: _activeTab == tab ? Colors.indigo : Colors.grey,
            ),
          ),
        ],
      ),
    ),
  );
}}

// Extracted Status Bar Widget
class StatusBar extends StatelessWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<DeliveryAppState>();
    if (state == null) return const SizedBox.shrink();

    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: state._isOnline ? Colors.green : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(
                    state._isOnline ? 'Online' : 'Offline',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: state._isOnline ? Colors.green : Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: state._toggleOnlineStatus,
                child: Container(
                  width: 48,
                  height: 24,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: state._isOnline ? Colors.indigo : Colors.grey[300],
                  ),
                  child: AnimatedAlign(
                    duration: const Duration(milliseconds: 200),
                    alignment: state._isOnline ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              // Notification button with badge
              Stack(
                children: [
                  IconButton(
                    onPressed: state._toggleNotifications,
                    icon: const Icon(Icons.notifications_none, size: 24),
                    color: Colors.grey[700],
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          '3',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Profile
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://readdy.ai/api/search-image?query=professional%20headshot%20portrait%20of%20a%20young%20male%20delivery%20driver%20with%20short%20dark%20hair%20wearing%20a%20blue%20uniform%20cap%2C%20friendly%20smile%2C%20high%20quality%20photorealistic%2C%20isolated%20on%20white%20background%2C%20centered%20composition&width=100&height=100&seq=1&orientation=squarish',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Text(
                    'James Wilson',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data that was previously in the main state class
    final List<Map<String, dynamic>> activeOrders = [
      {
        'id': 'ORD-7842',
        'restaurant': 'Burger King',
        'location': '123 Main St',
        'customer': 'Emily Johnson',
        'address': '456 Oak Avenue, Apt 7B',
        'items': '2x Whopper, 1x Large Fries, 1x Coke',
        'estimatedTime': '25 mins',
        'distance': '2.3 miles',
        'payment': '\$24.50 (Paid)',
        'status': 'Pickup',
        'statusColor': Colors.blue,
        'icon': Icons.restaurant,
      },
      {
        'id': 'ORD-7843',
        'restaurant': 'Grocery Express',
        'location': '789 Market St',
        'customer': 'Michael Williams',
        'address': '321 Pine Road',
        'items': 'Groceries (8 items)',
        'estimatedTime': '35 mins',
        'distance': '3.1 miles',
        'payment': '\$42.75 (Paid)',
        'status': 'En Route',
        'statusColor': Colors.orange,
        'icon': Icons.shopping_basket,
      }
    ];

    return Column(
      children: [
        const SizedBox(height: 90), // Space for the status bar
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 72),
            child: Column(
              children: [
                // Order summary cards
                Container(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildSummaryCard(
                          title: 'Active Orders',
                          value: '2',
                          trend: '+1 new',
                          trendColor: Colors.green,
                        ),
                        const SizedBox(width: 16),
                        _buildSummaryCard(
                          title: 'Completed Today',
                          value: '7',
                          trend: 'orders',
                          trendColor: Colors.grey,
                        ),
                        const SizedBox(width: 16),
                        _buildSummaryCard(
                          title: "Today's Earnings",
                          value: '\$87.50',
                          trend: '',
                          trendColor: Colors.grey,
                        ),
                        const SizedBox(width: 16),
                        _buildSummaryCard(
                          title: 'Rating',
                          value: '4.8',
                          trend: '',
                          trendColor: Colors.grey,
                          icon: Icons.star,
                          iconColor: Colors.amber,
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Map integration
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Map image
                      Container(
                        height: 200,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://readdy.ai/api/search-image?query=city%20map%20view%20with%20GPS%20navigation%20route%20highlighted%20in%20blue%2C%20showing%20streets%2C%20buildings%2C%20and%20points%20of%20interest%2C%20with%20a%20current%20location%20marker%20and%20destination%20pin%2C%20clean%20modern%20design%2C%20digital%20interface%2C%20high%20detail%20quality&width=375&height=250&seq=2&orientation=landscape',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.my_location, size: 20, color: Colors.indigo),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.layers, size: 20, color: Colors.grey),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.local_fire_department, size: 20, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.indigo,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Icon(Icons.directions, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Map footer
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Current Area',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Downtown Financial District',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'High Demand',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.green[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Active orders
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Active Orders',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'View All',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.indigo[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Column(
                        children: activeOrders.map((order) => _buildOrderCard(order)).toList(),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Performance metrics
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Header
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Weekly Performance',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                      // Chart
                      SizedBox(
                        height: 180,
                        child: SfCartesianChart(
                          margin: const EdgeInsets.all(0),
                          primaryXAxis: CategoryAxis(
                            axisLine: const AxisLine(width: 0),
                            majorGridLines: const MajorGridLines(width: 0),
                            labelStyle: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[600],
                            ),
                          ),
                          primaryYAxis: NumericAxis(
                            axisLine: const AxisLine(width: 0),
                            majorTickLines: const MajorTickLines(size: 0),
                            majorGridLines: MajorGridLines(
                              width: 1,
                              color: Colors.grey[100]!,
                            ),
                            labelStyle: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[600],
                            ),
                          ),
                          series: <ColumnSeries<Map<String, dynamic>, String>>[
                            ColumnSeries<Map<String, dynamic>, String>(
                              dataSource: [
                                {'day': 'Mon', 'earnings': 78},
                                {'day': 'Tue', 'earnings': 92},
                                {'day': 'Wed', 'earnings': 85},
                                {'day': 'Thu', 'earnings': 130},
                                {'day': 'Fri', 'earnings': 110},
                                {'day': 'Sat', 'earnings': 142},
                                {'day': 'Sun', 'earnings': 96},
                              ],
                              xValueMapper: (data, _) => data['day'],
                              yValueMapper: (data, _) => data['earnings'],
                              width: 0.6,
                              color: Colors.indigo,
                            ),
                          ],
                          tooltipBehavior: TooltipBehavior(
                            enable: true,
                            format: '\$point.y',
                          ),
                        ),
                      ),
                      // Metrics
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Colors.grey[200]!,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: Colors.grey[200]!,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Acceptance Rate',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      '92%',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: Colors.grey[200]!,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'On-time Delivery',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      '95%',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  children: [
                                    Text(
                                      'Customer Rating',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          '4.8',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                        Icon(
                                          Icons.star,
                                          size: 16,
                                          color: Colors.amber,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required String trend,
    required Color trendColor,
    IconData? icon,
    Color? iconColor,
  }) {
    return Container(
      width: 128,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
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
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
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
              if (trend.isNotEmpty) ...[
                const SizedBox(width: 4),
                Text(
                  trend,
                  style: TextStyle(
                    fontSize: 12,
                    color: trendColor,
                  ),
                ),
              ],
              if (icon != null) ...[
                const SizedBox(width: 4),
                Icon(
                  icon,
                  size: 16,
                  color: iconColor,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Order header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.indigo[50],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        order['icon'],
                        color: Colors.indigo,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order['restaurant'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          order['location'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
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
                      order['id'],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: order['statusColor'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        order['status'],
                        style: TextStyle(
                          fontSize: 12,
                          color: order['statusColor'],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Order details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // Customer info
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.person,
                      size: 20,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order['customer'],
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            order['address'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                // Items
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.shopping_bag,
                      size: 20,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        order['items'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                // Order meta
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          order['estimatedTime'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.directions,
                          size: 16,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          order['distance'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.payment,
                          size: 16,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          order['payment'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Order actions
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: Colors.grey[300]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.phone,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Contact',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.check,
                          size: 16,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          order['status'] == 'Pickup' ? 'Picked Up' : 'Delivered',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}