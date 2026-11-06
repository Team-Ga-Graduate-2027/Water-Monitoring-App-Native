import 'package:flutter/material.dart';

import '../models/sensor_reading.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';
import '../widgets/navigation_helpers.dart';
import 'history_screen.dart';
import 'notifications_screen.dart';
import 'sensor_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.onSeeSensors});

  final VoidCallback onSeeSensors;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _postFiltration = false;

  @override
  Widget build(BuildContext context) {
    final readings = _postFiltration
        ? sampleSensorReadings
              .map((sensor) => sensor.copyWith(value: sensor.postValue))
              .toList()
        : sampleSensorReadings;
    return Column(
      children: [
        AppHeader(
          onNotifications: () => pushPage(context, const NotificationsScreen()),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(child: SectionTitle('Sensors')),
                    TextButton(
                      onPressed: widget.onSeeSensors,
                      child: const Text(
                        'See All →',
                        style: TextStyle(color: AppColors.accent),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 136,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: readings.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final sensor = readings[index];
                      return SizedBox(
                        width: 143,
                        child: SensorCard(
                          sensor: sensor,
                          compact: true,
                          onTap: () => pushPage(
                            context,
                            SensorDetailScreen(sensor: sensor),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    const Expanded(child: SectionTitle('Live Dashboard')),
                    TextButton.icon(
                      onPressed: () =>
                          setState(() => _postFiltration = !_postFiltration),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.accent,
                        padding: EdgeInsets.zero,
                      ),
                      icon: const SizedBox.shrink(),
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _postFiltration
                                ? 'Post-filtration'
                                : 'Pre-filtration',
                            style: const TextStyle(fontSize: 12),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.keyboard_arrow_down, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                surfaceCard(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Last Updated:',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'September 24 • 10:37 am',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Battery Percentage:',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '87%',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Divider(height: 1, color: Color(0xFF485050)),
                      ),
                      Row(
                        children: [
                          for (var index = 0; index < 4; index++) ...[
                            if (index > 0)
                              const SizedBox(
                                height: 42,
                                child: VerticalDivider(
                                  width: 1,
                                  color: Color(0xFF596060),
                                ),
                              ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    _homeMetricName(readings[index].name),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    readings[index].value,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _StatusCard(
                        title: 'Within Range',
                        subtitle: 'Water Quality Range',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _StatusCard(
                        title: 'Connected',
                        subtitle: 'Device Status',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const SectionTitle('Monitoring Insights'),
                const SizedBox(height: 4),
                InsightTile(
                  icon: Icons.science_outlined,
                  title: 'pH Level Monitoring',
                  subtitle: 'Monitor pH Level changes',
                  onTap: () => pushPage(
                    context,
                    SensorDetailScreen(sensor: sampleSensorReadings[1]),
                  ),
                ),
                const SizedBox(height: 9),
                InsightTile(
                  icon: Icons.thermostat_outlined,
                  title: 'Water Temperature Monitoring',
                  subtitle: 'Monitor temperature changes',
                  onTap: () => pushPage(
                    context,
                    SensorDetailScreen(sensor: sampleSensorReadings[0]),
                  ),
                ),
                const SizedBox(height: 9),
                InsightTile(
                  icon: Icons.water_outlined,
                  title: 'Turbidity Monitoring',
                  subtitle: 'Monitor turbidity changes',
                  onTap: () => pushPage(
                    context,
                    SensorDetailScreen(sensor: sampleSensorReadings[2]),
                  ),
                ),
                const SizedBox(height: 9),
                InsightTile(
                  icon: Icons.show_chart_rounded,
                  title: 'Water quality history',
                  subtitle: 'Review historical readings and trends',
                  onTap: () => pushPage(context, const HistoryScreen()),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _homeMetricName(String name) => name == 'pH level' ? 'pH level' : name;
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Container(
    height: 78,
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.circle, color: AppColors.accent, size: 7),
            const SizedBox(width: 5),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 7),
        Text(subtitle, style: const TextStyle(fontSize: 11)),
      ],
    ),
  );
}
