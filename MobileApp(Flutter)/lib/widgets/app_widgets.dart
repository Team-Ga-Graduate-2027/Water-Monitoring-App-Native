import 'package:flutter/material.dart';

import '../models/sensor_reading.dart';
import '../theme/app_theme.dart';
import 'navigation_helpers.dart';

class DetailScaffold extends StatelessWidget {
  const DetailScaffold({
    super.key,
    required this.title,
    required this.children,
    this.trailing,
  });

  final String title;
  final List<Widget> children;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        actions: trailing == null ? null : [trailing!],
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          children: children,
        ),
      ),
    );
  }
}

class AppHeader extends StatelessWidget {
  const AppHeader({super.key, this.onNotifications, this.showBack = false});

  final VoidCallback? onNotifications;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: const BoxDecoration(
        color: AppColors.header,
        border: Border(bottom: BorderSide(color: Color(0xFF3B3B3B))),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Text(
            'Salin-Suri',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          if (showBack)
            Positioned(
              left: 12,
              child: IconButton(
                tooltip: 'Back',
                onPressed: () => Navigator.maybePop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 19),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.surfaceRaised,
                  foregroundColor: AppColors.accent,
                ),
              ),
            ),
          if (onNotifications != null)
            Positioned(
              right: 12,
              child: IconButton(
                tooltip: 'Notifications',
                onPressed: onNotifications,
                icon: const Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(Icons.notifications_none_rounded),
                    Positioned(
                      top: 0,
                      right: -1,
                      child: CircleAvatar(
                        radius: 3,
                        backgroundColor: AppColors.danger,
                      ),
                    ),
                  ],
                ),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.surfaceRaised,
                  foregroundColor: AppColors.accent,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ScreenHeader extends StatelessWidget {
  const ScreenHeader({
    super.key,
    required this.title,
    this.onBack,
    this.trailing,
  });

  final String title;
  final VoidCallback? onBack;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: onBack == null
                ? null
                : IconButton(
                    tooltip: 'Back',
                    onPressed: onBack ?? () => Navigator.maybePop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                    ),
                  ),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            width: 40,
            child: trailing == null ? null : Center(child: trailing),
          ),
        ],
      ),
    );
  }
}

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    const destinations = [
      (icon: Icons.home_outlined, label: 'Home'),
      (icon: Icons.filter_alt_outlined, label: 'Filter'),
      (icon: Icons.settings_outlined, label: 'Settings'),
    ];
    return SafeArea(
      top: false,
      child: Container(
        height: 68,
        margin: const EdgeInsets.fromLTRB(28, 8, 28, 20),
        decoration: BoxDecoration(
          color: AppColors.header,
          border: Border.all(color: const Color(0xFF4A4A4A)),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          children: List.generate(destinations.length, (index) {
            final item = destinations[index];
            final selected = selectedIndex == index;
            return Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(40),
                onTap: () => onSelected(index),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item.icon,
                      color: selected ? AppColors.accent : Colors.white,
                      size: 28,
                    ),
                    if (selected) ...[
                      const SizedBox(height: 1),
                      Text(
                        item.label,
                        style: const TextStyle(
                          color: AppColors.accent,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class WaterMark extends StatelessWidget {
  const WaterMark({super.key, this.size = 40});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: .13),
        borderRadius: BorderRadius.circular(size * .34),
      ),
      child: Icon(
        Icons.water_drop_rounded,
        color: AppColors.accent,
        size: size * .58,
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) => Text(
    title,
    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
  );
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: const Color(0xFF102017),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onPressed,
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
      ),
    );
  }
}

class SensorCard extends StatelessWidget {
  const SensorCard({
    super.key,
    required this.sensor,
    required this.onTap,
    this.compact = false,
  });

  final SensorReading sensor;
  final VoidCallback onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(compact ? 12 : 16),
          child: compact
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceRaised,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            sensor.icon,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Text(
                      sensor.name == 'TDS'
                          ? 'TDS'
                          : sensor.name == 'pH level'
                          ? 'pH Level'
                          : sensor.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: sensor.color.withValues(alpha: .12),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Icon(sensor.icon, color: sensor.color, size: 21),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            sensor.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            sensor.value,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.muted,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class ReadingTile extends StatelessWidget {
  const ReadingTile({super.key, required this.sensor});

  final SensorReading sensor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceRaised,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(sensor.icon, size: 17, color: sensor.color),
          const SizedBox(width: 7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sensor.name,
                  style: const TextStyle(color: AppColors.muted, fontSize: 10),
                ),
                const SizedBox(height: 3),
                Text(
                  sensor.value,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StageSwitch extends StatelessWidget {
  const StageSwitch({
    super.key,
    required this.postFiltration,
    required this.onChanged,
  });

  final bool postFiltration;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        children: [
          StageButton(
            label: 'Pre-filtration',
            selected: !postFiltration,
            onTap: () => onChanged(false),
          ),
          StageButton(
            label: 'Post-filtration',
            selected: postFiltration,
            onTap: () => onChanged(true),
          ),
        ],
      ),
    );
  }
}

class StageButton extends StatelessWidget {
  const StageButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          decoration: BoxDecoration(
            color: selected ? AppColors.surfaceRaised : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected ? Colors.white : AppColors.muted,
              fontSize: 11,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class ConnectionPill extends StatelessWidget {
  const ConnectionPill({super.key, required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class InsightTile extends StatelessWidget {
  const InsightTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

class MiniStat extends StatelessWidget {
  const MiniStat({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceRaised,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.muted, fontSize: 10),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(color: color, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return surfaceCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.accent, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(color: AppColors.muted, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StageRow extends StatelessWidget {
  const StageRow({
    super.key,
    required this.number,
    required this.title,
    required this.subtitle,
    required this.active,
  });

  final String number;
  final String title;
  final String subtitle;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return surfaceCard(
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: active
                  ? AppColors.accent.withValues(alpha: .14)
                  : AppColors.surfaceRaised,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              number,
              style: TextStyle(
                color: active ? AppColors.accent : AppColors.muted,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(color: AppColors.muted, fontSize: 11),
                ),
              ],
            ),
          ),
          if (active)
            const Icon(Icons.check_circle, color: AppColors.accent, size: 20),
        ],
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.date,
    required this.color,
    required this.unread,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final String date;
  final Color color;
  final bool unread;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.surfaceRaised,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.error_outline_rounded,
                  color: color,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        if (unread)
                          Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                              color: AppColors.danger,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.white,
                        height: 1.4,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      date,
                      style: const TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GroupLabel extends StatelessWidget {
  const GroupLabel(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) => Text(
    label,
    style: const TextStyle(
      color: AppColors.muted,
      fontWeight: FontWeight.w800,
      fontSize: 10,
      letterSpacing: 1.5,
    ),
  );
}

class SettingsRow extends StatelessWidget {
  const SettingsRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
      child: Row(
        children: [
          Icon(icon, color: AppColors.accent, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: AppColors.muted, fontSize: 10),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}

class TrendChart extends StatelessWidget {
  const TrendChart({super.key, required this.color, this.elevated = false});

  final Color color;
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TrendChartPainter(color: color, elevated: elevated),
      child: const SizedBox.expand(),
    );
  }
}

class _TrendChartPainter extends CustomPainter {
  const _TrendChartPainter({required this.color, required this.elevated});

  final Color color;
  final bool elevated;

  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()
      ..color = Colors.white.withValues(alpha: .08)
      ..strokeWidth = 1;
    for (var index = 0; index < 4; index++) {
      final y = size.height * index / 3;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final points = elevated
        ? const [.72, .6, .69, .4, .52, .31, .45]
        : const [.55, .48, .57, .41, .5, .36, .44];
    final path = Path();
    for (var index = 0; index < points.length; index++) {
      final point = Offset(
        size.width * index / (points.length - 1),
        size.height * points[index],
      );
      if (index == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }

    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(
      fillPath,
      Paint()
        ..shader = LinearGradient(
          colors: [color.withValues(alpha: .2), color.withValues(alpha: 0)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Offset.zero & size),
    );
    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke,
    );
    for (var index = 0; index < points.length; index++) {
      final point = Offset(
        size.width * index / (points.length - 1),
        size.height * points[index],
      );
      canvas.drawCircle(point, 3.5, Paint()..color = color);
      canvas.drawCircle(
        point,
        6,
        Paint()
          ..color = color.withValues(alpha: .18)
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _TrendChartPainter oldDelegate) =>
      color != oldDelegate.color || elevated != oldDelegate.elevated;
}
