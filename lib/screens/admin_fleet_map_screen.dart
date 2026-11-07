import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import '../data/rider_fleet_manager.dart';

class AdminFleetMapScreen extends StatefulWidget {
  final Color brandColor;

  const AdminFleetMapScreen({
    super.key,
    this.brandColor = const Color(0xFFFF5622),
  });

  @override
  State<AdminFleetMapScreen> createState() => _AdminFleetMapScreenState();
}

class _AdminFleetMapScreenState extends State<AdminFleetMapScreen> {
  final MapController _mapController = MapController();
  final RiderFleetManager _fleetManager = RiderFleetManager();
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['All Riders', 'Available', 'On Delivery', 'Offline'];
  Map<String, dynamic>? _selectedRider;

  @override
  void initState() {
    super.initState();
    _fleetManager.addListener(_onFleetChanged);
  }

  @override
  void dispose() {
    _fleetManager.removeListener(_onFleetChanged);
    _mapController.dispose();
    super.dispose();
  }

  void _onFleetChanged() {
    if (mounted) setState(() {});
  }

  List<Map<String, dynamic>> get _filteredRiders {
    final riders = _fleetManager.riders;
    if (_selectedFilterIndex == 0) return riders;
    final filter = _filters[_selectedFilterIndex];
    return riders.where((r) => r['status'] == filter).toList();
  }

  void _showDispatchRiderModal() {
    final nameCtrl = TextEditingController();
    final plateCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    String selectedStatus = 'Available';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(24, 24, 24, MediaQuery.of(context).viewInsets.bottom + 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Dispatch New Active Rider', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                  const SizedBox(height: 16),
                  TextField(
                    controller: nameCtrl,
                    decoration: const InputDecoration(labelText: 'Rider Full Name (e.g. Juan Cruz)'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: plateCtrl,
                    decoration: const InputDecoration(labelText: 'Vehicle Plate Number (e.g. ABC 1234)'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: phoneCtrl,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(labelText: 'Phone Number (e.g. 09179876543)'),
                  ),
                  const SizedBox(height: 16),
                  Text('Initial Status', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF64748B))),
                  const SizedBox(height: 8),
                  Row(
                    children: ['Available', 'On Delivery', 'Offline'].map((status) {
                      final isSelected = selectedStatus == status;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: InkWell(
                            onTap: () => setModalState(() => selectedStatus = status),
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected ? widget.brandColor : const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: isSelected ? widget.brandColor : const Color(0xFFE2E8F0)),
                              ),
                              child: Center(
                                child: Text(
                                  status,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                    color: isSelected ? Colors.white : const Color(0xFF64748B),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (nameCtrl.text.isNotEmpty && plateCtrl.text.isNotEmpty) {
                          final random = Random();
                          final lat = 14.8520 + (random.nextDouble() * 0.012);
                          final lng = 120.8120 + (random.nextDouble() * 0.015);

                          _fleetManager.addRider({
                            'id': 'R${_fleetManager.riders.length + 101}',
                            'name': nameCtrl.text,
                            'status': selectedStatus,
                            'plate': plateCtrl.text.toUpperCase(),
                            'rating': '5.0',
                            'deliveries': '0',
                            'phone': phoneCtrl.text.isNotEmpty ? phoneCtrl.text : '09170000000',
                            'latLng': LatLng(lat, lng),
                            'avatar': 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=200&auto=format&fit=crop',
                          });

                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Rider ${nameCtrl.text} successfully dispatched to fleet!', style: GoogleFonts.poppins()),
                              backgroundColor: widget.brandColor,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.brandColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 0,
                      ),
                      child: Text('Dispatch to Fleet Map', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredRiders;
    final totalCount = _fleetManager.riders.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: widget.brandColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Master Fleet Operations Map',
          style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: List.generate(_filters.length, (idx) {
                  final isSelected = _selectedFilterIndex == idx;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: InkWell(
                      onTap: () => setState(() => _selectedFilterIndex = idx),
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? widget.brandColor : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: isSelected ? widget.brandColor : const Color(0xFFE2E8F0)),
                        ),
                        child: Text(
                          _filters[idx],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                            color: isSelected ? Colors.white : const Color(0xFF64748B),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          const Divider(height: 1, color: Color(0xFFE2E8F0)),

          Expanded(
            child: Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: const LatLng(14.8560, 120.8190),
                    initialZoom: 14.5,
                    interactionOptions: const InteractionOptions(
                      flags: InteractiveFlag.all,
                    ),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.gocrave.app',
                    ),
                    MarkerLayer(
                      markers: filtered.map((rider) {
                        final status = rider['status'];
                        Color markerColor = const Color(0xFF10B981);
                        if (status == 'On Delivery') markerColor = widget.brandColor;
                        if (status == 'Offline') markerColor = Colors.grey;

                        return Marker(
                          point: rider['latLng'],
                          width: 44,
                          height: 44,
                          child: GestureDetector(
                            onTap: () {
                              setState(() => _selectedRider = rider);
                              _mapController.move(rider['latLng'], 16.0);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: markerColor,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 3.0),
                                boxShadow: [
                                  BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 3)),
                                ],
                              ),
                              child: const Icon(Icons.two_wheeler_rounded, color: Colors.white, size: 20),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),

                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Active Fleet: $totalCount Riders',
                          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  bottom: 24,
                  right: 16,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          final currentZoom = _mapController.camera.zoom;
                          _mapController.move(_mapController.camera.center, currentZoom + 0.8);
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 8, offset: const Offset(0, 3))],
                          ),
                          child: Icon(Icons.add_rounded, color: widget.brandColor, size: 20),
                        ),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () {
                          final currentZoom = _mapController.camera.zoom;
                          _mapController.move(_mapController.camera.center, currentZoom - 0.8);
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 8, offset: const Offset(0, 3))],
                          ),
                          child: Icon(Icons.remove_rounded, color: widget.brandColor, size: 20),
                        ),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () {
                          _mapController.move(const LatLng(14.8560, 120.8190), 14.5);
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: widget.brandColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [BoxShadow(color: widget.brandColor.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4))],
                          ),
                          child: const Icon(Icons.center_focus_strong_rounded, color: Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),

                if (_selectedRider != null)
                  Positioned(
                    bottom: 24,
                    left: 16,
                    right: 70,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 14, offset: const Offset(0, 6))],
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(_selectedRider!['avatar']),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Text(_selectedRider!['name'], style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                                    const SizedBox(width: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: _selectedRider!['status'] == 'On Delivery' ? widget.brandColor.withOpacity(0.15) : const Color(0xFFECFDF5),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        _selectedRider!['status'],
                                        style: GoogleFonts.poppins(
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold,
                                          color: _selectedRider!['status'] == 'On Delivery' ? widget.brandColor : const Color(0xFF10B981),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text('Plate: ${_selectedRider!['plate']} • 🛵 ${_selectedRider!['deliveries']} trips', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close_rounded, color: Colors.grey, size: 20),
                            onPressed: () => setState(() => _selectedRider = null),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showDispatchRiderModal,
        backgroundColor: widget.brandColor,
        icon: const Icon(Icons.person_add_rounded, color: Colors.white),
        label: Text('Dispatch Rider', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }
}
