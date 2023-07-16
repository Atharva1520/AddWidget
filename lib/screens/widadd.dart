import 'package:flutter/material.dart';

class WidgetAdd extends StatefulWidget {
  const WidgetAdd({super.key});

  @override
  State<WidgetAdd> createState() => _WidgetAddState();
}

class _WidgetAddState extends State<WidgetAdd> {
  List<String> selectedOptions = [];

  void handleRadioValueChanged(String value) {
    setState(() {
      if (selectedOptions.contains(value)) {
        selectedOptions.remove(value);
      } else {
        selectedOptions.add(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          children: [
            SizedBox(
              height: 600,
              width: double.infinity,
              child: Card(
                color: const Color.fromARGB(255, 218, 238, 218),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(color: Colors.grey),
                      child: RadioListTile(
                        title: const Text('Text Widget'),
                        value: 'Text Widget',
                        groupValue: selectedOptions.contains('Text Widget')
                            ? 'Text Widget'
                            : null,
                        onChanged: (value) => handleRadioValueChanged(value!),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: const BoxDecoration(color: Colors.grey),
                      child: RadioListTile(
                        title: const Text('Image Widget'),
                        value: 'Image Widget',
                        groupValue: selectedOptions.contains('Image Widget')
                            ? 'Image Widget'
                            : null,
                        onChanged: (value) => handleRadioValueChanged(value!),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: const BoxDecoration(color: Colors.grey),
                      child: RadioListTile(
                        title: const Text('Button Widget'),
                        value: 'Button Widget',
                        groupValue: selectedOptions.contains('Button Widget')
                            ? 'Button Widget'
                            : null,
                        onChanged: (value) => handleRadioValueChanged(value!),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.greenAccent),
              child: Center(
                child: InkWell(
                  child: const Text("Import Widget"),
                  onTap: () {
                    Navigator.pop(context, selectedOptions);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
