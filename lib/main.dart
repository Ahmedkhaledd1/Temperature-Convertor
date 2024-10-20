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
  String? selectedFromUnit; // Holds the selected value for the "From" dropdown
  String? selectedToUnit; // Holds the selected value for the "To" dropdown
  TextEditingController fromController = TextEditingController(); // Controller for "From" TextField
  TextEditingController toController = TextEditingController(); // Controller for "To" TextField
  bool showImage = false; // To control image display

  // Method to get image based on the selected "To" unit
  Widget getImageForUnit(String? unit) {
    switch (unit) {
      case "Celsius":
        return ClipOval(
          child: Image.asset(
            'images/thermo.jpg',  // Image for Celsius
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        );
      case "Fahrenheit":
        return ClipOval(
          child: Image.asset(
            'images/ice.jpeg',  // Image for Fahrenheit
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        );
      case "Kelvin":
        return ClipOval(
          child: Image.asset(
            'images/Kelvin.jpeg',  // Image for Kelvin
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        );
      default:
        return SizedBox.shrink();  // Return an empty widget if no unit is selected
    }
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
            SizedBox(height: 20), // Space between rows

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
                SizedBox(width: 10), // Space between dropdown and TextField
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: toController,
                    decoration: InputDecoration(
                      labelText: "Converted value",
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true, // Read-only as it shows converted value
                  ),
                ),
              ],
            ),
            SizedBox(height: 20), // Space between rows

            // Convert Button
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    double? input = double.tryParse(fromController.text);
                    if (input != null) {
                      double result = input * 2;  // Simple multiplication for now
                      toController.text = result.toString();
                    }
                    setState(() {
                      showImage = true;  // Set to true to display the image
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Adjust the radius here
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
            SizedBox(height: 20), // Space between button and image

            // Display the image if showImage is true
            if (showImage)
              getImageForUnit(selectedToUnit), // Display the image based on selected "To" unit
          ],
        ),
      ),
    );
  }
}
