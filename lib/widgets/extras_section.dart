// TODO: Buat widget ExtrasSection
// 
// Widget untuk memilih extra items.
// 
// Parameter:
// - extras (List<ExtraItem>): Daftar extra items
// - selectedExtras (List<ExtraItem>): Extra items yang sudah dipilih
// - onExtraToggled (Function(ExtraItem, bool)): Callback saat extra dipilih/deselect
//
// Menampilkan:
// - CheckboxListTile untuk setiap extra item
// - Nama dan harga extra item
//
// Lihat INSTRUKSI.md di folder widgets/ untuk panduan lengkap.
import 'package:flutter/material.dart';
import '../models/extra_item.dart';

class ExtrasSection extends StatelessWidget {
  final List<ExtraItem> extras;
  final Set<String> selectedExtras;
  final Function(String, bool) onExtraChanged;

  const ExtrasSection({
    super.key,
    required this.extras,
    required this.selectedExtras,
    required this.onExtraChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (extras.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add Extras',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 12),
          ...extras.map((extra) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: selectedExtras.contains(extra.id),
                    onChanged: (bool? value) {
                      onExtraChanged(extra.id, value ?? false);
                    },
                    activeColor: Colors.green,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          extra.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          extra.description,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '+\$${extra.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}