// TODO: Buat widget CheckoutSpecialInstructionsWidget
// 
// Widget untuk input special instructions di checkout page.
// 
// Lihat INSTRUKSI.md di folder widgets/ untuk panduan lengkap.
import 'package:flutter/material.dart';

class CheckoutSpecialInstructionsWidget extends StatefulWidget {
  // Callback saat instruksi khusus berubah.
  final ValueChanged<String> onChanged;

  // Nilai awal (nullable) untuk instruksi.
  final String? initialValue;

  const CheckoutSpecialInstructionsWidget({
    Key? key,
    required this.onChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  State<CheckoutSpecialInstructionsWidget> createState() =>
      _CheckoutSpecialInstructionsWidgetState();
}

class _CheckoutSpecialInstructionsWidgetState
    extends State<CheckoutSpecialInstructionsWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan nilai awal
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Instruksi Khusus (Opsional)',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8.0),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Contoh: Jangan tekan bel, letakkan di depan pintu.',
              hintText: 'Masukkan catatan untuk kurir atau penjual di sini...',
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              prefixIcon: const Icon(Icons.notes),
              alignLabelWithHint: true, // Untuk multiline, memastikan label sejajar dengan hint
            ),
            // Callback saat teks berubah
            onChanged: widget.onChanged,
            
            // Mengatur keyboard untuk input multiline
            keyboardType: TextInputType.multiline,
            maxLines: 5,   // Batasi maksimal 5 baris
            minLines: 3,   // Tampilkan minimal 3 baris secara default
            maxLength: 250, // Batasan karakter untuk instruksi
          ),
        ],
      ),
    );
  }
}