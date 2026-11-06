import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/navigation_helpers.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final _pageController = PageController(viewportFraction: .84);
  int _currentStage = 0;

  static const _stages = [
    'Coconut Husk Fiber',
    'Coconut Shell Granular Activated Carbon',
    'Rice Husk Biochar',
    'Sand',
    'Gravel',
  ];
  static const _purposes = [
    'Traps larger particles, dirt, and suspended solids',
    'Helps reduce odor, color, and some dissolved compounds',
    'Provides an additional adsorption layer',
    'Captures finer suspended particles',
    'Supports the filter bed and catches coarse debris',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Filtration',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
                  ),
                ),
                IconButton(
                  tooltip: 'Filtration guide',
                  onPressed: () => showDialog<void>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Filtration Guide'),
                      content: const Text(
                        'Swipe through the filter media to review their role in the prototype.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  ),
                  icon: const Icon(
                    Icons.lightbulb_outline,
                    color: AppColors.accent,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.surface,
                  ),
                ),
              ],
            ),
            Text(
              'Stage ${_currentStage + 1} of ${_stages.length}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            SizedBox(
              height: 258,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _stages.length,
                onPageChanged: (index) => setState(() => _currentStage = index),
                itemBuilder: (context, index) => Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: Icon(
                        _mediaIcon(index),
                        size: 138,
                        color: AppColors.accent.withValues(alpha: .72),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton.filledTonal(
                        tooltip: 'Previous filter stage',
                        onPressed: index == 0
                            ? null
                            : () => _pageController.previousPage(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeOut,
                              ),
                        icon: const Icon(Icons.chevron_left),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton.filledTonal(
                        tooltip: 'Next filter stage',
                        onPressed: index == _stages.length - 1
                            ? null
                            : () => _pageController.nextPage(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeOut,
                              ),
                        icon: const Icon(Icons.chevron_right),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _stages[_currentStage],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 48),
            surfaceCard(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'Purpose',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _purposes[_currentStage],
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 12, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 95,
                    child: VerticalDivider(color: Color(0xFF596060)),
                  ),
                  const Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Filtration Type',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Mechanical Filtration',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _mediaIcon(int index) => switch (index) {
    0 => Icons.grass_rounded,
    1 => Icons.bubble_chart_outlined,
    2 => Icons.eco_outlined,
    3 => Icons.grain_rounded,
    _ => Icons.stacked_bar_chart_rounded,
  };
}
