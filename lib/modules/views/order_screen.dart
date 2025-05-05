import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String _activeTab = 'active';
  String _searchQuery = '';
  bool _showDateFilter = false;
  bool _showSortOptions = false;
  bool _showStatusFilter = false;
  String _selectedSort = 'recent';
  String _selectedDateRange = 'today';
  String _selectedStatusFilter = 'all';
  bool _showOrderDetails = false;
  Map<String, dynamic>? _selectedOrder;

  final List<Map<String, dynamic>> _activeOrders = [
    {
      'id': 'ORD-7842',
      'restaurant': 'Burger King',
      'restaurantImage':
          'https://readdy.ai/api/search-image?query=burger%2520king%2520logo%2520on%2520a%2520clean%2520white%2520background%252C%2520professional%2520corporate%2520branding%252C%2520high%2520quality%2520commercial%2520photography%252C%2520centered%2520composition%252C%2520minimalist%2520style%252C%2520sharp%2520details%252C%2520official%2520logo%2520design&width=80&height=80&seq=1&orientation=squarish',
      'location': '123 Main St',
      'customer': 'Emily Johnson',
      'address': '456 Oak Avenue, Apt 7B',
      'items': [
        {'name': 'Whopper', 'quantity': 2, 'price': 5.99},
        {'name': 'Large Fries', 'quantity': 1, 'price': 3.49},
        {'name': 'Coke', 'quantity': 1, 'price': 2.29},
      ],
      'estimatedTime': '25 mins',
      'distance': '2.3 miles',
      'payment': '\$24.50',
      'paymentMethod': 'Credit Card',
      'paymentStatus': 'Paid',
      'status': 'Preparing',
      'timestamp': 'April 30, 2025 • 10:23 AM',
      'notes': 'Please include extra ketchup packets',
    },
    // ... other active orders
  ];

  final List<Map<String, dynamic>> _completedOrders = [
    {
      'id': 'ORD-7839',
      'restaurant': 'Taco Bell',
      'restaurantImage':
          'https://readdy.ai/api/search-image?query=taco%2520bell%2520logo%2520on%2520clean%2520white%2520background%252C%2520professional%2520corporate%2520branding%252C%2520high%2520quality%2520commercial%2520photography%252C%2520centered%2520composition%252C%2520minimalist%2520style%252C%2520sharp%2520details%252C%2520official%2520logo%2520design&width=80&height=80&seq=4&orientation=squarish',
      'location': '432 Bell Road',
      'customer': 'David Chen',
      'address': '765 Sunset Blvd, Apt 23',
      'items': [
        {'name': 'Crunchy Taco', 'quantity': 3, 'price': 1.99},
        {'name': 'Burrito Supreme', 'quantity': 1, 'price': 4.99},
        {'name': 'Nachos BellGrande', 'quantity': 1, 'price': 5.49},
        {'name': 'Mountain Dew', 'quantity': 2, 'price': 1.99},
      ],
      'estimatedTime': '20 mins',
      'actualTime': '18 mins',
      'distance': '2.5 miles',
      'payment': '\$22.42',
      'paymentMethod': 'Credit Card',
      'paymentStatus': 'Paid',
      'status': 'Completed',
      'timestamp': 'April 30, 2025 • 09:15 AM',
      'completedAt': 'April 30, 2025 • 09:33 AM',
      'rating': 5,
      'notes': 'Extra hot sauce packets',
    },
    // ... other completed orders
  ];

  List<Map<String, dynamic>> get filteredActiveOrders {
    return _activeOrders
        .where(
          (order) =>
              order['id'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
              order['restaurant'].toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ||
              order['customer'].toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ),
        )
        .toList();
  }

  List<Map<String, dynamic>> get filteredCompletedOrders {
    return _completedOrders
        .where(
          (order) =>
              order['id'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
              order['restaurant'].toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ||
              order['customer'].toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ),
        )
        .toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Preparing':
        return Colors.blue;
      case 'Ready':
        return Colors.green;
      case 'En Route':
        return Colors.orange;
      case 'Completed':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  String _calculateTotal(List<dynamic> items) {
    double total = items.fold(
      0,
      (sum, item) => sum + (item['price'] * item['quantity']),
    );
    return '\$${total.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Orders'),
          actions: [
            IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
          ],
          bottom: TabBar(
            labelColor: Colors.indigo,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.indigo,
            tabs: [
              Tab(text: 'Active Orders (${filteredActiveOrders.length})'),
              Tab(text: 'Completed Orders (${filteredCompletedOrders.length})'),
            ],
            onTap: (index) {
              setState(() {
                _activeTab = index == 0 ? 'active' : 'completed';
              });
            },
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                // Search and Filter Bar
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search orders...',
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 8),
                      _buildFilterButton(
                        icon: Icons.calendar_today,
                        showOptions: _showDateFilter,
                        onTap: () {
                          setState(() {
                            _showDateFilter = !_showDateFilter;
                            _showSortOptions = false;
                            _showStatusFilter = false;
                          });
                        },
                        options: [
                          _buildFilterOption('Today', 'today'),
                          _buildFilterOption('Yesterday', 'yesterday'),
                          _buildFilterOption('Last 7 days', 'week'),
                          _buildFilterOption('Last 30 days', 'month'),
                        ],
                      ),
                      SizedBox(width: 8),
                      _buildFilterButton(
                        icon: Icons.filter_list,
                        showOptions: _showStatusFilter,
                        onTap: () {
                          setState(() {
                            _showStatusFilter = !_showStatusFilter;
                            _showDateFilter = false;
                            _showSortOptions = false;
                          });
                        },
                        options: [
                          _buildFilterOption('All Statuses', 'all'),
                          _buildFilterOption('Preparing', 'preparing'),
                          _buildFilterOption('Ready', 'ready'),
                          _buildFilterOption('En Route', 'enroute'),
                        ],
                      ),
                      SizedBox(width: 8),
                      _buildFilterButton(
                        icon: Icons.sort,
                        showOptions: _showSortOptions,
                        onTap: () {
                          setState(() {
                            _showSortOptions = !_showSortOptions;
                            _showDateFilter = false;
                            _showStatusFilter = false;
                          });
                        },
                        options: [
                          _buildFilterOption('Most Recent', 'recent'),
                          _buildFilterOption('Oldest First', 'oldest'),
                          _buildFilterOption(
                            'Amount (High to Low)',
                            'amount_high',
                          ),
                          _buildFilterOption(
                            'Amount (Low to High)',
                            'amount_low',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Active Filters
                if (_selectedDateRange != 'today' ||
                    _selectedStatusFilter != 'all' ||
                    _selectedSort != 'recent')
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if (_selectedDateRange != 'today')
                          _buildActiveFilterChip(
                            label:
                                _selectedDateRange == 'yesterday'
                                    ? 'Yesterday'
                                    : _selectedDateRange == 'week'
                                    ? 'Last 7 days'
                                    : 'Last 30 days',
                            onDeleted: () => _handleDateRangeChange('today'),
                          ),
                        if (_selectedStatusFilter != 'all')
                          _buildActiveFilterChip(
                            label:
                                _selectedStatusFilter == 'preparing'
                                    ? 'Preparing'
                                    : _selectedStatusFilter == 'ready'
                                    ? 'Ready'
                                    : 'En Route',
                            onDeleted: () => _handleStatusFilterChange('all'),
                          ),
                        if (_selectedSort != 'recent')
                          _buildActiveFilterChip(
                            label:
                                _selectedSort == 'oldest'
                                    ? 'Oldest First'
                                    : _selectedSort == 'amount_high'
                                    ? 'Amount (High to Low)'
                                    : 'Amount (Low to High)',
                            onDeleted: () => _handleSortChange('recent'),
                          ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _selectedDateRange = 'today';
                              _selectedStatusFilter = 'all';
                              _selectedSort = 'recent';
                            });
                          },
                          child: Text(
                            'Clear All',
                            style: TextStyle(color: Colors.indigo),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Tab Views (Order List)
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildOrderList(filteredActiveOrders),
                      _buildOrderList(
                        filteredCompletedOrders,
                        isCompleted: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Order Details Modal Overlay
            if (_showOrderDetails && _selectedOrder != null)
              Positioned.fill(child: _buildOrderDetailsModal()),
          ],
        ),

        // Bottom Navigation
        // bottomNavigationBar: BottomNavigationBar(
        //   type: BottomNavigationBarType.fixed,
        //   currentIndex: 1, // Orders tab is active
        //   selectedItemColor: Colors.indigo,
        //   unselectedItemColor: Colors.grey,
        //   items: [
        //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.list_alt),
        //       label: 'Orders',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.wallet),
        //       label: 'Earnings',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.bar_chart),
        //       label: 'Stats',
        //     ),
        //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        //   ],
        // ),

        // Quick Actions
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.indigo,
          mini: true,
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }

  Widget _buildFilterButton({
    required IconData icon,
    required bool showOptions,
    required VoidCallback onTap,
    required List<Widget> options,
  }) {
    return Stack(
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: onTap,
          style: IconButton.styleFrom(
            backgroundColor: Colors.grey[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        if (showOptions)
          Positioned(
            right: 0,
            top: 48,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 180,
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: options,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildFilterOption(String label, String value) {
    return InkWell(
      onTap: () {
        if (label == 'Today' ||
            label == 'Yesterday' ||
            label == 'Last 7 days' ||
            label == 'Last 30 days') {
          _handleDateRangeChange(value);
        } else if (label.contains('Status')) {
          _handleStatusFilterChange(value);
        } else {
          _handleSortChange(value);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        color: _getFilterOptionColor(label, value),
        child: Text(
          label,
          style: TextStyle(
            color:
                _getFilterOptionColor(label, value) == Colors.indigo[50]
                    ? Colors.indigo
                    : Colors.grey[800],
          ),
        ),
      ),
    );
  }

  Color? _getFilterOptionColor(String label, String value) {
    if (label == 'Today' && _selectedDateRange == 'today') {
      return Colors.indigo[50];
    } else if (label == 'Yesterday' && _selectedDateRange == 'yesterday') {
      return Colors.indigo[50];
    } else if (label == 'Last 7 days' && _selectedDateRange == 'week') {
      return Colors.indigo[50];
    } else if (label == 'Last 30 days' && _selectedDateRange == 'month') {
      return Colors.indigo[50];
    } else if (label == 'All Statuses' && _selectedStatusFilter == 'all') {
      return Colors.indigo[50];
    } else if (label == 'Preparing' && _selectedStatusFilter == 'preparing') {
      return Colors.indigo[50];
    } else if (label == 'Ready' && _selectedStatusFilter == 'ready') {
      return Colors.indigo[50];
    } else if (label == 'En Route' && _selectedStatusFilter == 'enroute') {
      return Colors.indigo[50];
    } else if (label == 'Most Recent' && _selectedSort == 'recent') {
      return Colors.indigo[50];
    } else if (label == 'Oldest First' && _selectedSort == 'oldest') {
      return Colors.indigo[50];
    } else if (label == 'Amount (High to Low)' &&
        _selectedSort == 'amount_high') {
      return Colors.indigo[50];
    } else if (label == 'Amount (Low to High)' &&
        _selectedSort == 'amount_low') {
      return Colors.indigo[50];
    }
    return null;
  }

  Widget _buildActiveFilterChip({
    required String label,
    required VoidCallback onDeleted,
  }) {
    return Chip(
      label: Text(label, style: TextStyle(color: Colors.indigo)),
      backgroundColor: Colors.indigo[50],
      deleteIcon: Icon(Icons.close, size: 16, color: Colors.indigo[400]),
      onDeleted: onDeleted,
    );
  }

  Widget _buildOrderList(
    List<Map<String, dynamic>> orders, {
    bool isCompleted = false,
  }) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              isCompleted
                  ? 'https://readdy.ai/api/search-image?query=empty%2520order%2520history%2520illustration'
                  : 'https://readdy.ai/api/search-image?query=empty%2520order%2520list%2520illustration',
              width: 120,
              height: 120,
            ),
            SizedBox(height: 16),
            Text(
              isCompleted ? 'No Completed Orders' : 'No Active Orders',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              isCompleted
                  ? 'You haven\'t completed any orders in this time period.'
                  : 'You don\'t have any active orders at the moment.',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(isCompleted ? 'Change Filters' : 'Refresh'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          margin: EdgeInsets.only(bottom: 16),
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedOrder = order;
                _showOrderDetails = true;
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Order Header
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(order['restaurantImage']),
                        radius: 20,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order['restaurant'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              order['location'],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(order['id'], style: TextStyle(fontSize: 12)),
                          SizedBox(height: 4),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(
                                order['status'],
                              ).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              order['status'],
                              style: TextStyle(
                                fontSize: 12,
                                color: _getStatusColor(order['status']),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Order Details
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _buildDetailRow(
                        Icons.person,
                        order['customer'],
                        order['address'],
                      ),
                      SizedBox(height: 12),
                      _buildDetailRow(
                        Icons.shopping_bag,
                        order['items']
                            .map<Widget>(
                              (item) => Text(
                                '${item['quantity']}x ${item['name']}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(height: 12),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        childAspectRatio: 4,
                        children: [
                          _buildGridItem(
                            Icons.access_time,
                            order['estimatedTime'],
                          ),
                          _buildGridItem(Icons.directions, order['distance']),
                          _buildGridItem(
                            Icons.payment,
                            '${order['payment']} (${order['paymentStatus']})',
                          ),
                          _buildGridItem(
                            Icons.calendar_today,
                            order['timestamp'].split('•')[0].trim(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Order Actions
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.grey[300]!),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(isCompleted ? 'View Receipt' : 'Contact'),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            isCompleted
                                ? 'View Route'
                                : order['status'] == 'Preparing'
                                ? 'Ready for Pickup'
                                : order['status'] == 'Ready'
                                ? 'Picked Up'
                                : 'Delivered',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(
    IconData icon,
    dynamic content, [
    String? secondaryContent,
  ]) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (content is String)
                Text(content, style: TextStyle(fontWeight: FontWeight.w500)),
              if (content is List<Widget>) Wrap(children: content),
              if (secondaryContent != null)
                Text(
                  secondaryContent,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGridItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildOrderDetailsModal() {
    return Stack(
      children: [
        // Background overlay
        GestureDetector(
          onTap: () {
            setState(() {
              _showOrderDetails = false;
            });
          },
          child: Container(color: Colors.black.withOpacity(0.5)),
        ),

        // Modal content
        Center(
          child: Material(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            setState(() {
                              _showOrderDetails = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  // Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Order ID and Status
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order ID',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    _selectedOrder!['id'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(
                                    _selectedOrder!['status'],
                                  ).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  _selectedOrder!['status'],
                                  style: TextStyle(
                                    color: _getStatusColor(
                                      _selectedOrder!['status'],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),

                          // Restaurant Info
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  _selectedOrder!['restaurantImage'],
                                ),
                                radius: 24,
                              ),
                              SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _selectedOrder!['restaurant'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    _selectedOrder!['location'],
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 24),

                          // Customer Information
                          Text(
                            'Customer Information',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                _buildModalDetailRow(
                                  Icons.person,
                                  _selectedOrder!['customer'],
                                ),
                                SizedBox(height: 8),
                                _buildModalDetailRow(
                                  Icons.location_on,
                                  _selectedOrder!['address'],
                                ),
                                SizedBox(height: 8),
                                _buildModalDetailRow(
                                  Icons.phone,
                                  '+1 (555) 123-4567',
                                  // isPhone: true,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24),

                          // Order Items
                          Text(
                            'Order Items',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                ..._selectedOrder!['items'].map<Widget>(
                                  (item) => Padding(
                                    padding: EdgeInsets.only(bottom: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${item['quantity']}x ${item['name']}',
                                        ),
                                        Text(
                                          '\$${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      _calculateTotal(_selectedOrder!['items']),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24),

                          // Payment Information
                          Text(
                            'Payment Information',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                _buildModalDetailRow(
                                  Icons.credit_card,
                                  'Payment Method',
                                  _selectedOrder!['paymentMethod'],
                                ),
                                SizedBox(height: 8),
                                _buildModalDetailRow(
                                  _selectedOrder!['paymentStatus'] == 'Paid'
                                      ? Icons.check_circle
                                      : Icons.access_time,
                                  'Payment Status',
                                  _selectedOrder!['paymentStatus'],
                                  // isStatus: true,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24),

                          // Delivery Information
                          Text(
                            'Delivery Information',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                _buildModalDetailRow(
                                  Icons.directions,
                                  'Distance',
                                  _selectedOrder!['distance'],
                                ),
                                SizedBox(height: 8),
                                _buildModalDetailRow(
                                  Icons.access_time,
                                  'Estimated Time',
                                  _selectedOrder!['estimatedTime'],
                                ),
                                if (_selectedOrder!['status'] == 'Completed')
                                  SizedBox(height: 8),
                                if (_selectedOrder!['status'] == 'Completed')
                                  _buildModalDetailRow(
                                    Icons.timer,
                                    'Actual Delivery Time',
                                    _selectedOrder!['actualTime'],
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24),

                          // Special Instructions
                          if (_selectedOrder!['notes'] != null &&
                              _selectedOrder!['notes'].isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Special Instructions',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(_selectedOrder!['notes']),
                                ),
                                SizedBox(height: 24),
                              ],
                            ),

                          // Customer Rating
                          if (_selectedOrder!['status'] == 'Completed')
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Customer Rating',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Row(
                                        children: List.generate(
                                          5,
                                          (index) => Icon(
                                            Icons.star,
                                            size: 20,
                                            color:
                                                index < _selectedOrder!['rating']
                                                    ? Colors.amber
                                                    : Colors.grey[300],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text('${_selectedOrder!['rating']}/5'),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 24),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),

                  // Footer Button
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          _selectedOrder!['status'] == 'Completed'
                              ? 'Download Receipt'
                              : _selectedOrder!['status'] == 'Preparing'
                              ? 'Mark as Ready'
                              : _selectedOrder!['status'] == 'Ready'
                              ? 'Start Delivery'
                              : 'Complete Delivery',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModalDetailRow(
    IconData icon,
    String label, [
    String? value,
    bool isPhone = false,
    bool isStatus = false,
  ]) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 12, color: Colors.grey)),
              if (value != null && !isStatus)
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: isPhone ? Colors.indigo : Colors.black,
                  ),
                ),
              if (isStatus && value != null)
                Row(
                  children: [
                    Icon(
                      _selectedOrder!['paymentStatus'] == 'Paid'
                          ? Icons.check_circle
                          : Icons.access_time,
                      size: 16,
                      color:
                          _selectedOrder!['paymentStatus'] == 'Paid'
                              ? Colors.green
                              : Colors.orange,
                    ),
                    SizedBox(width: 4),
                    Text(
                      _selectedOrder!['paymentStatus'],
                      style: TextStyle(
                        color:
                            _selectedOrder!['paymentStatus'] == 'Paid'
                                ? Colors.green
                                : Colors.orange,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }

  void _handleDateRangeChange(String range) {
    setState(() {
      _selectedDateRange = range;
      _showDateFilter = false;
    });
  }

  void _handleSortChange(String sortOption) {
    setState(() {
      _selectedSort = sortOption;
      _showSortOptions = false;
    });
  }

  void _handleStatusFilterChange(String status) {
    setState(() {
      _selectedStatusFilter = status;
      _showStatusFilter = false;
    });
  }
}
