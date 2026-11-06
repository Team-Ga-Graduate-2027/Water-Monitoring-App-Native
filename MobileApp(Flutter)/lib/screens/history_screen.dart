import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';
import '../widgets/navigation_helpers.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool _postFiltration = true;
  String _range = '7 days';
  bool _guideExpanded = false;

  @override
  Widget build(BuildContext context) {
    final value = _postFiltration ? '7.2' : '9.8';
    return Column(
      children: [
        ScreenHeader(
          title: 'pH Level History',
          onBack: () => Navigator.maybePop(context),
          trailing: IconButton(
            tooltip: 'pH guide',
            onPressed: () => setState(() => _guideExpanded = !_guideExpanded),
            icon: const Icon(
              Icons.lightbulb_outline,
              color: AppColors.accent,
              size: 19,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
            children: [
              StageSwitch(
                postFiltration: _postFiltration,
                onChanged: (value) => setState(() => _postFiltration = value),
              ),
              const SizedBox(height: 16),
              surfaceCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _postFiltration
                                ? 'Post-Filtration'
                                : 'Pre-filtration',
                            style: const TextStyle(
                              color: AppColors.muted,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            value,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 42,
                      child: VerticalDivider(color: Color(0xFF596060)),
                    ),
                    const Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Reference Range',
                            style: TextStyle(
                              color: AppColors.muted,
                              fontSize: 10,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text('6.5 - 8.5', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 42,
                      child: VerticalDivider(color: Color(0xFF596060)),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Range',
                          style: TextStyle(
                            color: AppColors.muted,
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.circle,
                              color: AppColors.accent,
                              size: 7,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Within Range',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
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
                        DropdownButton<String>(
                          value: _range,
                          underline: const SizedBox.shrink(),
                          items: const ['7 days', '30 days', '90 days']
                              .map(
                                (range) => DropdownMenuItem(
                                  value: range,
                                  child: Text(
                                    range,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (range) {
                            if (range != null) setState(() => _range = range);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 230,
                      child: TrendChart(
                        color: const Color(0xFFCA39E3),
                        elevated: !_postFiltration,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Mon',
                          style: TextStyle(
                            color: AppColors.muted,
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          'Tue',
                          style: TextStyle(
                            color: AppColors.muted,
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          'Wed',
                          style: TextStyle(
                            color: AppColors.muted,
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          'Thu',
                          style: TextStyle(
                            color: AppColors.muted,
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          'Fri',
                          style: TextStyle(
                            color: AppColors.muted,
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          'Sat',
                          style: TextStyle(
                            color: AppColors.muted,
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          'Sun',
                          style: TextStyle(
                            color: AppColors.muted,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'pH Level Guide',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
              ),
              InkWell(
                onTap: () => setState(() => _guideExpanded = !_guideExpanded),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF519AF5),
                            width: 2,
                          ),
                        ),
                        child: const Center(
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: Color(0xFF519AF5),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        value,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Neutral', style: TextStyle(fontSize: 14)),
                            Text(
                              'Neither acidic nor alkaline',
                              style: TextStyle(fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        _guideExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                      ),
                    ],
                  ),
                ),
              ),
              if (_guideExpanded) ...[
                for (final (label, description) in [
                  ('6.0', 'Slightly Acidic'),
                  ('7.0', 'Neutral'),
                  ('8.0', 'Slightly Alkaline'),
                  ('9.0', 'Alkaline'),
                  ('10.0', 'Strongly Alkaline'),
                ])
                  Padding(
                    padding: const EdgeInsets.fromLTRB(64, 8, 8, 8),
                    child: Row(
                      children: [
                        Text(label, style: const TextStyle(fontSize: 18)),
                        const SizedBox(width: 14),
                        Text(description),
                      ],
                    ),
                  ),
              ],
              const SizedBox(height: 12),
              Text(
                'Current sample: $value pH · $_range',
                style: const TextStyle(color: AppColors.muted, fontSize: 11),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
