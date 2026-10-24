import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminGeneralPreferencesScreen extends StatefulWidget {
  final String? initialCurrency;
  final String? initialLanguage;
  final String? initialTimeZone;
  final String? initialDateFormat;
  final int? initialTimeFormat;
  final int? initialThemeMode;
  final String? initialDashboardPeriod;
  final Function(Map<String, dynamic> updatedPreferences)? onSave;

  const AdminGeneralPreferencesScreen({
    super.key,
    this.initialCurrency,
    this.initialLanguage,
    this.initialTimeZone,
    this.initialDateFormat,
    this.initialTimeFormat,
    this.initialThemeMode,
    this.initialDashboardPeriod,
    this.onSave,
  });

  @override
  State<AdminGeneralPreferencesScreen> createState() => _AdminGeneralPreferencesScreenState();
}

class _AdminGeneralPreferencesScreenState extends State<AdminGeneralPreferencesScreen> {
  final Color brandColor = const Color(0xFFFF5622);

  late String _currency;
  late String _language;
  late String _timeZone;
  late String _dateFormat;
  late int _timeFormat;
  late int _themeMode;
  late String _dashboardPeriod;

  bool _isSaving = false;
  bool _hasUnsavedChanges = false;

  final List<String> _currencies = [
    'PHP — Philippine Peso (₱)',
    'USD — US Dollar (\$)',
  ];

  final List<String> _languages = [
    'English',
    'Filipino / Tagalog',
  ];

  final List<String> _timeZones = [
    'Philippine Time (Asia/Manila, UTC+8)',
    'Coordinated Universal Time (UTC)',
  ];

  final List<String> _dateFormats = [
    'DD/MM/YYYY  ·  25/10/2026',
    'MM/DD/YYYY  ·  10/25/2026',
    'YYYY-MM-DD  ·  2026-10-25',
  ];

  final List<String> _dashboardPeriods = [
    'Today',
    'This Week',
    'This Month',
  ];

  final List<Map<String, String>> _themeOptions = [
    {'title': 'System Default', 'subtitle': 'follows device settings'},
    {'title': 'Light Mode', 'subtitle': 'bright & high contrast'},
    {'title': 'Dark Mode', 'subtitle': 'dark background'},
  ];

  @override
  void initState() {
    super.initState();
    _currency = widget.initialCurrency ?? 'PHP — Philippine Peso (₱)';
    _language = widget.initialLanguage ?? 'English';
    _timeZone = widget.initialTimeZone ?? 'Philippine Time (Asia/Manila, UTC+8)';
    _dateFormat = widget.initialDateFormat ?? 'DD/MM/YYYY  ·  25/10/2026';
    _timeFormat = widget.initialTimeFormat ?? 0;
    _themeMode = widget.initialThemeMode ?? 0;
    _dashboardPeriod = widget.initialDashboardPeriod ?? 'Today';
  }

  void _markChanged() {
    if (!_hasUnsavedChanges) {
      setState(() => _hasUnsavedChanges = true);
    }
  }

  Future<bool> _onWillPop() async {
    if (!_hasUnsavedChanges) return true;

    final shouldLeave = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Discard Unsaved Changes?',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16, color: const Color(0xFF0F172A)),
        ),
        content: Text(
          'You have unsaved changes to your general preferences. Do you want to discard them and exit?',
          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF475569)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Keep Editing', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Discard & Exit', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ],
      ),
    );

    return shouldLeave ?? false;
  }

  void _showResetConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Reset Preferences to Defaults?',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16, color: const Color(0xFF0F172A)),
        ),
        content: Text(
          'Are you sure you want to reset all regional settings, appearance, and dashboard preferences back to platform defaults?',
          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF475569)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currency = 'PHP — Philippine Peso (₱)';
                _language = 'English';
                _timeZone = 'Philippine Time (Asia/Manila, UTC+8)';
                _dateFormat = 'DD/MM/YYYY  ·  25/10/2026';
                _timeFormat = 0;
                _themeMode = 0;
                _dashboardPeriod = 'Today';
                _hasUnsavedChanges = false;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Preferences reset to platform defaults.', style: GoogleFonts.poppins()),
                  backgroundColor: const Color(0xFF475569),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: brandColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Confirm Reset', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _saveChanges() async {
    setState(() => _isSaving = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    final updatedData = {
      'currency': _currency,
      'language': _language,
      'timeZone': _timeZone,
      'dateFormat': _dateFormat,
      'timeFormat': _timeFormat,
      'themeMode': _themeMode,
      'dashboardPeriod': _dashboardPeriod,
    };

    widget.onSave?.call(updatedData);

    setState(() {
      _isSaving = false;
      _hasUnsavedChanges = false;
    });

    _showSaveSuccessModal();
  }

  void _showSaveSuccessModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFECFDF5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check_circle_rounded, color: Color(0xFF10B981), size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Preferences Saved & Applied',
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                        ),
                        Text(
                          'Administrative settings updated for GoCrave Admin.',
                          style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    _buildSummaryRow('Currency', _currency.contains('USD') ? 'USD (\$)' : 'PHP (₱)'),
                    const Divider(height: 12, color: Color(0xFFE2E8F0)),
                    _buildSummaryRow('Language', _language),
                    const Divider(height: 12, color: Color(0xFFE2E8F0)),
                    _buildSummaryRow('Time Format', _timeFormat == 0 ? '12-hour (1:30 PM)' : '24-hour (13:30)'),
                    const Divider(height: 12, color: Color(0xFFE2E8F0)),
                    _buildSummaryRow('Theme', _themeOptions[_themeMode]['title']!),
                    const Divider(height: 12, color: Color(0xFFE2E8F0)),
                    _buildSummaryRow('Dashboard Period', _dashboardPeriod),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brandColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: Text('Continue', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
        Text(value, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
      ],
    );
  }

  String get _formattedPreviewOrderDate {
    if (_dateFormat.contains('MM/DD/YYYY')) return '10/25/2026';
    if (_dateFormat.contains('YYYY-MM-DD')) return '2026-10-25';
    return '25/10/2026';
  }

  String get _formattedPreviewLastUpdated {
    final time = _timeFormat == 0 ? '1:30 PM' : '13:30';
    return '$time · PHT (UTC+8)';
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_hasUnsavedChanges,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FC),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF0F172A), size: 18),
            onPressed: () async {
              if (await _onWillPop() && mounted) {
                Navigator.pop(context);
              }
            },
          ),
          title: Text(
            'General Preferences',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F172A),
            ),
          ),
          centerTitle: false,
          actions: [
            if (_hasUnsavedChanges)
              Container(
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFF59E0B)),
                ),
                child: Text(
                  'Unsaved Edits',
                  style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFFD97706)),
                ),
              ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Manage your regional settings, appearance, and dashboard defaults.',
                style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF64748B)),
              ),
              const SizedBox(height: 20),

              Text(
                '1. Regional Settings',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Platform Currency', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _currency,
                          isExpanded: true,
                          icon: Icon(Icons.keyboard_arrow_down_rounded, color: brandColor),
                          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                          onChanged: (String? val) {
                            if (val != null) {
                              setState(() => _currency = val);
                              _markChanged();
                            }
                          },
                          items: _currencies.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Controls the currency format shown in supported screens. Changing display currency must not automatically change stored transaction amounts.',
                      style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8), height: 1.4),
                    ),

                    const SizedBox(height: 18),

                    Text('System Language', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _language,
                          isExpanded: true,
                          icon: Icon(Icons.keyboard_arrow_down_rounded, color: brandColor),
                          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                          onChanged: (String? val) {
                            if (val != null) {
                              setState(() => _language = val);
                              _markChanged();
                            }
                          },
                          items: _languages.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'The selected language should apply throughout the app only when the translations are implemented.',
                      style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8), height: 1.4),
                    ),

                    const SizedBox(height: 18),

                    Text('Time Zone', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _timeZone,
                          isExpanded: true,
                          icon: Icon(Icons.keyboard_arrow_down_rounded, color: brandColor),
                          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                          onChanged: (String? val) {
                            if (val != null) {
                              setState(() => _timeZone = val);
                              _markChanged();
                            }
                          },
                          items: _timeZones.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    Text('Date Format', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _dateFormat,
                          isExpanded: true,
                          icon: Icon(Icons.keyboard_arrow_down_rounded, color: brandColor),
                          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                          onChanged: (String? val) {
                            if (val != null) {
                              setState(() => _dateFormat = val);
                              _markChanged();
                            }
                          },
                          items: _dateFormats.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    Text('Time Format', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() => _timeFormat = 0);
                                _markChanged();
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: _timeFormat == 0 ? brandColor : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    '12-hour — 1:30 PM',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: _timeFormat == 0 ? FontWeight.bold : FontWeight.w500,
                                      color: _timeFormat == 0 ? Colors.white : const Color(0xFF64748B),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() => _timeFormat = 1);
                                _markChanged();
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: _timeFormat == 1 ? brandColor : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    '24-hour — 13:30',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: _timeFormat == 1 ? FontWeight.bold : FontWeight.w500,
                                      color: _timeFormat == 1 ? Colors.white : const Color(0xFF64748B),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Text(
                '2. Appearance',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Choose the visual theme for the admin application.',
                style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
              ),
              const SizedBox(height: 12),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: List.generate(_themeOptions.length, (idx) {
                    final item = _themeOptions[idx];
                    final isSelected = _themeMode == idx;
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() => _themeMode = idx);
                            _markChanged();
                          },
                          borderRadius: BorderRadius.circular(22),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                            child: Row(
                              children: [
                                Icon(
                                  isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                                  color: isSelected ? brandColor : const Color(0xFF94A3B8),
                                  size: 22,
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['title']!,
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF0F172A),
                                        ),
                                      ),
                                      Text(
                                        item['subtitle']!,
                                        style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (idx < _themeOptions.length - 1)
                          const Divider(height: 1, color: Color(0xFFF1F5F9)),
                      ],
                    );
                  }),
                ),
              ),

              const SizedBox(height: 24),

              Text(
                '3. Dashboard Preferences',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Default Dashboard Period', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _dashboardPeriod,
                          isExpanded: true,
                          icon: Icon(Icons.keyboard_arrow_down_rounded, color: brandColor),
                          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                          onChanged: (String? val) {
                            if (val != null) {
                              setState(() => _dashboardPeriod = val);
                              _markChanged();
                            }
                          },
                          items: _dashboardPeriods.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Sets the initial reporting period when the dashboard opens, provided this option is supported.',
                      style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8), height: 1.4),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Text(
                '4. Display Preview',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'See how your selected currency, date format, and time format will appear in the app.',
                style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
              ),
              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: const Color(0xFFFFE0B2), width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.preview_rounded, color: brandColor, size: 20),
                        const SizedBox(width: 8),
                        Text('Sample Order Total', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF64748B))),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _currency.contains('USD') ? '\$2,500.00' : '₱2,500.00',
                      style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w900, color: const Color(0xFF0F172A)),
                    ),
                    const SizedBox(height: 14),
                    const Divider(height: 1, color: Color(0xFFFFE0B2)),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildPreviewDetail('Order Date', _formattedPreviewOrderDate),
                        _buildPreviewDetail('Last Updated', _formattedPreviewLastUpdated),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildPreviewDetail('Dashboard Period', _dashboardPeriod),
                        _buildPreviewDetail('Language', _language),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildPreviewDetail('Theme', _themeOptions[_themeMode]['title']!),
                    const SizedBox(height: 14),
                    Text(
                      'Sample data only. The preview updates with your selections and is not an actual GoCrave transaction.',
                      style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8), fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: OutlinedButton(
                        onPressed: _showResetConfirmationDialog,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF94A3B8), width: 1.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        child: Text(
                          'Reset to Defaults',
                          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF475569)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isSaving ? null : _saveChanges,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: brandColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          elevation: 0,
                        ),
                        child: _isSaving
                            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                            : Text(
                                'Save Changes',
                                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreviewDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
        Text(value, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
      ],
    );
  }
}
