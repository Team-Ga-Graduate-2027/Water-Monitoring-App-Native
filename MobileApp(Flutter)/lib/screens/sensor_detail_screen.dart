import 'package:flutter/material.dart';

import '../models/sensor_reading.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';
import '../widgets/navigation_helpers.dart';

class SensorDetailScreen extends StatefulWidget {
  const SensorDetailScreen({super.key, required this.sensor});

  final SensorReading sensor;

  @override
  State<SensorDetailScreen> createState() => _SensorDetailScreenState();
}

class _SensorDetailScreenState extends State<SensorDetailScreen> {
  bool _postFiltration = false;
  String _range = '7 days';

  SensorReading get _sensor => widget.sensor;
  String get _reading => _postFiltration ? _sensor.postValue : _sensor.value;
  String get _sensorTitle => switch (_sensor.name) {
    'pH level' => 'pH Sensor',
    'TDS' => 'TDS Sensor',
    'Water flow' => 'Water Flow Sensor',
    _ => '${_sensor.name} Sensor',
  };
  String get _modelName => switch (_sensor.name) {
    'pH level' => 'DFRobot Gravity Analog pH Sensor V2',
    'TDS' => 'DFRobot Gravity Analog TDS Sensor',
    'Temperature' => 'DFRobot Gravity Waterproof DS18B20',
    'Turbidity' => 'DFRobot Gravity Analog Turbidity Sensor',
    _ => 'YF-S201 Water Flow Sensor',
  };
  String get _asset => switch (_sensor.name) {
    'pH level' => 'assets/figma/sensor_ph.png',
    'TDS' => 'assets/figma/sensor_tds.png',
    'Temperature' => 'assets/figma/sensor_temperature.png',
    'Turbidity' => 'assets/figma/sensor_turbidity.png',
    _ => 'assets/figma/sensor_water_flow.png',
  };
  String get _change => switch (_sensor.name) {
    'pH level' => '↓ 2.6',
    'TDS' => '↓ 22 ppm',
    'Temperature' => '↓ 1.2 °C',
    'Turbidity' => '↓ 1.3 NTU',
    _ => '↓ 2 L/min',
  };

  @override
  Widget build(BuildContext context) {
    return DetailScaffold(
      title: _sensorTitle,
      trailing: IconButton(
        tooltip: 'About ${_sensor.name}',
        onPressed: _showGuide,
        icon: const Icon(
          Icons.lightbulb_outline_rounded,
          color: AppColors.accent,
        ),
      ),
      children: [
        Text(
          _modelName,
          style: const TextStyle(
            fontSize: 24,
            height: 1.15,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 215,
          child: Image.asset(
            _asset,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Center(
              child: Icon(_sensor.icon, size: 120, color: _sensor.color),
            ),
          ),
        ),
        Row(
          children: [
            const Expanded(
              child: Text(
                'Real-time Monitoring',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            TextButton(
              onPressed: _showStatus,
              child: const Text('Sensor Status'),
            ),
          ],
        ),
        surfaceCard(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
          child: Row(
            children: [
              Expanded(
                child: _SensorComparison(
                  title: 'Pre-Filtration',
                  value: _sensor.value,
                ),
              ),
              const SizedBox(height: 40, child: VerticalDivider()),
              Expanded(
                child: _SensorComparison(
                  title: 'Post-Filtration',
                  value: _sensor.postValue,
                ),
              ),
              const SizedBox(height: 40, child: VerticalDivider()),
              Expanded(
                child: _SensorComparison(
                  title: 'Change',
                  value: _change,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        StageSwitch(
          postFiltration: _postFiltration,
          onChanged: (value) => setState(() => _postFiltration = value),
        ),
        const SizedBox(height: 10),
        surfaceCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _chartTitle,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  DropdownButton<String>(
                    value: _range,
                    underline: const SizedBox.shrink(),
                    items: const ['7 days', '30 days', '90 days']
                        .map(
                          (range) => DropdownMenuItem(
                            value: range,
                            child: Text(range),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) setState(() => _range = value);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 225,
                child: TrendChart(
                  color: const Color(0xFFCA39E3),
                  elevated: !_postFiltration,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (final day in const [
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat',
                    'Sun',
                  ])
                    Text(
                      day,
                      style: TextStyle(color: AppColors.muted, fontSize: 10),
                    ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        surfaceCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Statistical Summary',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  Expanded(
                    child: _SummaryValue(
                      value: _sensor.value,
                      label: 'Average Reading',
                    ),
                  ),
                  Expanded(
                    child: _SummaryValue(
                      value: _reading,
                      label: 'Median Reading',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _SummaryValue(
                      value: _sensor.range,
                      label: 'Reference Range',
                    ),
                  ),
                  Expanded(
                    child: _SummaryValue(value: _range, label: 'Period'),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        surfaceCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _sensor.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _sensor.description,
                style: TextStyle(color: AppColors.muted, height: 1.45),
              ),
              const SizedBox(height: 12),
              Text(
                '${_postFiltration ? 'Post' : 'Pre'}-filtration reading: $_reading',
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

  String get _chartTitle => switch (_sensor.name) {
    'pH level' => 'pH Level Chart',
    'TDS' => 'TDS Level Chart (ppm)',
    'Temperature' => 'Temperature Level Chart (°C)',
    'Turbidity' => 'Turbidity Level Chart (NTU)',
    _ => 'Water Flow Chart (L/min)',
  };

  void _showGuide() {
    showDialog<void>(
      context: context,
      builder: (context) => _SensorGuideDialog(sensor: _sensor),
    );
  }

  void _showStatus() {
    showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: AppColors.surface,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 16, 22, 22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  tooltip: 'Close status',
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                ),
              ),
              const Icon(
                Icons.sensors_rounded,
                size: 54,
                color: AppColors.accent,
              ),
              const SizedBox(height: 8),
              const Text(
                'Sensor Status',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 18),
              _StatusLine(label: 'Sensor Status', value: 'Operational'),
              _StatusLine(label: 'Connection', value: 'Connected'),
              _StatusLine(label: 'Data Status', value: 'Receiving'),
              _StatusLine(label: 'Last reading', value: '2 min ago'),
            ],
          ),
        ),
      ),
    );
  }
}

class _SensorComparison extends StatelessWidget {
  const _SensorComparison({
    required this.title,
    required this.value,
    this.color,
  });

  final String title;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: AppColors.muted, fontSize: 10),
      ),
      const SizedBox(height: 8),
      Text(
        value,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: color ?? AppColors.foreground,
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );
}

class _SummaryValue extends StatelessWidget {
  const _SummaryValue({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        value,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
      ),
      const SizedBox(height: 3),
      Text(label, style: TextStyle(color: AppColors.muted, fontSize: 11)),
    ],
  );
}

class _StatusLine extends StatelessWidget {
  const _StatusLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Expanded(
          child: Text('$label:', style: TextStyle(color: AppColors.muted)),
        ),
        Text(value),
      ],
    ),
  );
}

class _SensorGuideDialog extends StatefulWidget {
  const _SensorGuideDialog({required this.sensor});

  final SensorReading sensor;

  @override
  State<_SensorGuideDialog> createState() => _SensorGuideDialogState();
}

class _SensorGuideDialogState extends State<_SensorGuideDialog> {
  int _page = 0;

  String get _title => switch (widget.sensor.name) {
    'pH level' => 'pH',
    'TDS' => 'TDS',
    'Water flow' => 'Water Flow',
    _ => widget.sensor.name,
  };

  List<String> get _pages => [
    switch (widget.sensor.name) {
      'pH level' => 'pH measures how acidic or alkaline the water is.',
      'TDS' => 'TDS is the amount of dissolved salts and minerals in water.',
      'Temperature' =>
        'Temperature measures how warm or cool the water is, in °C.',
      'Turbidity' =>
        'Turbidity measures water cloudiness caused by suspended particles.',
      _ => 'Flow rate is the volume of water passing through a pipe per unit of time.',
    },
    switch (widget.sensor.name) {
      'pH level' => 'pH can affect treatment processes and other water-quality measurements.',
      'TDS' => 'High TDS can affect taste and cause mineral buildup.',
      'Temperature' =>
        'Warmer water can affect taste and encourage microbial growth.',
      'Turbidity' =>
        'Particles can shelter microbes and make disinfection less effective.',
      _ => 'Tracking flow helps monitor water use. Changes may signal leaks or a clogged filter.',
    },
    switch (widget.sensor.name) {
      'pH level' => 'Ideal level set by PNSDW\n6.5 – 8.5',
      'TDS' => 'Maximum set by PNSDW 2017\n500 mg/L',
      'Turbidity' => 'Maximum set by PNSDW 2017\n5 NTU',
      'Temperature' => 'Temperature limit in PNSDW 2017\nNo limit specified.',
      _ => 'Flow-rate target\nSee the configured system range.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isLast = _page == _pages.length - 1;
    return Dialog(
      backgroundColor: AppColors.surface,
      insetPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: SizedBox(
        width: 366,
        height: 440,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
              child: Column(
                children: [
                  Container(
                    height: 170,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D3636),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      'assets/figma/water_lab_illustration.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'About $_title',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    _page == 0
                        ? 'What is $_title?'
                        : _page == 1
                        ? 'Why does it matter?'
                        : 'Reference Range',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Center(
                      child: Text(
                        _pages[_page],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14, height: 1.4),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 280,
                    child: PrimaryButton(
                      label: isLast ? 'Close' : 'Next →',
                      onPressed: () {
                        if (isLast) {
                          Navigator.pop(context);
                        } else {
                          setState(() => _page++);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                tooltip: 'Close guide',
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close_rounded, size: 18),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.background,
                  minimumSize: const Size(32, 32),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
