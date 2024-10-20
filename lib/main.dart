import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedFromUnit;
  String? selectedToUnit;
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  bool showImage = false;

  // Method to get image based on the selected "To" unit
  Widget getImageForUnit(String? unit) {
    switch (unit) {
      case "Celsius":
        return ClipOval(
          child: Image.asset(
            'images/thermo.jpg',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        );
      case "Fahrenheit":
        return ClipOval(
          child: Image.asset(
            'images/ice.jpeg',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        );
      case "Kelvin":
        return ClipOval(
          child: Image.asset(
            'images/Kelvin.jpeg',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        );
      default:
        return SizedBox.shrink();
    }
  }

  // Method to perform the temperature conversion
  void convertTemperature() {
    double? input = double.tryParse(fromController.text);
    if (input != null) {
      double result;
      if (selectedFromUnit == "Celsius") {
        if (selectedToUnit == "Fahrenheit") {
          result = input * 9 / 5 + 32;
        } else if (selectedToUnit == "Kelvin") {
          result = input + 273.15;
        } else {
          result = input; // Celsius to Celsius
        }
      } else if (selectedFromUnit == "Fahrenheit") {
        if (selectedToUnit == "Celsius") {
          result = (input - 32) * 5 / 9;
        } else if (selectedToUnit == "Kelvin") {
          result = (input - 32) * 5 / 9 + 273.15;
        } else {
          result = input; // Fahrenheit to Fahrenheit
        }
      } else if (selectedFromUnit == "Kelvin") {
        if (selectedToUnit == "Celsius") {
          result = input - 273.15;
        } else if (selectedToUnit == "Fahrenheit") {
          result = (input - 273.15) * 9 / 5 + 32;
        } else {
          result = input; // Kelvin to Kelvin
        }
      } else {
        result = input; // Default case
      }
      toController.text = result.toString();
    }
    setState(() {
      showImage = true; // Set to true to display the image
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Temp Converter",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Row for "From" dropdown and TextField
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: DropdownButton<String>(
                    value: selectedFromUnit,
                    hint: Text("Select Unit"),
                    items: [
                      DropdownMenuItem(
                        child: Text("Celsius"),
                        value: "Celsius",
                      ),
                      DropdownMenuItem(
                        child: Text("Fahrenheit"),
                        value: "Fahrenheit",
                      ),
                      DropdownMenuItem(
                        child: Text("Kelvin"),
                        value: "Kelvin",
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedFromUnit = value;
                      });
                    },
                    isExpanded: true,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: fromController,
                    decoration: InputDecoration(
                      labelText: "Enter value",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Row for "To" dropdown and TextField
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: DropdownButton<String>(
                    value: selectedToUnit,
                    hint: Text("Select Unit"),
                    items: [
                      DropdownMenuItem(
                        child: Text("Celsius"),
                        value: "Celsius",
                      ),
                      DropdownMenuItem(
                        child: Text("Fahrenheit"),
                        value: "Fahrenheit",
                      ),
                      DropdownMenuItem(
                        child: Text("Kelvin"),
                        value: "Kelvin",
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedToUnit = value;
                      });
                    },
                    isExpanded: true,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: toController,
                    decoration: InputDecoration(
                      labelText: "Converted value",
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Convert Button
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    convertTemperature(); // Call the conversion method
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(
                    'Convert',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Display the image if showImage is true
            if (showImage) getImageForUnit(selectedToUnit),
          ],
        ),
      ),
    );
  }
}
