// TODO: Buat widget CheckoutPromoCodeWidget
// 
// Widget untuk input promo code di checkout page.
// 
// Lihat INSTRUKSI.md di folder widgets/ untuk panduan lengkap.
import 'package:flutter/material.dart';

class CheckoutPromoCodeWidget extends StatefulWidget {
  final Function(String promoCode)? onApplyPromo;

  const CheckoutPromoCodeWidget({
    Key? key,
    this.onApplyPromo,
  }) : super(key: key);

  @override
  State<CheckoutPromoCodeWidget> createState() => _CheckoutPromoCodeWidgetState();
}

class _CheckoutPromoCodeWidgetState extends State<CheckoutPromoCodeWidget> {
  final TextEditingController _controller = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _controller.removeListener(_updateButtonState);
    _controller.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _controller.text.trim().isNotEmpty;
    });
  }

  void _handleApplyPromo() {
    final promoCode = _controller.text.trim();
    if (promoCode.isNotEmpty) {

      widget.onApplyPromo?.call(promoCode);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mencoba menerapkan kode promo: $promoCode'),
          duration: const Duration(seconds: 2),
        ),
      );
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Punya Kode Promo?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Masukkan kode promo di sini',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
                  ),
                  textCapitalization: TextCapitalization.characters, 
                  onSubmitted: (_) => _isButtonEnabled ? _handleApplyPromo() : null, 
                ),
              ),

              ElevatedButton(
                onPressed: _isButtonEnabled ? _handleApplyPromo : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 50),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                    ),
                  ),
                  backgroundColor: Theme.of(context).primaryColor, 
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Terapkan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text('Kode promo berhasil diterapkan!', style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }
}
