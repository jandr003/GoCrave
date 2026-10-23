import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminGeneralPreferencesScreen extends StatefulWidget {
  const AdminGeneralPreferencesScreen({super.key});

  @override
  State<AdminGeneralPreferencesScreen> createState() => _AdminGeneralPreferencesScreenState();
}

class _AdminGeneralPreferencesScreenState extends State<AdminGeneralPreferencesScreen> {
  final Color brandColor = const Color(0xFFFF5622);

  String _selectedCurrency = 'Philippine Peso (PHP ₱)';
  String _selectedLanguage = 'English';
  String _selectedDateFormat = 'DD/MM/YYYY';
  int _timeFormatMode = 0;
  String _selectedTimeZone = 'Asia/Manila (Philippine Time)';
  int _appearanceMode = 0;
  bool _isSaving = false;

  final List<String> _currencies = [
    'Philippine Peso (PHP ₱)',
    'US Dollar (USD \$)',
  ];

  final List<String> _languages = [
    'English',
    'Filipino / Tagalog',
  ];

  final List<String> _dateFormats = [
    'DD/MM/YYYY',
    'MM/DD/YYYY',
    'YYYY-MM-DD',
  ];

  final List<String> _timeZones = [
    'Asia/Manila (Philippine Time)',
    'UTC / GMT',
  ];

  final List<String> _appearanceOptions = ['System Default', 'Light Mode', 'Dark Mode'];

  void _saveChanges() async {
    setState(() => _isSaving = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _isSaving = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('General preferences updated successfully!', style: GoogleFonts.poppins()),
        backgroundColor: brandColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _resetToDefault() {
    setState(() {
      _selectedCurrency = 'Philippine Peso (PHP ₱)';
      _selectedLanguage = 'English';
      _selectedDateFormat = 'DD/MM/YYYY';
      _timeFormatMode = 0;
      _selectedTimeZone = 'Asia/Manila (Philippine Time)';
      _appearanceMode = 0;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Preferences reset to platform defaults.', style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF475569),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  String get _formattedPreviewDateTime {
    final dateStr = _selectedDateFormat == 'MM/DD/YYYY'
        ? '10/24/2026'
        : (_selectedDateFormat == 'YYYY-MM-DD' ? '2026-10-24' : '24/10/2026');
    final timeStr = _timeFormatMode == 0 ? '1:30 PM' : '13:30';
    return '$dateStr · $timeStr';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF0F172A), size: 18),
          onPressed: () => Navigator.pop(context),
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
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customize the display and regional preferences of GoCrave Admin.',
              style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF64748B)),
            ),
            const SizedBox(height: 18),

            Text(
              'Regional Settings',
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
                        value: _selectedCurrency,
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down_rounded, color: brandColor),
                        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                        onChanged: (String? val) {
                          if (val != null) setState(() => _selectedCurrency = val);
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
                    'Used for prices, fees, and financial reports. For a Philippines-only platform, keep PHP fixed unless multi-currency support is implemented.',
                    style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8), height: 1.4),
                  ),

                  const SizedBox(height: 18),

                  Text('Language', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
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
                        value: _selectedLanguage,
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down_rounded, color: brandColor),
                        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                        onChanged: (String? val) {
                          if (val != null) setState(() => _selectedLanguage = val);
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
                        value: _selectedDateFormat,
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down_rounded, color: brandColor),
                        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                        onChanged: (String? val) {
                          if (val != null) setState(() => _selectedDateFormat = val);
                        },
                        items: _dateFormats.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text('$value · ${_formattedDateSample(value)}'),
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
                            onTap: () => setState(() => _timeFormatMode = 0),
                            borderRadius: BorderRadius.circular(12),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: _timeFormatMode == 0 ? brandColor : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  '12-hour (1:30 PM)',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: _timeFormatMode == 0 ? FontWeight.bold : FontWeight.w500,
                                    color: _timeFormatMode == 0 ? Colors.white : const Color(0xFF64748B),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => setState(() => _timeFormatMode = 1),
                            borderRadius: BorderRadius.circular(12),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: _timeFormatMode == 1 ? brandColor : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  '24-hour (13:30)',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: _timeFormatMode == 1 ? FontWeight.bold : FontWeight.w500,
                                    color: _timeFormatMode == 1 ? Colors.white : const Color(0xFF64748B),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                        value: _selectedTimeZone,
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down_rounded, color: brandColor),
                        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                        onChanged: (String? val) {
                          if (val != null) setState(() => _selectedTimeZone = val);
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
                ],
              ),
            ),

            const SizedBox(height: 22),

            Text(
              'Appearance',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Choose how the admin app looks on your device.',
              style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: List.generate(_appearanceOptions.length, (idx) {
                  final isSelected = _appearanceMode == idx;
                  return Expanded(
                    child: InkWell(
                      onTap: () => setState(() => _appearanceMode = idx),
                      borderRadius: BorderRadius.circular(12),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? brandColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: isSelected
                              ? [BoxShadow(color: brandColor.withOpacity(0.35), blurRadius: 8, offset: const Offset(0, 3))]
                              : [],
                        ),
                        child: Center(
                          child: Text(
                            _appearanceOptions[idx],
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              color: isSelected ? Colors.white : const Color(0xFF64748B),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 22),

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
                      Icon(Icons.remove_red_eye_rounded, color: brandColor, size: 20),
                      const SizedBox(width: 8),
                      Text('Preview', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text('Example Order Total', style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
                  const SizedBox(height: 2),
                  Text(
                    _selectedCurrency.contains('USD') ? '\$2,500.00' : '₱2,500.00',
                    style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w900, color: const Color(0xFF0F172A)),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _formattedPreviewDateTime,
                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: brandColor),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Interactive preview only. Changes above are not saved to GoCrave.',
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
                      onPressed: _resetToDefault,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF94A3B8), width: 1.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Text(
                        'Reset to Default',
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
    );
  }

  String _formattedDateSample(String format) {
    if (format == 'MM/DD/YYYY') return '10/24/2026';
    if (format == 'YYYY-MM-DD') return '2026-10-24';
    return '24/10/2026';
  }
}
