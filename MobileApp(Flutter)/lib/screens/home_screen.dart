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
                  ],
                ),
                const SizedBox(height: 8),
                StageSwitch(
                  postFiltration: _postFiltration,
                  onChanged: (value) => setState(() => _postFiltration = value),
                ),
                const SizedBox(height: 4),
                surfaceCard(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Last Updated:',
                                  style: TextStyle(
                                    color: AppColors.foreground,
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
                _ExpandableInsightTile(
                  icon: Icons.science_outlined,
                  title: 'pH Level Monitoring',
                  subtitle: 'Monitor pH Level changes',
                  sensor: sampleSensorReadings[1],
                  onOpen: () => pushPage(
                    context,
                    SensorDetailScreen(sensor: sampleSensorReadings[1]),
                  ),
                ),
                _ExpandableInsightTile(
                  icon: Icons.thermostat_outlined,
                  title: 'Water Temperature Monitoring',
                  subtitle: 'Monitor temperature changes',
                  sensor: sampleSensorReadings[0],
                  onOpen: () => pushPage(
                    context,
                    SensorDetailScreen(sensor: sampleSensorReadings[0]),
                  ),
                ),
                _ExpandableInsightTile(
                  icon: Icons.water_outlined,
                  title: 'Turbidity Monitoring',
                  subtitle: 'Monitor turbidity changes',
                  sensor: sampleSensorReadings[2],
                  onOpen: () => pushPage(
                    context,
                    SensorDetailScreen(sensor: sampleSensorReadings[2]),
                  ),
                ),
                _ExpandableInsightTile(
                  icon: Icons.bubble_chart_outlined,
                  title: 'TDS Monitoring',
                  subtitle: 'Monitor dissolved solids changes',
                  sensor: sampleSensorReadings[3],
                  onOpen: () => pushPage(
                    context,
                    SensorDetailScreen(sensor: sampleSensorReadings[3]),
                  ),
                ),
                _ExpandableInsightTile(
                  icon: Icons.waves_rounded,
                  title: 'Water Flow Monitoring',
                  subtitle: 'Monitor flow rate changes',
                  sensor: sampleSensorReadings[4],
                  onOpen: () => pushPage(
                    context,
                    SensorDetailScreen(sensor: sampleSensorReadings[4]),
                  ),
                ),
                _ExpandableInsightTile(
                  icon: Icons.show_chart_rounded,
                  title: 'Water quality history',
                  subtitle: 'Review historical readings and trends',
                  onOpen: () => pushPage(context, const HistoryScreen()),
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

class _ExpandableInsightTile extends StatelessWidget {
  const _ExpandableInsightTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onOpen,
    this.sensor,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final SensorReading? sensor;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 12),
            childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
            leading: Icon(icon, color: AppColors.accent, size: 21),
            title: Text(title, style: const TextStyle(fontSize: 15)),
            subtitle: Text(
              subtitle,
              style: TextStyle(color: AppColors.muted, fontSize: 11),
            ),
            iconColor: AppColors.accent,
            collapsedIconColor: AppColors.foreground,
            children: [
              if (sensor case final reading?) ...[
                Row(
                  children: [
                    Expanded(
                      child: _InsightReading(
                        label: 'Pre-filtration',
                        value: reading.value,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _InsightReading(
                        label: 'Post-filtration',
                        value: reading.postValue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ] else ...[
                Text(
                  'Review historical readings and compare filtration stages.',
                  style: TextStyle(color: AppColors.muted, fontSize: 12),
                ),
                const SizedBox(height: 8),
              ],
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: onOpen,
                  iconAlignment: IconAlignment.end,
                  icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                  label: const Text('View details'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.accent,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InsightReading extends StatelessWidget {
  const _InsightReading({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(color: AppColors.muted, fontSize: 10)),
      const SizedBox(height: 4),
      Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
    ],
  );
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
