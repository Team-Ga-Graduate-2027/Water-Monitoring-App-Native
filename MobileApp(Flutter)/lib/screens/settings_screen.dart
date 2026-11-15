import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';
import '../widgets/navigation_helpers.dart';
import 'notifications_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      AppHeader(
        onNotifications: () => pushPage(context, const NotificationsScreen()),
      ),
      Expanded(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 22, 16, 24),
          children: [
            _SettingsGroup(
              title: 'Device',
              description:
                  'Manage your device connection and hardware details.',
              items: [
                _SettingsOption(
                  title: 'Device Connection',
                  onTap: () => _showSettingsInfo(
                    context,
                    'Device Connection',
                    'Connection status: Connected\nData status: Receiving\nLast sample: 2 min ago',
                  ),
                ),
                _SettingsOption(
                  title: 'Device Information',
                  onTap: () => _showSettingsInfo(
                    context,
                    'Device Information',
                    'Salin-Suri water-quality monitoring prototype. Sensor data shown in this build is sample data.',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _SettingsGroup(
              title: 'App',
              description: 'Customize your app experience and preferences.',
              items: [
                _SettingsOption(
                  title: 'Dark Mode',
                  trailing: ValueListenableBuilder<ThemeMode>(
                    valueListenable: AppTheme.themeMode,
                    builder: (context, themeMode, _) => Switch.adaptive(
                      value: themeMode == ThemeMode.dark,
                      activeThumbColor: AppColors.accent,
                      activeTrackColor: AppColors.accent.withValues(alpha: .3),
                      onChanged: (value) {
                        AppTheme.themeMode.value = value
                            ? ThemeMode.dark
                            : ThemeMode.light;
                      },
                    ),
                  ),
                ),
                _SettingsOption(
                  title: 'Notifications',
                  trailing: ValueListenableBuilder<bool>(
                    valueListenable: AppTheme.notificationsEnabled,
                    builder: (context, enabled, _) => Switch.adaptive(
                      value: enabled,
                      activeThumbColor: AppColors.accent,
                      onChanged: (value) =>
                          AppTheme.notificationsEnabled.value = value,
                    ),
                  ),
                ),
                _SettingsOption(
                  title: 'About Salin-Suri',
                  onTap: () => _showSettingsInfo(
                    context,
                    'About Salin-Suri',
                    'A water-quality monitoring interface for reviewing sensor readings and filtration trends.',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _SettingsGroup(
              title: 'Support',
              description: 'Need help? Contact our team.',
              items: [
                _SettingsOption(
                  title: 'Help Center',
                  onTap: () => _showSettingsInfo(
                    context,
                    'Help Center',
                    'Use the Filter guide to learn about each media layer, and open a sensor insight for readings and reference information.',
                  ),
                ),
                _SettingsOption(
                  title: 'Contact Us',
                  onTap: () => _showSettingsInfo(
                    context,
                    'Contact Us',
                    'For support, contact the Salin-Suri project team through your project administrator.',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
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
      Text(description, style: TextStyle(color: AppColors.muted, fontSize: 13)),
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
  const _SettingsOption({required this.title, this.trailing, this.onTap});

  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 50,
    child: InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(child: Text(title, style: const TextStyle(fontSize: 14))),
          trailing ??
              Icon(Icons.chevron_right, color: AppColors.muted, size: 20),
        ],
      ),
    ),
  );
}

void _showSettingsInfo(BuildContext context, String title, String message) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}
