import 'package:flutter/material.dart';
import '../models/dialogs.dart';
import '../models/location.dart';
import 'package:tuple/tuple.dart';
import '../screens/booking_summary_screen.dart';

class TrainDetailScreen extends StatefulWidget {
  final Location origin;
  final Location destination;
  final int numOfPax;
  final String price;
  final String departureTime;
  final String arrivalTime;

  const TrainDetailScreen({
    super.key,
    required this.origin,
    required this.destination,
    required this.numOfPax,
    required this.price,
    required this.departureTime,
    required this.arrivalTime,
  });

  @override
  TrainDetailScreenState createState() => TrainDetailScreenState();
}

class TrainDetailScreenState extends State<TrainDetailScreen> {
  int _selectedCoachIndex = 0;
  final Set<Tuple2<int, int>> _selectedSeats = {};

  final List<List<bool>> _seats =
      List.generate(6, (index) => List.generate(20, (index) => false));

  final ScrollController _scrollController = ScrollController();
  final double _coachHeight = 400.0;

  void _scrollToSelectedCoach() {
    _scrollController.animateTo(
      _selectedCoachIndex * _coachHeight,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  void _navigateToBookingSummary() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BookingSummaryScreen(
          origin: widget.origin,
          destination: widget.destination,
          numOfPax: widget.numOfPax,
          price: widget.price,
          departureTime: widget.departureTime,
          arrivalTime: widget.arrivalTime,
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => Dialogs(
        type: DialogType.error,
        message: message,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Train Details')),
      body: Stack(
        children: [
          Column(
            children: [
              _buildCoachSelector(),
              _buildCoachView(),
            ],
          ),
          if (_selectedSeats.isNotEmpty) _buildProceedButton(),
        ],
      ),
    );
  }

  Widget _buildCoachSelector() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _selectedCoachIndex == index ? Colors.blue : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _selectedCoachIndex = index;
                });
                _scrollToSelectedCoach();
              },
              child: Text('Coach ${index + 1}'),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCoachView() {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: 6,
        itemBuilder: (context, coachIndex) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.symmetric(vertical: 16),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Coach ${coachIndex + 1}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _buildSeatGrid(coachIndex),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSeatGrid(int coachIndex) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.5,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemCount: 20,
      itemBuilder: (context, seatIndex) {
        bool isSelected = _selectedSeats.contains(Tuple2(coachIndex, seatIndex));
        bool isOccupied = _seats[coachIndex][seatIndex];
        return GestureDetector(
          onTap: !isOccupied
              ? () {
                  if (_selectedSeats.length >= widget.numOfPax && !isSelected) {
                    _showErrorDialog(
                        "Only allowed to select up to ${widget.numOfPax} seats");
                  } else {
                    setState(() {
                      if (isSelected) {
                        _selectedSeats.remove(Tuple2(coachIndex, seatIndex));
                      } else {
                        _selectedSeats.add(Tuple2(coachIndex, seatIndex));
                      }
                    });
                  }
                }
              : null,
          child: Container(
            margin: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: isOccupied
                  ? Colors.grey
                  : isSelected
                      ? Colors.green
                      : Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: isOccupied
                  ? const Icon(Icons.person, color: Colors.white)
                  : isSelected
                      ? const Icon(Icons.check, color: Colors.white)
                      : Text('${seatIndex + 1}'),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProceedButton() {
    return Positioned(
      bottom: 16,
      left: MediaQuery.of(context).size.width * 0.5 - 75,
      child: ElevatedButton(
        onPressed: _navigateToBookingSummary,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        child: const Text('Proceed to Booking'),
      ),
    );
  }
}
