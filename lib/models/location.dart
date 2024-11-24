enum Location {
  kualaLumpur,
  penang,
  johorBahru,
  ipoh,
  kotaBharu,
}

extension LocationExtension on Location {
  String get name {
    switch (this) {
      case Location.kualaLumpur:
        return 'Kuala Lumpur';
      case Location.penang:
        return 'Penang';
      case Location.johorBahru:
        return 'Johor Bahru';
      case Location.ipoh:
        return 'Ipoh';
      case Location.kotaBharu:
        return 'Kota Bharu';
    }
  }

  String get station { 
    switch (this) { 
      case Location.kualaLumpur: 
        return 'KL Sentral'; 
      case Location.penang: 
        return 'George Town'; 
      case Location.johorBahru: 
        return 'JB Sentral'; 
      case Location.ipoh: 
        return 'Ipoh Station'; 
      case Location.kotaBharu: 
        return 'KB Station'; 
    } 
  }
}
