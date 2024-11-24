import 'package:flutter/foundation.dart';
import '../models/location.dart';

class Booking {
  final Location origin;
  final Location destination;
  final int numOfPax;
  final String price;
  final String departureTime;
  final String arrivalTime;

  Booking({
    required this.origin,
    required this.destination,
    required this.numOfPax,
    required this.price,
    required this.departureTime,
    required this.arrivalTime,
  });
}

class BookingProvider with ChangeNotifier {
  final List<Booking> _bookings = [];

  List<Booking> get bookings => List.unmodifiable(_bookings);

  void addBooking(Booking booking) {
    _bookings.add(booking);
    notifyListeners();
  }
}
