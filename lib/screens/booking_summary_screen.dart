import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import '../models/location.dart';
import '../providers/booking_provider.dart';
import '../screens/main_screen.dart';
import 'package:path_provider/path_provider.dart';


class BookingSummaryScreen extends StatefulWidget {
  final Location origin;
  final Location destination;
  final int numOfPax;
  final String price;
  final String departureTime;
  final String arrivalTime;

  const BookingSummaryScreen({
    super.key,
    required this.origin,
    required this.destination,
    required this.numOfPax,
    required this.price,
    required this.departureTime,
    required this.arrivalTime,
  });

  @override
  BookingSummaryScreenState createState() => BookingSummaryScreenState();
}

class BookingSummaryScreenState extends State<BookingSummaryScreen> {
  final ScreenshotController screenshotController = ScreenshotController();
  bool isOneWaySelected = false;
  bool isRoundTripSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booking Summary')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBookingSummaryDetails(),
            const SizedBox(height: 20),
            _buildTripTypeSelector(),
            const SizedBox(height: 40),
            _buildConfirmBookingButton(),
            const SizedBox(height: 20),
            _buildDownloadButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingSummaryDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Booking Summary',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Text('From: ${widget.origin.name}', style: const TextStyle(fontSize: 16)),
        Text('To: ${widget.destination.name}', style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Text('Departure Time: ${widget.departureTime}', style: const TextStyle(fontSize: 16)),
        Text('Arrival Time: ${widget.arrivalTime}', style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Text('Total Amount: ${widget.price}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildTripTypeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              isOneWaySelected = true;
              isRoundTripSelected = false;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isOneWaySelected ? Colors.yellow[700] : Colors.grey[300],
          ),
          child: const Text('One Way'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              isOneWaySelected = false;
              isRoundTripSelected = true;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isRoundTripSelected ? Colors.yellow[700] : Colors.grey[300],
          ),
          child: const Text('Round Trip'),
        ),
      ],
    );
  }

  Widget _buildConfirmBookingButton() {
    return Center(
      child: ElevatedButton(
        onPressed: isOneWaySelected || isRoundTripSelected
            ? () {
                Provider.of<BookingProvider>(context, listen: false).addBooking(
                  Booking(
                    origin: widget.origin,
                    destination: widget.destination,
                    numOfPax: widget.numOfPax,
                    price: widget.price,
                    departureTime: widget.departureTime,
                    arrivalTime: widget.arrivalTime,
                  ),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(selectedIndex: 1),
                  ),
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        ),
        child: const Text('Confirm Booking'),
      ),
    );
  }

  Widget _buildDownloadButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          final image = await screenshotController.capture();
          if (image != null) {
            final directory = await getApplicationDocumentsDirectory();
            final imagePath = '${directory.path}/booking_summary.png';
            final file = File(imagePath);
            await file.writeAsBytes(image);

          if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Screenshot saved to $imagePath')),
              );
            }
          }
        },
        child: const Text('Download Screenshot'),
      ),
    );
  }
}
