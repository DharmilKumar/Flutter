import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<String> lstcontactno = <String>['247327384','364536','34635276','3614611','84736484','83864837'];
class dashboard extends StatefulWidget {
  var phoneno;

  dashboard({super.key,required this.phoneno});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  var selectedValue = null;
  var isChedcked = false;
  String contactno = lstcontactno.first;
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var selectedDate;
  var selectedTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedValue = 'Male';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(value:contactno,
                icon: Icon(Icons.arrow_downward_sharp),
                items: lstcontactno.map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem(value:value,
                  child:Text(value));
                }).toList(),
                onChanged: (String? value){
                    setState(() {
                      contactno = value!;
                    });
                }),
            RadioListTile(
                title: Text('Male'),
                value: 'Male',
                groupValue: selectedValue,
                onChanged: (value){
                  setState(() {
                    selectedValue = value;
                  });

                }),
            RadioListTile(
                title: Text('Female'),
                value: 'Female',
                groupValue: selectedValue,
                onChanged: (value){
                  setState(() {
                    selectedValue = value;
                  });
                }),
            CheckboxListTile(
                title: Text('Terms and Condition'),
                value: isChedcked, onChanged: (value){
                  setState(() {
                    isChedcked = value!;

                  });

            }),
            Container(
              height: 20,
            ),
            TextField(
              controller: dateController,
              readOnly: true,
              showCursor: true,
              decoration: InputDecoration(
                labelText: 'Select Date',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: Icon(Icons.date_range_sharp)
              ),
              onTap: () async {
                  DateTime? datePicker = await showDatePicker(context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2024));

                  if(datePicker != null)
                    {
                      selectedDate = DateFormat("dd-MM-yyyy").format(datePicker);
                      dateController.text = selectedDate;
                    }
              },
            ),
            Container(
              height: 20,
            ),
            TextField(
              controller: timeController,
              readOnly: true,
              showCursor: true,
              decoration: InputDecoration(
                  labelText: 'Select Time',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: Icon(Icons.timer)
              ),
              onTap:  () async {
                TimeOfDay? timePicker = await showTimePicker(context: context,
                    initialTime: TimeOfDay.now(),
                initialEntryMode: TimePickerEntryMode.input);

                if(timePicker != null)
                  {
                    final now = DateTime.now();
                    final time = DateTime(now.year,now.month,now.day,timePicker.hour,timePicker.minute);

                    selectedTime = DateFormat("HH:mm").format(time);
                    print(time);
                    print(selectedTime);
                    timeController.text = selectedTime;
                  }
              },
            ),
            ElevatedButton(onPressed: (){
              if(selectedValue != null)
                {
                  print(selectedValue);
                }
              print(isChedcked);
            }, child: const Text('Display'))

          ],
        ),
      )
    );
  }
}
