import 'package:flutter/material.dart';

class StatusBar extends StatefulWidget {
  const StatusBar({Key? key}) : super(key: key);

  @override
  State<StatusBar> createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  String dropdownValue = 'Available';
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(3)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isDense: true,
          value: dropdownValue,
          icon: Icon(Icons.arrow_drop_down),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>['Available', 'Busy', 'Appear Offline']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: EdgeInsets.only(left: 3),
                child: Text(
                  value,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
