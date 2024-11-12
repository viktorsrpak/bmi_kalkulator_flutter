import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "BMI Kalkulator",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: const Center(
          child: BMIKalkulator(),
        ),
      ),
    );
  }
}

class BMIKalkulator extends StatefulWidget {
  const BMIKalkulator({super.key});

  @override
  _BMIKalkulatorState createState() => _BMIKalkulatorState();
}

class _BMIKalkulatorState extends State<BMIKalkulator> {
  final visinaController = TextEditingController();
  final tezinaController = TextEditingController();
  final godineController = TextEditingController();
  String spol = 'musko';
  double? bmi;
  String bmiKategorija = "";
  String porukaGreske = "";

  void izracunajBMI() {
    double visina = double.tryParse(visinaController.text) ?? -1;
    double tezina = double.tryParse(tezinaController.text) ?? -1;
    int godine = int.tryParse(godineController.text) ?? -1;

    if (visina <= 0 || tezina <= 0 || godine <= 0) {
      setState(() {
        bmi = null;
        bmiKategorija = "";
        porukaGreske =
            "Molimo unesite važeće pozitivne brojeve za visinu, težinu i godine.";
      });
      return;
    }

    porukaGreske = "";

    double rezultat = tezina / ((visina / 100) * (visina / 100));

    if (spol == 'zensko') {
      rezultat *= 0.95;
    }

    if (godine < 18) {
      rezultat *= 0.9;
    } else if (godine > 65) {
      rezultat *= 1.1;
    }

    setState(() {
      bmi = double.parse(rezultat.toStringAsFixed(2));
      bmiKategorija = odrediBMICategoriju(bmi!);
    });
  }

  String odrediBMICategoriju(double bmi) {
    if (bmi < 18.5) {
      return "Pothranjenost";
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return "Normalna težina";
    } else if (bmi >= 25 && bmi < 29.9) {
      return "Prekomjerna težina";
    } else {
      return "Pretilost";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: visinaController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Visina (cm)",
              border: OutlineInputBorder(),
            ),
            
          ),
          const SizedBox(height: 16),
          TextField(
            controller: tezinaController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Težina (kg)",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: godineController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Godine",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButton<String>(
            value: spol,
            items: const [
              DropdownMenuItem(value: 'musko', child: Text("Muško")),
              DropdownMenuItem(value: 'zensko', child: Text("Žensko")),
            ],
            onChanged: (value) {
              setState(() {
                spol = value!;
              });
            },
            style: const TextStyle(fontSize: 20, color: Colors.black),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: izracunajBMI,
            child: const Text("Izračunaj BMI"),
          ),
          const SizedBox(height: 20),
          if (porukaGreske.isNotEmpty)
            Text(
              porukaGreske,
              style: const TextStyle(color: Colors.red, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          if (bmi != null)
            Column(
              children: [
                Text("Vaš BMI: $bmi", style: const TextStyle(fontSize: 22)),
                Text("Kategorija: $bmiKategorija",
                    style: const TextStyle(fontSize: 22)),
              ],
            ),
        ],
      ),
    );
  }
}
