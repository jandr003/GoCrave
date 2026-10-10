import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantBusinessIdModal extends StatefulWidget {
  final String currentPermitType;
  final String currentPermitNumber;
  final Color brandColor;
  final Function(String permitType, String permitNumber, String permitPhoto, String ownerIdPhoto) onSave;

  const RestaurantBusinessIdModal({
    super.key,
    this.currentPermitType = 'DTI Business Registration & BIR 2303',
    this.currentPermitNumber = '#BP-2026-99210',
    required this.brandColor,
    required this.onSave,
  });

  @override
  State<RestaurantBusinessIdModal> createState() => _RestaurantBusinessIdModalState();
}

class _RestaurantBusinessIdModalState extends State<RestaurantBusinessIdModal> {
  late String _selectedPermitType;
  late TextEditingController _permitNumberCtrl;

  String _dtiPermitPhoto = 'https://images.unsplash.com/photo-1554224155-8d04cb21cd6c?q=80&w=400&auto=format&fit=crop';
  String _ownerIdPhoto = 'https://images.unsplash.com/photo-1589829545856-d10d557cf95f?q=80&w=400&auto=format&fit=crop';
  bool _isUploadingPermit = false;
  bool _isUploadingOwnerId = false;

  final List<String> _permitTypes = [
    'DTI Business Registration & BIR 2303',
    'Mayor\'s Business Permit',
    'Store Owner\'s PhilSys National ID',
    'Store Owner\'s Driver License / Passport',
  ];

  @override
  void initState() {
    super.initState();
    _selectedPermitType = widget.currentPermitType;
    _permitNumberCtrl = TextEditingController(text: widget.currentPermitNumber);
  }

  @override
  void dispose() {
    _permitNumberCtrl.dispose();
    super.dispose();
  }

  void _simulateUploadPermit() {
    setState(() => _isUploadingPermit = true);
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _isUploadingPermit = false;
          _dtiPermitPhoto = 'https://images.unsplash.com/photo-1554224155-8d04cb21cd6c?q=80&w=400&auto=format&fit=crop';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('DTI Business Permit photo uploaded!', style: GoogleFonts.poppins()),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });
  }

  void _simulateUploadOwnerId() {
    setState(() => _isUploadingOwnerId = true);
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _isUploadingOwnerId = false;
          _ownerIdPhoto = 'https://images.unsplash.com/photo-1589829545856-d10d557cf95f?q=80&w=400&auto=format&fit=crop';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Store Owner ID photo uploaded!', style: GoogleFonts.poppins()),
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
                Expanded(
                  child: Text(
                    'Merchant Business Permit & ID',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
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
                        'VERIFIED PARTNER',
                        style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFF2E7D32)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              'Upload valid DTI permit and owner ID for store verification',
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500]),
            ),
            const SizedBox(height: 20),

            Text(
              'Select Document Type',
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
                  value: _selectedPermitType,
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down_rounded, color: widget.brandColor),
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => _selectedPermitType = val);
                    }
                  },
                  items: _permitTypes.map((type) {
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
              'Permit / Registration Number',
              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9FB),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.badge_outlined, size: 20, color: widget.brandColor),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _permitNumberCtrl,
                      style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Enter Permit Registration e.g. #BP-2026-99210',
                        hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 13),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Document Photos (DTI Permit & Owner ID)',
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
                              Image.network(_dtiPermitPhoto, fit: BoxFit.cover),
                              Container(color: Colors.black.withOpacity(0.25)),
                              if (_isUploadingPermit)
                                const Center(child: CircularProgressIndicator(color: Colors.white))
                              else
                                Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.cloud_upload_rounded, color: Colors.white, size: 24),
                                      const SizedBox(height: 4),
                                      Text(
                                        'DTI Permit Photo',
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
                        onPressed: _simulateUploadPermit,
                        icon: Icon(Icons.camera_alt_outlined, size: 14, color: widget.brandColor),
                        label: Text('Change Permit', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: widget.brandColor)),
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
                              Image.network(_ownerIdPhoto, fit: BoxFit.cover),
                              Container(color: Colors.black.withOpacity(0.25)),
                              if (_isUploadingOwnerId)
                                const Center(child: CircularProgressIndicator(color: Colors.white))
                              else
                                Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.cloud_upload_rounded, color: Colors.white, size: 24),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Owner ID Photo',
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
                        onPressed: _simulateUploadOwnerId,
                        icon: Icon(Icons.camera_alt_outlined, size: 14, color: widget.brandColor),
                        label: Text('Change Owner ID', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: widget.brandColor)),
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
                  widget.onSave(_selectedPermitType, _permitNumberCtrl.text, _dtiPermitPhoto, _ownerIdPhoto);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.check_circle_rounded, size: 20, color: Colors.white),
                label: Text(
                  'Submit Business Permit for Verification',
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
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
