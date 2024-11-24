import 'package:flutter/material.dart';
import '../models/train.dart';

class TrainProvider with ChangeNotifier {
  List<Train> _trains = [
    // Initialize with mock data as needed
  ];

  List<Train> get trains => _trains;

  void lockSeat(String trainId, String coachNumber, String seatId) {
    final train = _trains.firstWhere((train) => train.id == trainId);
    final coach = train.coaches.firstWhere((coach) => coach.number == coachNumber);
    final seat = coach.seats.firstWhere((seat) => seat.id == seatId);

    seat.isLocked = true;
    notifyListeners();
  }

  // Add other methods as needed
}
