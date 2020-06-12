import 'package:flutter/material.dart';

enum CreditCardType {
  VISA,
  MASTER,
  AMERICAN_EXPRESS,
}

class CardInfo {
  // card info
  final String _cardNo;
  final int _expiresMonth;
  final int _expiresYear;
  final String name;
  final CreditCardType type;

  // theme info
  final String _bgStart;
  final String _bgEnd;
  final String _textColor;

  CardInfo(
    this._cardNo,
    this._expiresMonth,
    this._expiresYear,
    this.name,
    this.type,
    this._bgStart,
    this._bgEnd,
    this._textColor,
  );

  List<String> cardNumber() {
    return _cardNo.split(" ");
  }

  String expires() {
    return "${_expiresMonth} / ${_expiresYear}";
  }

  Color textColor() {
    return _stringToColor(_textColor);
  }

  Color backgroundColor() {
    return _stringToColor(_bgEnd);
  }

  LinearGradient backgroundLinearGradient() {
    return LinearGradient(
      colors: [
        _stringToColor(_bgStart),
        _stringToColor(_bgEnd),
      ],
      begin: Alignment(-1.0, -2.0),
      end: Alignment(1.0, 2.0),
    );
  }

  Widget backgroundGradientReverse() {
    return Container(
      decoration: BoxDecoration(
        gradient: backgroundLinearGradientReverse(),
      ),
    );
  }

  LinearGradient backgroundLinearGradientReverse() {
    return LinearGradient(
          colors: [
            _stringToColor(_bgEnd),
            _stringToColor(_bgStart),
          ],
          begin: Alignment(-1.0, -2.0),
          end: Alignment(1.0, 2.0),
        );
  }

  Color _stringToColor(color) {
    return Color(int.parse("0xff$color"));
  }
}
