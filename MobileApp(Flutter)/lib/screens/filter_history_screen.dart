import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';
import '../widgets/navigation_helpers.dart';

class FiltrationHistoryScreen extends StatefulWidget {
  const FiltrationHistoryScreen({super.key});

  @override
  State<FiltrationHistoryScreen> createState() =>
      _FiltrationHistoryScreenState();
}

class _FiltrationHistoryScreenState extends State<FiltrationHistoryScreen> {
  String _stage = 'All';
  String _range = '30 days';
  String _query = '';

  List<_FiltrationRecord> get _records {
    final cutoff = switch (_range) {
      '7 days' => DateTime(2026, 10, 20),
      '30 days' => DateTime(2026, 9, 27),
      '90 days' => DateTime(2026, 7, 29),
      _ => DateTime(2000),
    };
    return _sampleFiltrations.where((record) {
      final matchesStage = _stage == 'All' || record.stage == _stage;
      final matchesQuery =
          _query.isEmpty ||
          record.number.contains(_query) ||
          record.dateLabel.toLowerCase().contains(_query.toLowerCase());
      return matchesStage && matchesQuery && !record.date.isBefore(cutoff);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Back',
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 19),
        ),
        title: const Text('Filtration History'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
        children: [
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'All', label: Text('All')),
              ButtonSegment(value: 'Pre', label: Text('Pre')),
              ButtonSegment(value: 'Post', label: Text('Post')),
            ],
            selected: {_stage},
            showSelectedIcon: false,
            onSelectionChanged: (value) => setState(() => _stage = value.first),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (value) => setState(() => _query = value.trim()),
                  decoration: InputDecoration(
                    hintText: 'Search date or filtration number',
                    prefixIcon: const Icon(Icons.search_rounded, size: 20),
                    filled: true,
                    fillColor: AppColors.surface,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              PopupMenuButton<String>(
                tooltip: 'Filter by date range',
                initialValue: _range,
                onSelected: (value) => setState(() => _range = value),
                itemBuilder: (context) => const [
                  PopupMenuItem(value: '7 days', child: Text('7 days')),
                  PopupMenuItem(value: '30 days', child: Text('30 days')),
                  PopupMenuItem(value: '90 days', child: Text('90 days')),
                  PopupMenuItem(value: 'All dates', child: Text('All dates')),
                ],
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.tune_rounded, color: AppColors.accent),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_records.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 64),
              child: Center(
                child: Text(
                  'No filtration records match these filters.',
                  style: TextStyle(color: AppColors.muted),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          else
            for (final record in _records) ...[
              _HistoryRecordTile(
                title: 'Filtration #${record.number}',
                date: record.dateLabel,
                stage: '${record.stage}-Filtration',
                onTap: () => pushPage(
                  context,
                  FiltrationHistoryDetailsScreen(record: record),
                ),
              ),
              const SizedBox(height: 10),
            ],
        ],
      ),
    );
  }
}

class FiltrationHistoryDetailsScreen extends StatelessWidget {
  const FiltrationHistoryDetailsScreen({super.key, required this.record});

  final _FiltrationRecord record;

  @override
  Widget build(BuildContext context) => DetailScaffold(
    title: 'Filtration #${record.number}',
    children: [
      surfaceCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Monitoring Report',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
                Text(
                  record.dateLabel,
                  style: TextStyle(color: AppColors.muted, fontSize: 11),
                ),
              ],
            ),
            const Divider(height: 28),
            Wrap(
              runSpacing: 18,
              children: [
                _ReportValue(label: 'pH', value: record.ph),
                _ReportValue(label: 'Temperature', value: record.temperature),
                _ReportValue(label: 'Turbidity', value: record.turbidity),
                _ReportValue(label: 'TDS', value: record.tds),
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
            const Text(
              'Report Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            Text(
              '${record.stage}-filtration readings for Filtration #${record.number} were recorded on ${record.dateLabel}. Compare the measured values with the reference ranges configured for your monitoring setup.',
              style: TextStyle(color: AppColors.muted, height: 1.45),
            ),
            const SizedBox(height: 14),
            Text(
              'Readings are for monitoring and should be interpreted with the source-water conditions and applicable guidance.',
              style: TextStyle(color: AppColors.muted, fontSize: 11),
            ),
          ],
        ),
      ),
      const SizedBox(height: 24),
      PrimaryButton(
        label: 'Go Back to Monitoring Page',
        onPressed: () => Navigator.maybePop(context),
      ),
    ],
  );
}

class MaintenanceHistoryScreen extends StatefulWidget {
  const MaintenanceHistoryScreen({super.key});

  @override
  State<MaintenanceHistoryScreen> createState() =>
      _MaintenanceHistoryScreenState();
}

class _MaintenanceHistoryScreenState extends State<MaintenanceHistoryScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final records = _sampleMaintenance.where((record) {
      return _query.isEmpty ||
          record.number.contains(_query) ||
          record.date.toLowerCase().contains(_query.toLowerCase());
    });
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Back',
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 19),
        ),
        title: const Text('Maintenance History'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
        children: [
          TextField(
            onChanged: (value) => setState(() => _query = value.trim()),
            decoration: InputDecoration(
              hintText: 'Search date or maintenance number',
              prefixIcon: const Icon(Icons.search_rounded, size: 20),
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          for (final record in records) ...[
            _HistoryRecordTile(
              title: 'Maintenance #${record.number}',
              date: record.date,
              onTap: () => pushPage(
                context,
                MaintenanceHistoryDetailsScreen(record: record),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class MaintenanceHistoryDetailsScreen extends StatefulWidget {
  const MaintenanceHistoryDetailsScreen({super.key, required this.record});

  final _MaintenanceRecord record;

  @override
  State<MaintenanceHistoryDetailsScreen> createState() =>
      _MaintenanceHistoryDetailsScreenState();
}

class _MaintenanceHistoryDetailsScreenState
    extends State<MaintenanceHistoryDetailsScreen> {
  bool? _replacementCompleted;
  bool _submitted = false;

  @override
  Widget build(BuildContext context) => DetailScaffold(
    title: 'Maintenance #${widget.record.number}',
    children: [
      surfaceCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Maintenance Report',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const Divider(height: 28),
            Text(
              'This notification documents the need for review of filter materials based on post-filtration readings.',
              style: TextStyle(color: AppColors.muted, height: 1.45),
            ),
            const SizedBox(height: 12),
            Text(widget.record.date, style: TextStyle(color: AppColors.muted)),
          ],
        ),
      ),
      const SizedBox(height: 16),
      surfaceCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Maintenance Documentation',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const Divider(height: 28),
            Text(
              _submitted
                  ? 'Replacement status recorded.'
                  : 'Has the filter replacement been completed?',
              style: TextStyle(color: AppColors.muted),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              children: [
                ChoiceChip(
                  label: const Text('Yes'),
                  selected: _replacementCompleted == true,
                  onSelected: (selected) => setState(() {
                    _replacementCompleted = selected ? true : null;
                    _submitted = false;
                  }),
                ),
                ChoiceChip(
                  label: const Text('No'),
                  selected: _replacementCompleted == false,
                  onSelected: (selected) => setState(() {
                    _replacementCompleted = selected ? false : null;
                    _submitted = false;
                  }),
                ),
              ],
            ),
            if (_submitted) ...[
              const Divider(height: 24),
              Text(
                'Recorded at ${widget.record.date}',
                style: TextStyle(color: AppColors.muted, fontSize: 11),
              ),
            ] else ...[
              const SizedBox(height: 12),
              PrimaryButton(
                label: 'Submit',
                onPressed: _replacementCompleted == null
                    ? () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Choose Yes or No before submitting.'),
                        ),
                      )
                    : () => setState(() => _submitted = true),
              ),
            ],
          ],
        ),
      ),
      const SizedBox(height: 24),
      PrimaryButton(
        label: 'Go Back to Filter Page',
        onPressed: () => Navigator.maybePop(context),
      ),
    ],
  );
}

class _HistoryRecordTile extends StatelessWidget {
  const _HistoryRecordTile({
    required this.title,
    required this.date,
    required this.onTap,
    this.stage,
  });

  final String title;
  final String date;
  final String? stage;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(12),
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 10, 11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (stage != null)
                  Text(
                    stage!,
                    style: TextStyle(
                      color: stage == 'Pre-Filtration'
                          ? const Color(0xFF81AFFF)
                          : AppColors.accent,
                      fontSize: 10,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 7),
            Row(
              children: [
                Expanded(
                  child: Text(
                    date,
                    style: TextStyle(color: AppColors.muted, fontSize: 11),
                  ),
                ),
                if (stage != null)
                  Text(
                    'View Filtration Details →',
                    style: TextStyle(color: AppColors.accent, fontSize: 10),
                  )
                else
                  Icon(Icons.chevron_right, color: AppColors.foreground),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

class _ReportValue extends StatelessWidget {
  const _ReportValue({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 140,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: AppColors.muted, fontSize: 11)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
      ],
    ),
  );
}

class _FiltrationRecord {
  const _FiltrationRecord({
    required this.number,
    required this.date,
    required this.dateLabel,
    required this.stage,
    required this.ph,
    required this.temperature,
    required this.turbidity,
    required this.tds,
  });

  final String number;
  final DateTime date;
  final String dateLabel;
  final String stage;
  final String ph;
  final String temperature;
  final String turbidity;
  final String tds;
}

final _sampleFiltrations = [
  _FiltrationRecord(
    number: '129',
    date: DateTime(2026, 10, 26, 17, 15),
    dateLabel: '26/10/26, 5:15 pm',
    stage: 'Pre',
    ph: '8.5 pH',
    temperature: '26.2 °C',
    turbidity: '1.4 NTU',
    tds: '600 mg/L',
  ),
  _FiltrationRecord(
    number: '128',
    date: DateTime(2026, 10, 26, 17),
    dateLabel: '26/10/26, 5:00 pm',
    stage: 'Post',
    ph: '7.2 pH',
    temperature: '26.0 °C',
    turbidity: '0.8 NTU',
    tds: '180 mg/L',
  ),
  _FiltrationRecord(
    number: '127',
    date: DateTime(2026, 10, 26, 16, 45),
    dateLabel: '26/10/26, 4:45 pm',
    stage: 'Pre',
    ph: '9.8 pH',
    temperature: '27.0 °C',
    turbidity: '2.1 NTU',
    tds: '320 mg/L',
  ),
  _FiltrationRecord(
    number: '126',
    date: DateTime(2026, 10, 26, 16, 30),
    dateLabel: '26/10/26, 4:30 pm',
    stage: 'Post',
    ph: '7.3 pH',
    temperature: '26.4 °C',
    turbidity: '0.7 NTU',
    tds: '170 mg/L',
  ),
  _FiltrationRecord(
    number: '125',
    date: DateTime(2026, 10, 26, 16, 15),
    dateLabel: '26/10/26, 4:15 pm',
    stage: 'Post',
    ph: '7.1 pH',
    temperature: '26.1 °C',
    turbidity: '0.6 NTU',
    tds: '165 mg/L',
  ),
];

class _MaintenanceRecord {
  const _MaintenanceRecord({required this.number, required this.date});

  final String number;
  final String date;
}

const _sampleMaintenance = [
  _MaintenanceRecord(number: '136', date: '02/11/26, 4:55 pm'),
  _MaintenanceRecord(number: '135', date: '01/11/26, 11:10 am'),
  _MaintenanceRecord(number: '134', date: '31/10/26, 6:20 pm'),
  _MaintenanceRecord(number: '133', date: '30/10/26, 3:00 pm'),
  _MaintenanceRecord(number: '132', date: '29/10/26, 1:45 pm'),
  _MaintenanceRecord(number: '131', date: '28/10/26, 10:30 am'),
  _MaintenanceRecord(number: '130', date: '27/10/26, 8:00 am'),
  _MaintenanceRecord(number: '129', date: '26/10/26, 5:15 pm'),
];
