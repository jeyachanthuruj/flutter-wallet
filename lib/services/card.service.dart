import 'package:wallet/modals/card_info.dart';

class CardServices {
  List<CardInfo> _cardInfo = [];

  CardServices() {
    _cardInfo.addAll([
      CardInfo(
        "1234 8978 2398 5603",
        11,
        25,
        "F B JEYACHANTHURU",
        CreditCardType.VISA,
        "5576CA",
        "1E4193",
        "ffffff",
      ),
      CardInfo(
        "3456 8978 2398 2345",
        03,
        18,
        "NIRMAL LANKATHILAKA",
        CreditCardType.VISA,
        "00005c",
        "5c2a9d",
        "ffffff",
      ),
      CardInfo(
        "7890 3456 5678 2345",
        01,
        14,
        "ISURO RODRICO",
        CreditCardType.VISA,
        "584153",
        "26191b",
        "ffffff",
      ),
      CardInfo(
        "1234 8978 2398 5603",
        11,
        25,
        "BEN SULIVAN",
        CreditCardType.VISA,
        "c70039",
        "ff5733",
        "ffffff",
      ),
      CardInfo(
        "1234 8978 2398 5603",
        11,
        25,
        "MADUKA JAYALATH",
        CreditCardType.VISA,
        "9c5518",
        "5a3f11",
        "ffffff",
      ),
      CardInfo(
        "3456 3456 3456 3456",
        11,
        25,
        "ARJUNA DILAN",
        CreditCardType.VISA,
        "204051",
        "3b6978",
        "ffffff",
      ),
    ]);
  }

  List<CardInfo> getCards() {
    return _cardInfo;
  }

  CardInfo getCard() {
    return _cardInfo.first;
  }

  CardInfo getCardByIndex(int index) {
    return _cardInfo[index];
  }
}

class AnimCardPositions {
  double start_width = 0;
  double start_height = 0;
  double start_dx = 0;
  double start_dy = 0;

  double end_width = 0;
  double end_height = 0;
  double end_dx = 0;
  double end_dy = 0;

  // double start_width = 325.0;
  // double start_height = 170.05813953488374;
  // double start_dx = 25.0;
  // double start_dy = 529.4418604651163;

  // double end_width = 375.0;
  // double end_height = 254.06976744186048;
  // double end_dx = 0;
  // double end_dy = 50.0;
}
