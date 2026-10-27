import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StaffMember {
  final String id;
  String name;
  String email;
  String role;
  String status;
  Map<String, bool> permissions;

  StaffMember({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
    required this.permissions,
  });

  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.substring(0, name.length >= 2 ? 2 : 1).toUpperCase();
  }
}

class AdminStaffPermissionsScreen extends StatefulWidget {
  final List<StaffMember>? initialStaffList;
  final Function(List<StaffMember> staffList)? onStaffUpdated;

  const AdminStaffPermissionsScreen({
    super.key,
    this.initialStaffList,
    this.onStaffUpdated,
  });

  @override
  State<AdminStaffPermissionsScreen> createState() => _AdminStaffPermissionsScreenState();
}

class _AdminStaffPermissionsScreenState extends State<AdminStaffPermissionsScreen> {
  final Color brandColor = const Color(0xFFFF5622);
  final TextEditingController _searchCtrl = TextEditingController();

  late List<StaffMember> _staffList;
  String _searchQuery = '';

  final List<String> _roles = [
    'Coordinator',
    'Support Staff',
    'Finance Staff',
    'Operations Manager',
  ];

  @override
  void initState() {
    super.initState();
    _staffList = widget.initialStaffList ?? [
      StaffMember(
        id: 'STF-001',
        name: 'Maria Reyes',
        email: 'maria@example.com',
        role: 'Coordinator',
        status: 'Active',
        permissions: {
          'Manage Orders': true,
          'Approve Merchants': true,
          'Verify Riders': true,
          'Financial Reports': false,
        },
      ),
      StaffMember(
        id: 'STF-002',
        name: 'Juan Dela Cruz',
        email: 'juan@example.com',
        role: 'Support Staff',
        status: 'Active',
        permissions: {
          'Manage Orders': true,
          'Approve Merchants': false,
          'Verify Riders': true,
          'Financial Reports': false,
        },
      ),
      StaffMember(
        id: 'STF-003',
        name: 'Ana Cruz',
        email: 'ana@example.com',
        role: 'Finance Staff',
        status: 'Pending',
        permissions: {
          'Manage Orders': false,
          'Approve Merchants': false,
          'Verify Riders': false,
          'Financial Reports': true,
        },
      ),
    ];

    _searchCtrl.addListener(() {
      setState(() {
        _searchQuery = _searchCtrl.text.toLowerCase().trim();
      });
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  int get _totalStaff => _staffList.length;
  int get _activeStaff => _staffList.where((s) => s.status == 'Active').length;
  int get _pendingStaff => _staffList.where((s) => s.status == 'Pending').length;

  List<StaffMember> get _filteredStaff {
    if (_searchQuery.isEmpty) return _staffList;
    return _staffList.where((s) {
      return s.name.toLowerCase().contains(_searchQuery) ||
             s.email.toLowerCase().contains(_searchQuery) ||
             s.role.toLowerCase().contains(_searchQuery);
    }).toList();
  }

  void _notifyUpdated() {
    widget.onStaffUpdated?.call(_staffList);
  }

  void _showAddStaffModal() {
    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    String selectedRole = 'Coordinator';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(24, 20, 24, MediaQuery.of(context).viewInsets.bottom + 24),
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return Column(
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
                  Text('Add New Staff Member', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                  const SizedBox(height: 4),
                  Text('Create a new sub-admin account and assign permissions.', style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
                  const SizedBox(height: 16),

                  Text('Full Name', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE2E8F0))),
                    child: TextField(
                      controller: nameCtrl,
                      style: GoogleFonts.poppins(fontSize: 13),
                      decoration: InputDecoration(
                        hintText: 'e.g. Maria Clara',
                        hintStyle: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF94A3B8)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  Text('Email Address', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE2E8F0))),
                    child: TextField(
                      controller: emailCtrl,
                      style: GoogleFonts.poppins(fontSize: 13),
                      decoration: InputDecoration(
                        hintText: 'e.g. maria.clara@gocrave.app',
                        hintStyle: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF94A3B8)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  Text('Assigned Role', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE2E8F0))),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedRole,
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down_rounded, color: brandColor),
                        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                        onChanged: (val) {
                          if (val != null) setModalState(() => selectedRole = val);
                        },
                        items: _roles.map<DropdownMenuItem<String>>((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        if (nameCtrl.text.trim().isEmpty || emailCtrl.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please fill in both name and email.', style: GoogleFonts.poppins()), backgroundColor: Colors.redAccent),
                          );
                          return;
                        }

                        final newMember = StaffMember(
                          id: 'STF-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
                          name: nameCtrl.text.trim(),
                          email: emailCtrl.text.trim(),
                          role: selectedRole,
                          status: 'Active',
                          permissions: {
                            'Manage Orders': true,
                            'Approve Merchants': selectedRole == 'Coordinator' || selectedRole == 'Operations Manager',
                            'Verify Riders': selectedRole != 'Finance Staff',
                            'Financial Reports': selectedRole == 'Finance Staff' || selectedRole == 'Operations Manager',
                          },
                        );

                        setState(() {
                          _staffList.add(newMember);
                        });
                        _notifyUpdated();

                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${newMember.name} added to staff roster as $selectedRole!', style: GoogleFonts.poppins()),
                            backgroundColor: brandColor,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: brandColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 0,
                      ),
                      child: Text('Add Staff Member', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void _showStaffDetailModal(StaffMember staff) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(24, 20, 24, MediaQuery.of(context).viewInsets.bottom + 24),
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
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: brandColor.withOpacity(0.12),
                        child: Text(
                          staff.initials,
                          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: brandColor),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(staff.name, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                            Text(staff.email, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
                          ],
                        ),
                      ),
                      _buildStatusPill(staff.status),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const Divider(height: 1, color: Color(0xFFE2E8F0)),
                  const SizedBox(height: 16),

                  Text('Account Status', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                  const SizedBox(height: 8),
                  Row(
                    children: ['Active', 'Pending', 'Suspended'].map((st) {
                      final isSel = staff.status == st;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(st, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: isSel ? Colors.white : const Color(0xFF475569))),
                          selected: isSel,
                          selectedColor: brandColor,
                          backgroundColor: const Color(0xFFF1F5F9),
                          onSelected: (bool selected) {
                            if (selected) {
                              setModalState(() => staff.status = st);
                              setState(() {});
                              _notifyUpdated();
                            }
                          },
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 18),

                  Text('Role & Access Permissions', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                  const SizedBox(height: 8),

                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      children: staff.permissions.keys.map((permKey) {
                        final val = staff.permissions[permKey]!;
                        return SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          title: Text(permKey, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A))),
                          activeColor: brandColor,
                          value: val,
                          onChanged: (bool newVal) {
                            setModalState(() => staff.permissions[permKey] = newVal);
                            setState(() {});
                            _notifyUpdated();
                          },
                        );
                      }).toList(),
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
                      child: Text('Save Staff Changes', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildStatusPill(String status) {
    Color textColor;
    Color bgColor;
    if (status == 'Active') {
      textColor = const Color(0xFF10B981);
      bgColor = const Color(0xFFECFDF5);
    } else if (status == 'Pending') {
      textColor = const Color(0xFFD97706);
      bgColor = const Color(0xFFFEF3C7);
    } else {
      textColor = const Color(0xFFEF4444);
      bgColor = const Color(0xFFFEF2F2);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: textColor.withOpacity(0.3)),
      ),
      child: Text(
        status,
        style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: textColor),
      ),
    );
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
          'Staff & Permissions',
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
              'Manage staff accounts and control access to GoCrave Admin.',
              style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF64748B)),
            ),
            const SizedBox(height: 18),

            Text(
              'Staff Overview',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                _buildKpiCard('Total Staff', _totalStaff.toString(), brandColor),
                const SizedBox(width: 10),
                _buildKpiCard('Active', _activeStaff.toString(), const Color(0xFF10B981)),
                const SizedBox(width: 10),
                _buildKpiCard('Pending', _pendingStaff.toString(), const Color(0xFFD97706)),
              ],
            ),

            const SizedBox(height: 22),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchCtrl,
                style: GoogleFonts.poppins(fontSize: 13),
                decoration: InputDecoration(
                  hintText: 'Search staff by name or email',
                  hintStyle: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8)),
                  border: InputBorder.none,
                  icon: Icon(Icons.search_rounded, color: brandColor),
                ),
              ),
            ),

            const SizedBox(height: 22),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Staff Accounts',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                Text(
                  '${_filteredStaff.length} accounts',
                  style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
                ),
              ],
            ),
            const SizedBox(height: 10),

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
                children: List.generate(_filteredStaff.length, (idx) {
                  final staff = _filteredStaff[idx];
                  return Column(
                    children: [
                      InkWell(
                        onTap: () => _showStaffDetailModal(staff),
                        borderRadius: BorderRadius.circular(22),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: brandColor.withOpacity(0.12),
                                child: Text(
                                  staff.initials,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: brandColor,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      staff.name,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF0F172A),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      staff.email,
                                      style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${staff.role} · ${staff.status}',
                                      style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF475569)),
                                    ),
                                  ],
                                ),
                              ),
                              _buildStatusPill(staff.status),
                            ],
                          ),
                        ),
                      ),
                      if (idx < _filteredStaff.length - 1)
                        const Divider(height: 1, color: Color(0xFFF1F5F9)),
                    ],
                  );
                }),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: _showAddStaffModal,
                icon: const Icon(Icons.add_rounded, size: 20, color: Colors.white),
                label: Text(
                  'Add Staff',
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: brandColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
              ),
            ),



            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildKpiCard(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF64748B)),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w900, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
