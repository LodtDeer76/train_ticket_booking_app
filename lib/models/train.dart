class Train {
  final String id;
  final String number;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final List<Coach> coaches;

  Train({
    required this.id,
    required this.number,
    required this.departureTime,
    required this.arrivalTime,
    required this.coaches,
  });
}

class Coach {
  final String number;
  final List<Seat> seats;

  Coach({required this.number, required this.seats});
}

class Seat {
  final String id;
  final String number;
  bool isLocked;

  Seat({
    required this.id,
    required this.number,
    this.isLocked = false,
  });
}
