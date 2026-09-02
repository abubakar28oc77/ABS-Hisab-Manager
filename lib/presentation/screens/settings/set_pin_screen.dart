import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../providers/auth_provider.dart';

class SetPinScreen extends StatefulWidget {
  const SetPinScreen({super.key});

  @override
  State<SetPinScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  final _pinCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  String? _error;

  Future<void> _save() async {
    if (_pinCtrl.text.length != 4) {
      setState(() => _error = 'PIN must be 4 digits');
      return;
    }
    if (_pinCtrl.text != _confirmCtrl.text) {
      setState(() => _error = 'PINs do not match');
      return;
    }
    await context.read<AuthProvider>().setPin(_pinCtrl.text);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Set PIN')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _pinCtrl,
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 4,
                decoration: const InputDecoration(
                  labelText: 'Enter 4-digit PIN',
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: _confirmCtrl,
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 4,
                decoration: const InputDecoration(labelText: 'Confirm PIN'),
              ),
              if (_error != null) ...[
                const SizedBox(height: 8),
                Text(_error!, style: const TextStyle(color: AppColors.expense)),
              ],
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _save, child: const Text('Save PIN')),
            ],
          ),
        ),
      ),
    );
  }
}
