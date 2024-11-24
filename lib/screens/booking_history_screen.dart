import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/booking_provider.dart';

class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookings = Provider.of<BookingProvider>(context).bookings;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking History'),
        automaticallyImplyLeading: false,
      ),
      body: bookings.isEmpty
          ? const Center(child: Text('No booking records available.'))
          : ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('From: ${booking.origin.name} to ${booking.destination.name}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Departure: ${booking.departureTime}'),
                        Text('Arrival: ${booking.arrivalTime}'),
                        Text('Price: ${booking.price}'),
                        Text('Number of Passengers: ${booking.numOfPax}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
