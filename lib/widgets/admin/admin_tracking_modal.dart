import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';

class AdminTrackingModal extends StatelessWidget {
  final Map<String, dynamic> rider;
  final Color brandColor;

  const AdminTrackingModal({
    super.key,
    required this.rider,
    required this.brandColor,
  });

  @override
  Widget build(BuildContext context) {
    const storeLatLng = LatLng(14.8527, 120.8160);
    const riderLatLng = LatLng(14.8560, 120.8200);
    const customerLatLng = LatLng(14.8600, 120.8250);

    return Container(
      height: MediaQuery.of(context).size.height * 0.82,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rider Live Tracking',
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                ),
                IconButton(icon: const Icon(Icons.close_rounded, color: Colors.grey), onPressed: () => Navigator.pop(context)),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFEEEEEE)),

          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFBBDEFB)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Stack(
                  children: [
                    FlutterMap(
                      options: const MapOptions(
                        initialCenter: LatLng(14.8562, 120.8205),
                        initialZoom: 14.5,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.gocrave.app',
                        ),
                        PolylineLayer(
                          polylines: [
                            Polyline(
                              points: const [
                                storeLatLng,
                                LatLng(14.8540, 120.8180),
                                riderLatLng,
                                LatLng(14.8580, 120.8220),
                                customerLatLng,
                              ],
                              strokeWidth: 5.0,
                              color: const Color(0xFF005CEE),
                            ),
                          ],
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: storeLatLng,
                              width: 120,
                              height: 36,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(color: Color(0xFFFF5622), shape: BoxShape.circle),
                                      child: const Icon(Icons.store_rounded, color: Colors.white, size: 12),
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        'Jollibee',
                                        style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Marker(
                              point: riderLatLng,
                              width: 40,
                              height: 40,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: brandColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2.5),
                                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))],
                                ),
                                child: const Icon(Icons.two_wheeler_rounded, color: Colors.white, size: 18),
                              ),
                            ),
                            Marker(
                              point: customerLatLng,
                              width: 130,
                              height: 36,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(color: Color(0xFF2E7D32), shape: BoxShape.circle),
                                      child: const Icon(Icons.location_on_rounded, color: Colors.white, size: 12),
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        'Maria Santos',
                                        style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Positioned(
                      top: 14,
                      left: 14,
                      right: 14,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 12, offset: const Offset(0, 4))],
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(rider['avatar'] ?? 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=200&auto=format&fit=crop'),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(rider['name'] ?? 'Rider', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                                  Text('On the way • ETA 12 mins', style: GoogleFonts.poppins(fontSize: 11, color: brandColor, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStepBadge('Assigned', true),
                _buildStepBadge('Picked Up', true),
                _buildStepBadge('On Delivery', true),
                _buildStepBadge('Delivered', false),
              ],
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildStepBadge(String label, bool isDone) {
    return Column(
      children: [
        Icon(isDone ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded, size: 18, color: isDone ? const Color(0xFF2E7D32) : Colors.grey),
        const SizedBox(height: 4),
        Text(label, style: GoogleFonts.poppins(fontSize: 10, fontWeight: isDone ? FontWeight.bold : FontWeight.normal, color: isDone ? const Color(0xFF0F172A) : Colors.grey)),
      ],
    );
  }
}
