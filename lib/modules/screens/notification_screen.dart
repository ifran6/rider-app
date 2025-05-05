import 'package:flutter/material.dart';

class NotificationPreferencesScreen extends StatefulWidget {
  const NotificationPreferencesScreen({super.key});

  @override
  _NotificationPreferencesScreenState createState() => _NotificationPreferencesScreenState();
}

class _NotificationPreferencesScreenState extends State<NotificationPreferencesScreen> {
  // Notification types
  bool orderUpdates = true;
  bool promotions = false;
  bool paymentNotifications = true;
  bool deliveryStatus = true;
  bool systemUpdates = false;

  // Notification methods
  String method = 'push';

  // Frequency
  String frequency = 'realtime';
  bool showFrequencyOptions = false;

  // Do Not Disturb
  bool doNotDisturb = false;
  TimeOfDay dndStart = TimeOfDay(hour: 22, minute: 0);
  TimeOfDay dndEnd = TimeOfDay(hour: 7, minute: 0);

  // Sound & Vibration
  bool sound = true;
  bool vibration = true;

  // Priority
  String priority = 'high';
  bool showPriorityOptions = false;

  String _formatTimeOfDay(TimeOfDay t) {
    final hours = t.hour.toString().padLeft(2, '0');
    final minutes = t.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  void _pickTime(bool isStart) async {
    final result = await showTimePicker(
      context: context,
      initialTime: isStart ? dndStart : dndEnd,
    );
    if (result != null) {
      setState(() {
        if (isStart) {
          dndStart = result;
        } else {
          dndEnd = result;
        }
      });
    }
  }

  void _savePreferences() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Settings saved successfully!')),
    );
  }

  Widget _buildToggle({required IconData icon, required Color iconBg, required String title, required String subtitle, required bool value, required ValueChanged<bool> onChanged}) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      title: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBg.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(icon, color: iconBg),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
                SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioOption({required IconData icon, required Color iconBg, required String title, required String subtitle, required String valueKey}) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconBg.withOpacity(0.2),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(icon, color: iconBg),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
      trailing: Radio<String>(
        value: valueKey,
        groupValue: method,
        onChanged: (val) => setState(() => method = val!),
      ),
      onTap: () => setState(() => method = valueKey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Notification Preferences'),
        actions: [
          TextButton(
            onPressed: _savePreferences,
            child: Text('Save', style: TextStyle(color: Colors.blueAccent)),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Notification Types
          Card(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Notification Types', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                Divider(height: 0),
                _buildToggle(
                  icon: Icons.local_shipping,
                  iconBg: Colors.blue,
                  title: 'Order Updates',
                  subtitle: 'Get notified about your order status',
                  value: orderUpdates,
                  onChanged: (v) => setState(() => orderUpdates = v),
                ),
                _buildToggle(
                  icon: Icons.local_offer,
                  iconBg: Colors.purple,
                  title: 'Promotions & Offers',
                  subtitle: 'Receive special deals and discounts',
                  value: promotions,
                  onChanged: (v) => setState(() => promotions = v),
                ),
                _buildToggle(
                  icon: Icons.payment,
                  iconBg: Colors.green,
                  title: 'Payment Notifications',
                  subtitle: 'Updates about your payments',
                  value: paymentNotifications,
                  onChanged: (v) => setState(() => paymentNotifications = v),
                ),
                _buildToggle(
                  icon: Icons.local_shipping,
                  iconBg: Colors.yellow[700]!,
                  title: 'Delivery Status',
                  subtitle: 'Track your order in real-time',
                  value: deliveryStatus,
                  onChanged: (v) => setState(() => deliveryStatus = v),
                ),
                _buildToggle(
                  icon: Icons.update,
                  iconBg: Colors.red,
                  title: 'System Updates',
                  subtitle: 'App updates and maintenance',
                  value: systemUpdates,
                  onChanged: (v) => setState(() => systemUpdates = v),
                ),
              ],
            ),
          ),

          SizedBox(height: 16),
          // Notification Methods
          Card(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Notification Methods', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                Divider(height: 0),
                _buildRadioOption(
                  icon: Icons.notifications,
                  iconBg: Colors.blue,
                  title: 'Push Notifications',
                  subtitle: 'Receive alerts on your device',
                  valueKey: 'push',
                ),
                _buildRadioOption(
                  icon: Icons.email,
                  iconBg: Colors.green,
                  title: 'Email Notifications',
                  subtitle: 'Get updates in your inbox',
                  valueKey: 'email',
                ),
                _buildRadioOption(
                  icon: Icons.sms,
                  iconBg: Colors.purple,
                  title: 'SMS Notifications',
                  subtitle: 'Text messages to your phone',
                  valueKey: 'sms',
                ),
              ],
            ),
          ),

          SizedBox(height: 16),
          // Frequency & Priority & DnD & Sound/Vibration
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Notification Frequency', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Frequency', style: TextStyle(fontWeight: FontWeight.w500)),
                    subtitle: Text({
                      'realtime': 'Real-time',
                      'hourly': 'Hourly digest',
                      'daily': 'Daily digest',
                      'weekly': 'Weekly summary'
                    }[frequency]!),
                    trailing: IconButton(
                      icon: Icon(showFrequencyOptions ? Icons.expand_less : Icons.expand_more),
                      onPressed: () => setState(() => showFrequencyOptions = !showFrequencyOptions),
                    ),
                  ),
                  if (showFrequencyOptions) ...[
                    RadioListTile<String>(value: 'realtime', groupValue: frequency, title: Text('Real-time'), subtitle: Text('Receive notifications as they happen'), onChanged: (v) => setState(() { frequency = v!; showFrequencyOptions = false;})),
                    RadioListTile<String>(value: 'hourly', groupValue: frequency, title: Text('Hourly digest'), subtitle: Text('Receive a summary every hour'), onChanged: (v) => setState(() { frequency = v!; showFrequencyOptions = false;})),
                    RadioListTile<String>(value: 'daily', groupValue: frequency, title: Text('Daily digest'), subtitle: Text('Receive a summary once a day'), onChanged: (v) => setState(() { frequency = v!; showFrequencyOptions = false;})),
                    RadioListTile<String>(value: 'weekly', groupValue: frequency, title: Text('Weekly summary'), subtitle: Text('Receive a summary once a week'), onChanged: (v) => setState(() { frequency = v!; showFrequencyOptions = false;})),
                  ],

                  Divider(),
                  SwitchListTile(
                    value: doNotDisturb,
                    onChanged: (v) => setState(() => doNotDisturb = v),
                    title: Text('Do Not Disturb', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    subtitle: Text('Silence notifications during set hours'),
                  ),
                  if (doNotDisturb) ...[
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('Start'),
                      trailing: Text(_formatTimeOfDay(dndStart)),
                      onTap: () => _pickTime(true),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('End'),
                      trailing: Text(_formatTimeOfDay(dndEnd)),
                      onTap: () => _pickTime(false),
                    ),
                  ],

                  Divider(),
                  SwitchListTile(
                    value: sound,
                    onChanged: (v) => setState(() => sound = v),
                    title: Text('Sound'),
                    subtitle: Text('Play sound with notifications'),
                  ),
                  SwitchListTile(
                    value: vibration,
                    onChanged: (v) => setState(() => vibration = v),
                    title: Text('Vibration'),
                    subtitle: Text('Vibrate with notifications'),
                  ),

                  Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Priority Level', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    subtitle: Text({ 'high': 'High', 'medium': 'Medium', 'low': 'Low' }[priority]!),
                    trailing: IconButton(
                      icon: Icon(showPriorityOptions ? Icons.expand_less : Icons.expand_more),
                      onPressed: () => setState(() => showPriorityOptions = !showPriorityOptions),
                    ),
                  ),
                  if (showPriorityOptions) ...[
                    RadioListTile<String>(value: 'high', groupValue: priority, title: Text('High'), subtitle: Text('All notifications are displayed prominently'), onChanged: (v) => setState(() { priority = v!; showPriorityOptions = false;})),
                    RadioListTile<String>(value: 'medium', groupValue: priority, title: Text('Medium'), subtitle: Text('Standard notification display'), onChanged: (v) => setState(() { priority = v!; showPriorityOptions = false;})),
                    RadioListTile<String>(value: 'low', groupValue: priority, title: Text('Low'), subtitle: Text('Silent notifications'), onChanged: (v) => setState(() { priority = v!; showPriorityOptions = false;})),
                  ],

                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _savePreferences,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      minimumSize: Size(double.infinity, 0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Save Changes', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
