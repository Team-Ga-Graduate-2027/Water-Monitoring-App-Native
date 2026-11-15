import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';
import '../widgets/navigation_helpers.dart';
import 'filter_history_screen.dart';
import 'notifications_screen.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final _pageController = PageController();
  int _currentIndex = 0;

  static const _materials = [
    _FilterMaterial(
      name: 'Coconut Husk Fiber',
      asset: 'assets/figma/filter_coconut_husk.png',
      stage: 1,
      purpose: 'Traps larger particles, dirt, and suspended solids.',
      type: 'Mechanical Filtration',
      what: 'A natural fibrous material derived from coconut husks.',
      why: 'It provides an initial filtration layer before water moves to the next stage.',
    ),
    _FilterMaterial(
      name: 'Coconut Shell Granular Activated Carbon',
      asset: 'assets/figma/filter_coconut_carbon.png',
      stage: 2,
      purpose: 'Helps reduce odors, color, and certain dissolved compounds.',
      type: 'Adsorption',
      what: 'Activated carbon produced from coconut shells and processed to develop a porous structure.',
      why: 'It can help reduce odors, color, and certain organic compounds.',
    ),
    _FilterMaterial(
      name: 'Rice Husk Biochar',
      asset: 'assets/figma/filter_rice_biochar.png',
      stage: 2,
      purpose: 'Helps adsorb dissolved contaminants and organic matter.',
      type: 'Adsorption',
      what: 'A carbon-rich material produced by heating rice husk under limited oxygen conditions.',
      why: 'It can contribute to removing certain dissolved contaminants and organic matter.',
    ),
    _FilterMaterial(
      name: 'Sand',
      asset: 'assets/figma/filter_sand.png',
      stage: 3,
      purpose: 'Removes suspended particles and fine sediment.',
      type: 'Mechanical Filtration',
      what: 'A granular filtration medium used to physically filter water.',
      why: 'It helps reduce suspended particles and fine sediment.',
    ),
    _FilterMaterial(
      name: 'Gravel',
      asset: 'assets/figma/filter_gravel.png',
      stage: 3,
      purpose: 'Traps larger particles and supports the filtration layer.',
      type: 'Coarse Filtration',
      what: 'A coarse granular material used as part of the filtration bed.',
      why: 'It provides coarse filtration and supports the other filtration layers.',
    ),
  ];

  _FilterMaterial get _current => _materials[_currentIndex];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _openGuide() {
    showDialog<void>(
      context: context,
      builder: (context) => _MaterialGuideDialog(material: _current),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(
              onNotifications: () =>
                  pushPage(context, const NotificationsScreen()),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
                children: [
                  Row(
                    children: [
                      const Expanded(child: SectionTitle('Filtration')),
                      IconButton(
                        tooltip: 'About ${_current.name}',
                        onPressed: _openGuide,
                        icon: const Icon(
                          Icons.lightbulb_outline_rounded,
                          color: AppColors.accent,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.surface,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Stage ${_current.stage} of 3',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 236,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _materials.length,
                      onPageChanged: (index) =>
                          setState(() => _currentIndex = index),
                      itemBuilder: (context, index) => Stack(
                        alignment: Alignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 34),
                            child: Image.asset(
                              _materials[index].asset,
                              width: double.infinity,
                              height: 210,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                    Icons.filter_alt_rounded,
                                    size: 120,
                                    color: AppColors.accent.withValues(
                                      alpha: .72,
                                    ),
                                  ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton.filledTonal(
                              tooltip: 'Previous filter medium',
                              onPressed: index == 0
                                  ? null
                                  : () => _pageController.previousPage(
                                      duration: const Duration(
                                        milliseconds: 250,
                                      ),
                                      curve: Curves.easeOut,
                                    ),
                              icon: const Icon(Icons.chevron_left_rounded),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton.filledTonal(
                              tooltip: 'Next filter medium',
                              onPressed: index == _materials.length - 1
                                  ? null
                                  : () => _pageController.nextPage(
                                      duration: const Duration(
                                        milliseconds: 250,
                                      ),
                                      curve: Curves.easeOut,
                                    ),
                              icon: const Icon(Icons.chevron_right_rounded),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    _current.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 32),
                  surfaceCard(
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 12,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _FilterFact(
                            title: 'Purpose',
                            description: _current.purpose,
                          ),
                        ),
                        SizedBox(
                          height: 96,
                          child: VerticalDivider(color: AppColors.headerBorder),
                        ),
                        Expanded(
                          child: _FilterFact(
                            title: 'Filtration Type',
                            description: _current.type,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  const SectionTitle('Filtration Insights'),
                  const SizedBox(height: 8),
                  _FilterHistoryLink(
                    icon: Icons.build_outlined,
                    title: 'Maintenance History',
                    subtitle: 'Review filter maintenance records',
                    onTap: () =>
                        pushPage(context, const MaintenanceHistoryScreen()),
                  ),
                  const SizedBox(height: 9),
                  _FilterHistoryLink(
                    icon: Icons.show_chart_rounded,
                    title: 'Filtration History',
                    subtitle: 'View filtration reports and parameters',
                    onTap: () =>
                        pushPage(context, const FiltrationHistoryScreen()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterMaterial {
  const _FilterMaterial({
    required this.name,
    required this.asset,
    required this.stage,
    required this.purpose,
    required this.type,
    required this.what,
    required this.why,
  });

  final String name;
  final String asset;
  final int stage;
  final String purpose;
  final String type;
  final String what;
  final String why;
}

class _FilterFact extends StatelessWidget {
  const _FilterFact({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6),
    child: Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12, height: 1.4),
        ),
      ],
    ),
  );
}

class _FilterHistoryLink extends StatelessWidget {
  const _FilterHistoryLink({
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
  Widget build(BuildContext context) => Material(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(12),
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        child: Row(
          children: [
            Icon(icon, color: AppColors.accent),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 15)),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: TextStyle(color: AppColors.muted, fontSize: 11),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: AppColors.foreground),
          ],
        ),
      ),
    ),
  );
}

class _MaterialGuideDialog extends StatefulWidget {
  const _MaterialGuideDialog({required this.material});

  final _FilterMaterial material;

  @override
  State<_MaterialGuideDialog> createState() => _MaterialGuideDialogState();
}

class _MaterialGuideDialogState extends State<_MaterialGuideDialog> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    final isLastPage = _page == 1;
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
                  const SizedBox(height: 12),
                  Text(
                    widget.material.name,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    _page == 0 ? 'What is it?' : 'Why is it used?',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Center(
                      child: Text(
                        '•  ${_page == 0 ? widget.material.what : widget.material.why}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14, height: 1.4),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 280,
                    child: PrimaryButton(
                      label: isLastPage ? 'Close' : 'Next →',
                      onPressed: () {
                        if (isLastPage) {
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
