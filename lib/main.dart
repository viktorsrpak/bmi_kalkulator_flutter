import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BMIKalkulator(),
    );
  }
}

class BMIKalkulator extends StatefulWidget {
  const BMIKalkulator({super.key});

  @override
  _BMIKalkulatorState createState() => _BMIKalkulatorState();
}

class _BMIKalkulatorState extends State<BMIKalkulator> {
  final TextEditingController _tezinaController = TextEditingController();
  final TextEditingController _visinaController = TextEditingController();
  String _result = '';

  void _izracunajBMI() {
    final double tezina = double.tryParse(_tezinaController.text) ?? 0;
    final double visinaUCm = double.tryParse(_visinaController.text) ?? 0;

    if (tezina > 0 && visinaUCm > 0) {
      final double visinaUMet = visinaUCm / 100;
      final double bmi = tezina / (visinaUMet * visinaUMet);
      setState(() {
        _result = 'Tvoj BMI je: ${bmi.toStringAsFixed(2)}';
      });
    } else {
      setState(() {
        _result = 'Molimo vas unesite važeću kilažu i visinu';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Kalkulator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _tezinaController,
              decoration: const InputDecoration(
                labelText: 'Težina (kg)',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _visinaController,
              decoration: const InputDecoration(
                labelText: 'Visina (cm)',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _izracunajBMI,
              child: const Text('Izračunaj BMI'),
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
