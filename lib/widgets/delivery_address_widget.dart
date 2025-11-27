// TODO: Buat widget DeliveryAddressWidget
// 
// Widget untuk input alamat pengiriman.
// 
// Parameter:
// - onChanged (Function(String)): Callback saat alamat berubah
// - initialValue (String?): Nilai awal (nullable)
//
// Menampilkan:
// - TextField untuk alamat
//
// Lihat INSTRUKSI.md di folder widgets/ untuk panduan lengkap.
import 'package:flutter/material.dart';

class DeliveryAddressWidget extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String? initialValue;

  const DeliveryAddressWidget({
    Key? key,
    required this.onChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: initialValue != null 
            ? TextEditingController(text: initialValue) 
            : null,
            
        decoration: const InputDecoration(
          labelText: 'Alamat Pengiriman',
          hintText: 'Masukkan alamat lengkap Anda',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.location_on),
        ),
        
        onChanged: onChanged,
        
        keyboardType: TextInputType.multiline,
        maxLines: null, 
        minLines: 3,  
      ),
    );
  }
}