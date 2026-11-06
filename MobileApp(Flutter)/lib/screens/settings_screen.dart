import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';
import '../widgets/navigation_helpers.dart';
import 'notifications_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppHeader(
          onNotifications: () => pushPage(context, const NotificationsScreen()),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 22, 16, 24),
            children: [
              const _SettingsGroup(
                title: 'Device',
                description:
                    'Manage your device connection and view hardware details.',
                items: [
                  _SettingsOption(title: 'Device Connection'),
                  _SettingsOption(title: 'Device Information'),
                ],
              ),
              const SizedBox(height: 32),
              _SettingsGroup(
                title: 'App',
                description: 'Customize your app experience and preferences.',
                items: [
                  _SettingsOption(
                    title: 'Dark Mode',
                    trailing: Switch.adaptive(
                      value: _darkMode,
                      activeThumbColor: AppColors.accent,
                      activeTrackColor: AppColors.accent.withValues(alpha: .3),
                      onChanged: (value) => setState(() => _darkMode = value),
                    ),
                  ),
                  const _SettingsOption(
                    title: 'Notifications',
                    trailing: Icon(Icons.chevron_right, color: AppColors.muted),
                  ),
                  const _SettingsOption(
                    title: 'About Salin-Suri',
                    trailing: Icon(Icons.chevron_right, color: AppColors.muted),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const _SettingsGroup(
                title: 'Support',
                description: 'Need help? Contact our team.',
                items: [
                  _SettingsOption(title: 'Help Center'),
                  _SettingsOption(title: 'Contact Us'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({
    required this.title,
    required this.description,
    required this.items,
  });

  final String title;
  final String description;
  final List<Widget> items;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
      const SizedBox(height: 10),
      Text(
        description,
        style: const TextStyle(color: AppColors.muted, fontSize: 13),
      ),
      const SizedBox(height: 10),
      surfaceCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            for (var index = 0; index < items.length; index++) ...[
              if (index > 0) const Divider(height: 1),
              items[index],
            ],
          ],
        ),
      ),
    ],
  );
}

class _SettingsOption extends StatelessWidget {
  const _SettingsOption({required this.title, this.trailing});

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 50,
    child: Row(
      children: [
        Expanded(child: Text(title, style: const TextStyle(fontSize: 14))),
        trailing ??
            const Icon(Icons.chevron_right, color: AppColors.muted, size: 20),
      ],
    ),
  );
}
