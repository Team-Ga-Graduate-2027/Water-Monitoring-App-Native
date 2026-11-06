import 'package:flutter/material.dart';

import '../models/sensor_reading.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';
import '../widgets/navigation_helpers.dart';
import 'sensor_detail_screen.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _readAll = false;

  @override
  Widget build(BuildContext context) {
    return DetailScaffold(
      title: 'Notification',
      trailing: TextButton(
        onPressed: () => setState(() => _readAll = true),
        child: Text(
          _readAll ? 'All Read' : 'Read All (2)',
          style: const TextStyle(color: AppColors.accent, fontSize: 12),
        ),
      ),
      children: [
        NotificationTile(
          icon: Icons.error_outline_rounded,
          title: 'pH Alert',
          description: 'pH Level Outside Reference Range Pre-filtration pH reached 9.8, which is above the reference range.',
          date: '27 Sep 2026, 9:10 am',
          color: AppColors.danger,
          unread: !_readAll,
          onTap: () => pushPage(context, const PHAlertDetailsScreen()),
        ),
        const Divider(height: 1, indent: 66),
        NotificationTile(
          icon: Icons.error_outline_rounded,
          title: 'Turbidity Alert',
          description: 'High Turbidity Detected Post-filtration turbidity spiked to 4.2 NTU, exceeding the 1.0 NTU threshold.',
          date: '26 Sep 2026, 3:45 pm',
          color: AppColors.danger,
          unread: !_readAll,
          onTap: () => pushPage(
            context,
            SensorDetailScreen(sensor: sampleSensorReadings[2]),
          ),
        ),
        const Divider(height: 1, indent: 66),
        NotificationTile(
          icon: Icons.error_outline_rounded,
          title: 'Flow rate notice',
          description: 'Low Flow Rate Warning Intake flow dropped to 12 L/min, below the expected 20 L/min minimum rate.',
          date: '24 Sep 2026, 8:05 am',
          color: AppColors.danger,
          unread: false,
          onTap: () => pushPage(
            context,
            SensorDetailScreen(sensor: sampleSensorReadings[4]),
          ),
        ),
      ],
    );
  }
}

class PHAlertDetailsScreen extends StatelessWidget {
  const PHAlertDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DetailScaffold(
      title: 'pH Alert Details',
      children: [
        surfaceCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Pre-filtration',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Text(
                    'Alert reading · not live',
                    style: TextStyle(color: AppColors.muted, fontSize: 11),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '9.8',
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.w800),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8, bottom: 9),
                    child: Text('pH', style: TextStyle(color: AppColors.muted)),
                  ),
                  Spacer(),
                  Text(
                    '1.3 above upper limit',
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.white, height: 1.4),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Reference range: 6.5 - 8.5',
                style: TextStyle(color: AppColors.muted),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        const Padding(
          padding: EdgeInsets.fromLTRB(8, 8, 8, 4),
          child: Text(
            'pH Level Guide',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          ),
        ),
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.danger, width: 2),
              ),
              child: const Center(
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: AppColors.danger,
                ),
              ),
            ),
            const Text(
              '9.8',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Alkaline', style: TextStyle(fontSize: 14)),
                  Text(
                    'More alkaline than the commonly referenced drinking-water range.',
                    style: TextStyle(fontSize: 11, height: 1.3),
                  ),
                ],
              ),
            ),
            const Icon(Icons.keyboard_arrow_down),
          ],
        ),
        const SizedBox(height: 15),
        const Text(
          'What to check?',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
        ),
        const SizedBox(height: 10),
        surfaceCard(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Verify the measurement', style: TextStyle(fontSize: 13)),
              SizedBox(height: 4),
              Text(
                'Rinse the probe, check calibration and repeat the pre-filtration reading once it stabilizes.',
                style: TextStyle(
                  color: AppColors.muted,
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
              Divider(height: 24),
              Text('If it remains above range', style: TextStyle(fontSize: 13)),
              SizedBox(height: 4),
              Text(
                'Compare with pH history and have the source water and filtration setup reviewed.',
                style: TextStyle(
                  color: AppColors.muted,
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 13),
        const Text(
          'This alert concerns pre-filtration water. pH alone does not confirm drinking-water safety.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.muted, fontSize: 12, height: 1.45),
        ),
        const SizedBox(height: 28),
        const Text(
          'wag muna tong page na to!!!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 17),
        ),
      ],
    );
  }
}
