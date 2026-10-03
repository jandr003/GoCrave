import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RiderGovernmentIdModal extends StatefulWidget {
  final String currentIdType;
  final String currentIdNumber;
  final Color brandColor;
  final Function(String idType, String idNumber, String frontPhoto, String backPhoto) onSave;

  const RiderGovernmentIdModal({
    super.key,
    this.currentIdType = 'PhilSys Philippine National ID',
    this.currentIdNumber = '#PH-NID-88123-90',
    required this.brandColor,
    required this.onSave,
  });

  @override
  State<RiderGovernmentIdModal> createState() => _RiderGovernmentIdModalState();
}

class _RiderGovernmentIdModalState extends State<RiderGovernmentIdModal> {
  late String _selectedIdType;
  late TextEditingController _idNumberCtrl;

  String _frontIdPhoto = 'https://images.unsplash.com/photo-1589829545856-d10d557cf95f?q=80&w=400&auto=format&fit=crop';
  String _backIdPhoto = 'https://images.unsplash.com/photo-1554224155-8d04cb21cd6c?q=80&w=400&auto=format&fit=crop';
  bool _isUploadingFront = false;
  bool _isUploadingBack = false;

  final List<String> _idTypes = [
    'PhilSys Philippine National ID',
    'Professional Driver\'s License',
    'Philippine Passport',
    'SSS / UMID Card',
    'Voters ID / Postal ID',
  ];

  @override
  void initState() {
    super.initState();
    _selectedIdType = widget.currentIdType;
    _idNumberCtrl = TextEditingController(text: widget.currentIdNumber);
  }

  @override
  void dispose() {
    _idNumberCtrl.dispose();
    super.dispose();
  }

  void _simulateUploadFront() {
    setState(() => _isUploadingFront = true);
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _isUploadingFront = false;
          _frontIdPhoto = 'https://images.unsplash.com/photo-1589829545856-d10d557cf95f?q=80&w=400&auto=format&fit=crop';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Front ID photo uploaded successfully!', style: GoogleFonts.poppins()),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });
  }

  void _simulateUploadBack() {
    setState(() => _isUploadingBack = true);
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _isUploadingBack = false;
          _backIdPhoto = 'https://images.unsplash.com/photo-1554224155-8d04cb21cd6c?q=80&w=400&auto=format&fit=crop';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Back ID photo uploaded successfully!', style: GoogleFonts.poppins()),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        top: 24,
        left: 24,
        right: 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rider Government ID',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.green.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.verified_rounded, color: Color(0xFF2E7D32), size: 14),
                      const SizedBox(width: 4),
                      Text(
                        'VERIFIED COURIER',
                        style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFF2E7D32)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              'Upload valid government ID for GoCrave rider verification',
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500]),
            ),
            const SizedBox(height: 20),

            Text(
              'Select Government ID Type',
              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9FB),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedIdType,
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down_rounded, color: widget.brandColor),
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => _selectedIdType = val);
                    }
                  },
                  items: _idTypes.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              'Government ID Number',
              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9FB),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: TextField(
                controller: _idNumberCtrl,
                style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  hintText: 'Enter ID Number e.g. #PH-NID-88123-90',
                  hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 13),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.badge_outlined, size: 20, color: widget.brandColor),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'ID Document Photos (Front & Back)',
              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 110,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F9FC),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: widget.brandColor.withOpacity(0.3), width: 1.5),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(_frontIdPhoto, fit: BoxFit.cover),
                              Container(color: Colors.black.withOpacity(0.25)),
                              if (_isUploadingFront)
                                const Center(child: CircularProgressIndicator(color: Colors.white))
                              else
                                Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.cloud_upload_rounded, color: Colors.white, size: 24),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Front ID Photo',
                                        style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextButton.icon(
                        onPressed: _simulateUploadFront,
                        icon: Icon(Icons.camera_alt_outlined, size: 14, color: widget.brandColor),
                        label: Text('Change Front', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: widget.brandColor)),
                        style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(0, 24)),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 110,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F9FC),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: widget.brandColor.withOpacity(0.3), width: 1.5),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(_backIdPhoto, fit: BoxFit.cover),
                              Container(color: Colors.black.withOpacity(0.25)),
                              if (_isUploadingBack)
                                const Center(child: CircularProgressIndicator(color: Colors.white))
                              else
                                Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.cloud_upload_rounded, color: Colors.white, size: 24),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Back ID Photo',
                                        style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextButton.icon(
                        onPressed: _simulateUploadBack,
                        icon: Icon(Icons.camera_alt_outlined, size: 14, color: widget.brandColor),
                        label: Text('Change Back', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: widget.brandColor)),
                        style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(0, 24)),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  widget.onSave(_selectedIdType, _idNumberCtrl.text, _frontIdPhoto, _backIdPhoto);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.check_circle_rounded, size: 20, color: Colors.white),
                label: Text(
                  'Submit ID for Verification',
                  style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.brandColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
