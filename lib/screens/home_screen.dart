import 'package:flutter/material.dart';
import 'booking_screen.dart';
import '../models/location.dart';
import '../components/custom_component.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  Location? _fromLocation;
  Location? _toLocation;
  DateTime _departureDate = DateTime.now();
  DateTime _returnDate = DateTime.now().add(const Duration(days: 1));
  int _numOfPax = 1;

  void _selectDate(BuildContext context, bool isDeparture) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isDeparture ? _departureDate : _returnDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isDeparture) {
          _departureDate = picked;
        } else {
          _returnDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Train Ticket Booking')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildText(),
            const SizedBox(height: 20),
            _buildDropDownDestination(),
            const SizedBox(height: 20),
            _buildDateTrip(),
            const SizedBox(height: 20),
            _buildPaxDropdown(),
            const SizedBox(height: 20),
            _buildNavigateButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildText() {
    return const Text(
      'Welcome To Train Booking System',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildDropDownDestination() {
    return Row(
      children: [
        Expanded(
          child: buildDropdownInput(
            context: context,
            label: 'From',
            value: _fromLocation,
            items: Location.values,
            onChanged: (newValue) {
              setState(() {
                _fromLocation = newValue;
              });
            },
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: buildDropdownInput(
            context: context,
            label: 'To',
            value: _toLocation,
            items: Location.values,
            onChanged: (newValue) {
              setState(() {
                _toLocation = newValue;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDateTrip() {
    return Column(
      children: [
        buildDateInput(
          context: context,
          label: 'Departure Date',
          date: _departureDate,
          isDeparture: true,
          isEnabled: _fromLocation != null && _toLocation != null,
          selectDate: (isDeparture) => _selectDate(context, isDeparture),
        ),
        const SizedBox(height: 20),
        buildDateInput(
          context: context,
          label: 'Return Date',
          date: _returnDate,
          isDeparture: false,
          isEnabled: _fromLocation != null && _toLocation != null,
          selectDate: (isDeparture) => _selectDate(context, isDeparture),
        ),
      ],
    );
  }

  Widget _buildPaxDropdown() {
    return Row(
      children: [
        const Text('No. of Pax: ', style: TextStyle(fontSize: 18)),
        DropdownButton<int>(
          value: _numOfPax,
          items: List.generate(10, (index) => index + 1)
              .map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
          onChanged: (int? newValue) {
            setState(() {
              _numOfPax = newValue!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildNavigateButton() {
    return Center(
      child: ElevatedButton(
        onPressed: (_fromLocation != null && _toLocation != null)
            ? () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BookingScreen(
                      origin: _fromLocation!,
                      destination: _toLocation!,
                      numOfPax: _numOfPax,
                    ),
                  ),
                );
              }
            : null,
        child: const Text('Search for Train'),
      ),
    );
  }
}
