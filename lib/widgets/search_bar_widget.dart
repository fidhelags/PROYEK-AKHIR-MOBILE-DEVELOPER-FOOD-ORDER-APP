// TODO: Buat widget SearchBarWidget
// 
// Widget reusable untuk search bar.
// 
// Parameter:
// - onChanged (Function(String)): Callback saat text berubah
// - hintText (String): Placeholder text
//
// Menampilkan:
// - TextField dengan icon search
//
// Lihat INSTRUKSI.md di folder widgets/ untuk panduan lengkap.
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey[600], size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Search for food',
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          ),
          Icon(Icons.filter_list, color: Colors.grey[600], size: 20),
        ],
      ),
    );
  }
}