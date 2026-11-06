import 'package:flutter/material.dart';

import '../models/sensor_reading.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';
import '../widgets/navigation_helpers.dart';
import 'notifications_screen.dart';
import 'sensor_detail_screen.dart';

class SensorsScreen extends StatelessWidget {
  const SensorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppHeader(
          showBack: true,
          onNotifications: () => pushPage(context, const NotificationsScreen()),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(12, 16, 12, 12),
          child: Align(
            alignment: Alignment.centerLeft,
            child: SectionTitle('Sensors'),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.2,
            ),
            itemCount: sampleSensorReadings.length,
            itemBuilder: (context, index) {
              final sensor = sampleSensorReadings[index];
              return Material(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(18),
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () =>
                      pushPage(context, SensorDetailScreen(sensor: sensor)),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: const BoxDecoration(
                              color: AppColors.surfaceRaised,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              sensor.icon,
                              color: Colors.white,
                              size: 19,
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.topRight,
                          child: Icon(Icons.chevron_right, size: 22),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            sensor.name == 'TDS'
                                ? 'Total Dissolved\nSolids (TDS)'
                                : sensor.name == 'pH level'
                                ? 'pH Level'
                                : sensor.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
