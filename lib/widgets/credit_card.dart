import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet/modals/card_info.dart';

class CreditCard extends StatelessWidget {
  TextStyle _default = GoogleFonts.oswald(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      decoration: TextDecoration.none,
      color: Colors.white,
      letterSpacing: 2,
      shadows: <Shadow>[
        Shadow(
          offset: Offset(1.0, 1.0),
          blurRadius: 2.0,
          color: Color.fromARGB(100, 0, 0, 0),
        ),
      ],
    ),
  );

  CardInfo _card;

  CreditCard(this._card);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 86 / 54,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: _card.backgroundLinearGradient(),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Stack(
          children: <Widget>[
            // name
            Positioned(
              bottom: 25,
              left: 25,
              child: Text(
                _card.name,
                style: _default.copyWith(fontSize: 15),
              ),
            ),

            //expiry date
            Positioned(
              bottom: 55,
              left: 25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'EXPIRES',
                    style: _default.copyWith(fontSize: 7),
                  ),
                  Text(
                    _card.expires(),
                    style: _default.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),

            // type master/visa
            Positioned(
              bottom: 25,
              right: 25,
              child: Container(
                height: 35,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
            ),

            //card no
            Positioned(
              bottom: 95,
              left: 25,
              right: 0,
              child: Row(
                children: <Widget>[
                  Text(
                    _card.cardNumber()[0],
                    style: _default.copyWith(fontSize: 16),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    _card.cardNumber()[1],
                    style: _default.copyWith(fontSize: 16),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    _card.cardNumber()[2],
                    style: _default.copyWith(fontSize: 16),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    _card.cardNumber()[3],
                    style: _default.copyWith(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
