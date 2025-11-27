// TODO: Buat widget ViewSwitcher
// 
// Widget untuk switch antara grid view dan list view.
// 
// Parameter:
// - isGridView (bool): Status view mode
// - onViewChanged (Function(bool)): Callback saat view mode berubah
//
// Menampilkan:
// - Icon button untuk switch view
//
// Lihat INSTRUKSI.md di folder widgets/ untuk panduan lengkap.
import 'package:flutter/material.dart';

class ViewSwitcher extends StatefulWidget {
  final bool isGridView;                      // <-- Tambahkan ini
  final Function(bool isGridView) onViewChanged;

  const ViewSwitcher({
    super.key,
    required this.onViewChanged,
    this.isGridView = false,                 
  });

  @override
  State<ViewSwitcher> createState() => _ViewSwitcherState();
}

class _ViewSwitcherState extends State<ViewSwitcher> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.isGridView ? 1 : 0; 
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 80,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ToggleButtons(
        isSelected: [selectedIndex == 0, selectedIndex == 1],
        onPressed: (index) {
          setState(() => selectedIndex = index);
          widget.onViewChanged(index == 1);
        },
        borderRadius: BorderRadius.circular(12),
        borderColor: Colors.transparent,
        selectedBorderColor: Colors.transparent,
        fillColor: Colors.white,
        selectedColor: Colors.black,
        color: Colors.black54,
        constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
        children: const [
          Icon(Icons.list_outlined, size: 20),
          Icon(Icons.grid_view, size: 20),
        ],
      ),
    );
  }
}
