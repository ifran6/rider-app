import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/notification_model.dart';

class StatusBar extends StatelessWidget {
  final bool isOnline;
  final VoidCallback toggleOnlineStatus;
  final VoidCallback toggleNotifications;
  final bool showNotifications;
  final List<NotificationModel> notifications;

  const StatusBar({
    super.key,
    required this.isOnline,
    required this.toggleOnlineStatus,
    required this.toggleNotifications,
    required this.showNotifications,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: SafeArea(
          bottom: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Online Status & Toggle
              Row(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isOnline ? Colors.green[500] : Colors.grey[400],
                        ),
                      ),
                      Text(
                        isOnline ? 'Online' : 'Offline',
                        style: TextStyle(
                          color: isOnline ? Colors.green[600] : Colors.grey[400],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  // Toggle Switch
                  SizedBox(
                    width: 48,
                    height: 24,
                    child: Switch(
                      value: isOnline,
                      onChanged: (_) => toggleOnlineStatus(),
                      activeColor: Colors.indigo[600],
                      activeTrackColor: Colors.indigo[200],
                    ),
                  ),
                ],
              ),
              
              // Notifications & Profile
              Row(
                children: [
                  // Notifications Button
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(FontAwesomeIcons.bell, size: 20),
                        color: Colors.grey[600],
                        onPressed: toggleNotifications,
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
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
                          border: Border.all(color: Colors.grey[200]!),
                          image: const DecorationImage(
                            image: NetworkImage(
                              'https://via.placeholder.com/100',
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
        ),
      ),
    );
  }
}