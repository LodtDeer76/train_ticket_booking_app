import 'package:flutter/material.dart';
import 'train_detail_screen.dart';
import '../models/location.dart';

class BookingScreen extends StatefulWidget {
  final Location origin;
  final Location destination;
  final int numOfPax;

  const BookingScreen({Key? key, required this.origin, required this.destination, required this.numOfPax}) : super(key: key);

  @override
  BookingScreenState createState() => BookingScreenState();
}

class BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booking')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.origin.name} ➡️ ${widget.destination.name}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildTrainDetailRow('05:00 am', '12:00 pm', widget.origin.station, widget.destination.station, 'RM 50'),
                  _buildTrainDetailRow('06:00 am', '01:00 pm', widget.origin.station, widget.destination.station, 'RM 55'),
                  _buildTrainDetailRow('07:00 am', '02:00 pm', widget.origin.station, widget.destination.station, 'RM 60'),
                  _buildTrainDetailRow('08:00 am', '03:00 pm', widget.origin.station, widget.destination.station, 'RM 65'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrainDetailRow(String departureTime, String arrivalTime, String from, String to, String price) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$departureTime - $arrivalTime', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                _buildStationText(from, to),
              ],
            ),
            Row(
              children: [
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TrainDetailScreen(
                          origin: widget.origin,
                          destination: widget.destination,
                          numOfPax: widget.numOfPax,
                          price: price,
                          departureTime: departureTime,
                          arrivalTime: arrivalTime,
                        ),
                      ),
                    );
                  },
                  child: const Text('Select'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStationText(String from, String to) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: '$from\n', style: const TextStyle(fontSize: 14, color: Colors.black)),
          TextSpan(text: '➡️ $to', style: const TextStyle(fontSize: 14, color: Colors.black)),
        ],
      ),
    );
  }
}
