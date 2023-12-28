import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onpressed;

  const CustomButton({
    super.key,
    required this.label,
    required this.color,
    required this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        child: 
        label == 'loading' ?
        Container(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        )
        :Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ));
  }
}

class ReuseableDropdownMenu extends StatefulWidget {
  const ReuseableDropdownMenu({super.key});

  @override
  _ReuseableDropdownMenuState createState() => _ReuseableDropdownMenuState();
}

class _ReuseableDropdownMenuState extends State<ReuseableDropdownMenu> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 365,
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.grey,
            width: 1,
          )),
      child: DropdownButton<String>(
        underline: const SizedBox(),
        hint: const Text('Select Province'),
        isExpanded: true,
        value: selectedItem,
        onChanged: (newValue) {
          setState(() {
            selectedItem = newValue;
          });
        },
        items: [
          'Bagmati',
          'Gandaki',
          'Karnali',
          'Koshi',
          'Lumbini',
          'Madesh',
          'Sudurpaschim',
        ].map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Image.asset('assets/images/foodlogo.png'),
    );
  }
}
