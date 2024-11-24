import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/train_provider.dart';

class SeatSelectionScreen extends StatelessWidget {
  final String trainId;
  final String coachNumber;

  SeatSelectionScreen({
    required this.trainId,
    required this.coachNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Seat')),
      body: Consumer<TrainProvider>(
        builder: (context, trainProvider, child) {
          final train = trainProvider.trains.firstWhere((train) => train.id == trainId);
          final coach = train.coaches.firstWhere((coach) => coach.number == coachNumber);

          return ListView.builder(
            itemCount: coach.seats.length,
            itemBuilder: (context, index) {
              final seat = coach.seats[index];
              return ListTile(
                title: Text('Seat ${seat.number}'),
                trailing: seat.isLocked ? Icon(Icons.lock) : null,
                onTap: () {
                  if (!seat.isLocked) {
                    trainProvider.lockSeat(trainId, coachNumber, seat.id);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
