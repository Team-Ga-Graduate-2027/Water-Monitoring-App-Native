import 'package:flutter/material.dart';

import '../widgets/app_widgets.dart';
import 'home_screen.dart';
import 'filter_screen.dart';
import 'sensors_screen.dart';
import 'settings_screen.dart';

class DashboardShell extends StatefulWidget {
  const DashboardShell({super.key});

  @override
  State<DashboardShell> createState() => _DashboardShellState();
}

class _DashboardShellState extends State<DashboardShell> {
  int _selectedIndex = 0;

  void _selectTab(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(
        onSeeSensors: () => Navigator.of(
          context,
        ).push(MaterialPageRoute<void>(builder: (_) => const SensorsScreen())),
      ),
      const FilterScreen(),
      const SettingsScreen(),
    ];
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: IndexedStack(index: _selectedIndex, children: pages),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onSelected: _selectTab,
      ),
    );
  }
}
