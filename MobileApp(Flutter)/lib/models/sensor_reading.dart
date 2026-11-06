import 'package:flutter/material.dart';

class SensorReading {
  const SensorReading({
    required this.name,
    required this.value,
    required this.postValue,
    required this.unit,
    required this.range,
    required this.description,
    required this.icon,
    required this.color,
  });

  final String name;
  final String value;
  final String postValue;
  final String unit;
  final String range;
  final String description;
  final IconData icon;
  final Color color;

  SensorReading copyWith({String? value}) => SensorReading(
    name: name,
    value: value ?? this.value,
    postValue: postValue,
    unit: unit,
    range: range,
    description: description,
    icon: icon,
    color: color,
  );
}

const sampleSensorReadings = [
  SensorReading(
    name: 'Temperature',
    value: '29.6 °C',
    postValue: '28.4 °C',
    unit: '°C',
    range: 'Typically 20–30 °C',
    description: 'Tracks water temperature at the monitoring point.',
    icon: Icons.thermostat_rounded,
    color: Color(0xFFFFB86B),
  ),
  SensorReading(
    name: 'pH level',
    value: '9.8',
    postValue: '7.2',
    unit: 'pH',
    range: '6.5–8.5',
    description: 'Indicates how acidic or alkaline a water sample is.',
    icon: Icons.science_outlined,
    color: Color(0xFF76CE98),
  ),
  SensorReading(
    name: 'Turbidity',
    value: '2.1 NTU',
    postValue: '0.8 NTU',
    unit: 'NTU',
    range: 'Prototype target under 1.0 NTU',
    description: 'Estimates how cloudy water is due to suspended particles.',
    icon: Icons.water_outlined,
    color: Color(0xFF7BC8F6),
  ),
  SensorReading(
    name: 'TDS',
    value: '118 ppm',
    postValue: '96 ppm',
    unit: 'ppm',
    range: 'Context depends on source and use',
    description: 'Measures the concentration of dissolved substances in water.',
    icon: Icons.bubble_chart_outlined,
    color: Color(0xFFC19AFF),
  ),
  SensorReading(
    name: 'Water flow',
    value: '18 L/min',
    postValue: '16 L/min',
    unit: 'L/min',
    range: 'Prototype expected minimum 20 L/min',
    description: 'Tracks the volume of water passing through the system.',
    icon: Icons.waves_rounded,
    color: Color(0xFFFF8FA3),
  ),
];
