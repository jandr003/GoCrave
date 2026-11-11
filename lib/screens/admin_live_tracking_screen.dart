import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import '../data/order_model.dart';

class AdminLiveTrackingScreen extends StatefulWidget {
  final Map<String, dynamic> rider;
  final Color brandColor;

  const AdminLiveTrackingScreen({
    super.key,
    required this.rider,
    required this.brandColor,
  });

  @override
  State<AdminLiveTrackingScreen> createState() => _AdminLiveTrackingScreenState();
}

class _AdminLiveTrackingScreenState extends State<AdminLiveTrackingScreen> {
  final MapController _mapController = MapController();

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final OrderModel order = widget.rider['orderModel'] is OrderModel
        ? widget.rider['orderModel'] as OrderModel
        : OrderModel.fromJson(widget.rider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: widget.brandColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Live Tracking (${order.id.isNotEmpty ? order.id : '#R001'})',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          if (order.cityName.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              color: Colors.white,
              child: Text(
                'Local Delivery in ${order.cityName}',
                style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF64748B)),
              ),
            ),

          const Divider(height: 1, color: Color(0xFFE2E8F0)),

          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFCBD5E1), width: 1.5),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4)),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Stack(
                  children: [
                    FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        initialCenter: order.centerLatLng,
                        initialZoom: 15.0,
                        interactionOptions: const InteractionOptions(
                          flags: InteractiveFlag.all,
                        ),
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.gocrave.app',
                        ),
                        PolylineLayer(
                          polylines: [
                            Polyline(
                              points: order.routePoints,
                              strokeWidth: 6.0,
                              color: widget.brandColor,
                              borderColor: Colors.white,
                              borderStrokeWidth: 2.0,
                            ),
                          ],
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: order.storeLatLng,
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
                                        order.storeName.isNotEmpty ? order.storeName : 'Store',
                                        style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Marker(
                              point: order.riderLatLng,
                              width: 40,
                              height: 40,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: widget.brandColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2.5),
                                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))],
                                ),
                                child: const Icon(Icons.two_wheeler_rounded, color: Colors.white, size: 18),
                              ),
                            ),
                            Marker(
                              point: order.customerLatLng,
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
                                        order.customerName.isNotEmpty ? order.customerName : 'Customer',
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
                              backgroundColor: widget.brandColor.withOpacity(0.15),
                              backgroundImage: order.riderAvatar.isNotEmpty ? NetworkImage(order.riderAvatar) : null,
                              child: order.riderAvatar.isEmpty ? Icon(Icons.person, color: widget.brandColor) : null,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(order.riderName.isNotEmpty ? order.riderName : 'Assigned Rider', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                                  Text('${order.storeName} ➔ ${order.customerName}', style: GoogleFonts.poppins(fontSize: 11, color: widget.brandColor, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              final double currentZoom = _mapController.camera.zoom;
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
                              final double currentZoom = _mapController.camera.zoom;
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
                              _mapController.move(order.riderLatLng, 15.2);
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: widget.brandColor,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [BoxShadow(color: widget.brandColor.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4))],
                              ),
                              child: const Icon(Icons.my_location_rounded, color: Colors.white, size: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            color: Colors.white,
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
        ],
      ),
    );
  }

  Widget _buildStepBadge(String label, bool isDone) {
    return Column(
      children: [
        Icon(isDone ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded, size: 20, color: isDone ? const Color(0xFF2E7D32) : Colors.grey),
        const SizedBox(height: 4),
        Text(label, style: GoogleFonts.poppins(fontSize: 11, fontWeight: isDone ? FontWeight.bold : FontWeight.normal, color: isDone ? const Color(0xFF0F172A) : Colors.grey)),
      ],
    );
  }
}
