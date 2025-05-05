import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/status_bar.dart';
import '../widgets/order_summary_cards.dart';
import '../widgets/map_view.dart';
import '../widgets/active_orders_list.dart';
import '../widgets/performance_metrics.dart';
import '../widgets/quick_actions.dart';
import '../widgets/bottom_navigation.dart';
import '../models/order.dart';
import '../models/notification_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isOnline = true;
  String activeTab = 'home';
  bool showNotifications = false;
  
  final notifications = [
    NotificationModel(
      id: 1,
      type: 'order',
      message: 'New order request from Burger King',
      time: '2 mins ago'
    ),
    NotificationModel(
      id: 2,
      type: 'system',
      message: 'System maintenance scheduled for tonight',
      time: '15 mins ago'
    ),
    NotificationModel(
      id: 3,
      type: 'incentive',
      message: 'Complete 5 more deliveries to earn \$15 bonus!',
      time: '1 hour ago'
    ),
  ];
  
  final activeOrders = [
    Order(
      id: 'ORD-7842',
      restaurant: 'Burger King',
      location: '123 Main St',
      customer: 'Emily Johnson',
      address: '456 Oak Avenue, Apt 7B',
      items: '2x Whopper, 1x Large Fries, 1x Coke',
      estimatedTime: '25 mins',
      distance: '2.3 miles',
      payment: '\$24.50 (Paid)',
      status: 'Pickup'
    ),
    Order(
      id: 'ORD-7843',
      restaurant: 'Grocery Express',
      location: '789 Market St',
      customer: 'Michael Williams',
      address: '321 Pine Road',
      items: 'Groceries (8 items)',
      estimatedTime: '35 mins',
      distance: '3.1 miles',
      payment: '\$42.75 (Paid)',
      status: 'En Route'
    ),
  ];

  void toggleOnlineStatus() {
    setState(() {
      isOnline = !isOnline;
    });
  }

  void toggleNotifications() {
    setState(() {
      showNotifications = !showNotifications;
    });
  }

  void setTab(String tab) {
    setState(() {
      activeTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main Content Area
          SafeArea(
            child: Column(
              children: [
                // Status Bar Space
                const SizedBox(height: 56),
                
                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Order Summary Cards
                        OrderSummaryCards(),
                        
                        // Map Integration
                        const MapView(),
                        
                        // Active Orders List
                        ActiveOrdersList(orders: activeOrders),
                        
                        // Performance Metrics
                        const PerformanceMetrics(),
                        
                        // Bottom space for navigation
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Status Bar Overlay
          StatusBar(
            isOnline: isOnline,
            toggleOnlineStatus: toggleOnlineStatus,
            toggleNotifications: toggleNotifications,
            showNotifications: showNotifications,
            notifications: notifications,
          ),
          
          // Quick Actions
          const QuickActions(),
          
          // Bottom Navigation
          BottomNavigation(
            activeTab: activeTab,
            onTabChanged: setTab,
          ),
        ],
      ),
    );
  }
}