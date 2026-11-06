import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';
import 'dashboard_shell.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 1400), _openOnboarding);
  }

  void _openOnboarding() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const OnboardingScreen()),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.water_drop_outlined,
              size: 96,
              color: Colors.white,
            ),
            const SizedBox(height: 14),
            const Text(
              'Salin-Suri',
              style: TextStyle(fontSize: 38, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: _openOnboarding,
              child: const Text(
                'Continue',
                style: TextStyle(color: AppColors.muted),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;

  static const _slides = [
    (
      icon: Icons.link_rounded,
      title: 'Check Connection',
      description: 'Connect Salin-Suri in the embedded water-quality monitoring system and access sensor readings from your device.',
    ),
    (
      icon: Icons.bar_chart_rounded,
      title: 'Monitor Parameters',
      description: 'View sensor measurements including pH, temperature, turbidity, TDS, and other supported parameters.',
    ),
    (
      icon: Icons.show_chart_rounded,
      title: 'Track Changes',
      description: 'Explore historical readings and compare measurements with configured reference ranges.',
    ),
  ];

  void _finish() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const DashboardShell()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 8, 22, 19),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (page) => setState(() => _page = page),
                  itemCount: _slides.length,
                  itemBuilder: (context, index) {
                    final slide = _slides[index];
                    return Column(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Center(
                            child: index == 1
                                ? const _MeasurementPreview()
                                : index == 2
                                ? const _HistoryPreview()
                                : Icon(
                                    slide.icon,
                                    size: 112,
                                    color: const Color(0xFF8DAAFF),
                                  ),
                          ),
                        ),
                        Text(
                          slide.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 34,
                            height: 1.1,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 23),
                        Text(
                          slide.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18, height: 1.2),
                        ),
                        const Spacer(flex: 2),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _slides.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: index == _page ? 39 : 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: index == _page
                          ? AppColors.accent
                          : AppColors.surface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 82),
              PrimaryButton(
                label: _page == _slides.length - 1 ? 'Get Started' : 'Next',
                onPressed: () {
                  if (_page == _slides.length - 1) {
                    _finish();
                  } else {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 280),
                      curve: Curves.easeOut,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MeasurementPreview extends StatelessWidget {
  const _MeasurementPreview();

  @override
  Widget build(BuildContext context) {
    const readings = [
      ('Pre-Filtration', 'Post Filtration', 'Change', '7.3', '9.8', '↑ 2.5'),
      ('Pre-Filtration', 'Post Filtration', 'Change', '9.8', '7.2', '↓ 2.6'),
      ('Pre-Filtration', 'Post Filtration', 'Change', '9.3', '7.2', '↓ 2.1'),
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: readings.map((reading) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              _PreviewValue(title: reading.$1, value: reading.$4),
              _PreviewValue(title: reading.$2, value: reading.$5),
              _PreviewValue(
                title: reading.$3,
                value: reading.$6,
                color: reading.$6.startsWith('↑')
                    ? AppColors.danger
                    : AppColors.accent,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _PreviewValue extends StatelessWidget {
  const _PreviewValue({
    required this.title,
    required this.value,
    this.color = Colors.white,
  });

  final String title;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 10),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    ),
  );
}

class _HistoryPreview extends StatelessWidget {
  const _HistoryPreview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      width: double.infinity,
      child: CustomPaint(painter: _PreviewChartPainter()),
    );
  }
}

class _PreviewChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const valuesA = [.78, .65, .42, .51, .28, .36, .18];
    const valuesB = [.88, .52, .69, .81, .37, .44, .26];
    final grid = Paint()
      ..color = Colors.white.withValues(alpha: .2)
      ..strokeWidth = 1;
    for (var index = 0; index < 4; index++) {
      final y = size.height * (index + 1) / 5;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
    for (final (values, color) in [
      (valuesA, const Color(0xFFFF271F)),
      (valuesB, const Color(0xFF63D78A)),
    ]) {
      final path = Path();
      for (var index = 0; index < values.length; index++) {
        final point = Offset(
          size.width * index / (values.length - 1),
          size.height * values[index],
        );
        if (index == 0) {
          path.moveTo(point.dx, point.dy);
        } else {
          path.lineTo(point.dx, point.dy);
        }
      }
      canvas.drawPath(
        path,
        Paint()
          ..color = color
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke
          ..strokeJoin = StrokeJoin.round
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
