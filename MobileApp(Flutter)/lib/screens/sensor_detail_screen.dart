import 'package:flutter/material.dart';

import '../models/sensor_reading.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';
import '../widgets/navigation_helpers.dart';
import 'history_screen.dart';

class SensorDetailScreen extends StatelessWidget {
  const SensorDetailScreen({super.key, required this.sensor});

  final SensorReading sensor;

  @override
  Widget build(BuildContext context) {
    final isPH = sensor.name == 'pH level';
    return DetailScaffold(
      title: isPH ? 'pH Sensor' : sensor.name,
      trailing: isPH
          ? IconButton(
              tooltip: 'View pH history',
              onPressed: () => pushPage(context, const HistoryScreen()),
              icon: const Icon(
                Icons.lightbulb_outline,
                color: AppColors.accent,
              ),
            )
          : null,
      children: isPH
          ? [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Text(
                      'DFRobot Gravity\npH Sensor',
                      style: TextStyle(
                        fontSize: 24,
                        height: 1.15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'View pH history',
                    onPressed: () => pushPage(context, const HistoryScreen()),
                    icon: const Icon(
                      Icons.history_rounded,
                      color: AppColors.accent,
                      size: 28,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 225,
                child: Center(
                  child: Icon(sensor.icon, size: 130, color: AppColors.accent),
                ),
              ),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      'Real-time Monitoring',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    'Sensor Status',
                    style: TextStyle(color: AppColors.accent, fontSize: 11),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              surfaceCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 18,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _SensorComparison(
                        title: 'Pre-Filtration',
                        value: sensor.value,
                      ),
                    ),
                    const SizedBox(
                      height: 42,
                      child: VerticalDivider(color: Color(0xFF596060)),
                    ),
                    Expanded(
                      child: _SensorComparison(
                        title: 'Post Filtration',
                        value: sensor.postValue,
                      ),
                    ),
                    const SizedBox(
                      height: 42,
                      child: VerticalDivider(color: Color(0xFF596060)),
                    ),
                    const Expanded(
                      child: _SensorComparison(
                        title: 'Change',
                        value: '↓ 2.6',
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              surfaceCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'pH Level Over Time',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const Text(
                          'Pre-filtration',
                          style: TextStyle(
                            color: AppColors.accent,
                            fontSize: 11,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.accent,
                          size: 17,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 250,
                      child: TrendChart(
                        color: const Color(0xFFCA39E3),
                        elevated: true,
                      ),
                    ),
                  ],
                ),
              ),
            ]
          : [
              surfaceCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(sensor.icon, color: AppColors.accent, size: 24),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'Live-style sample reading',
                            style: TextStyle(color: AppColors.muted),
                          ),
                        ),
                        const ConnectionPill(
                          label: 'Online',
                          color: AppColors.accent,
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Text(
                      sensor.value,
                      style: const TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      sensor.name,
                      style: const TextStyle(color: AppColors.muted),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        Expanded(
                          child: MiniStat(
                            label: 'Pre-filtration',
                            value: sensor.value,
                            color: AppColors.warning,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: MiniStat(
                            label: 'Post-filtration',
                            value: sensor.postValue,
                            color: AppColors.accent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              surfaceCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Reading over time',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Last 7 days · sample data',
                      style: TextStyle(color: AppColors.muted),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      height: 175,
                      child: TrendChart(color: AppColors.accent),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              surfaceCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'About this sensor',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Text(
                      sensor.description,
                      style: const TextStyle(
                        color: AppColors.muted,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Reference guide: ${sensor.range}',
                      style: const TextStyle(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
    );
  }
}

class _SensorComparison extends StatelessWidget {
  const _SensorComparison({
    required this.title,
    required this.value,
    this.color = Colors.white,
  });

  final String title;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 10),
      ),
      const SizedBox(height: 8),
      Text(
        value,
        style: TextStyle(
          color: color,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}
