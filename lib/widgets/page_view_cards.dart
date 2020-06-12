import 'dart:math';
import 'package:flutter/material.dart';
import 'package:wallet/services/card.service.dart';
import 'package:wallet/widgets/credit_card.dart';

class pageViewCards extends StatefulWidget {
  GlobalKey _selectedCard;
  Function _selectCard;
  pageViewCards(this._selectedCard, this._selectCard);

  @override
  _pageViewCardsState createState() => _pageViewCardsState();
}

class _pageViewCardsState extends State<pageViewCards> {
  CardServices _service = CardServices();
  double currentPage = 5.0;

  @override
  Widget build(BuildContext context) {
    int cardsCount = _service.getCards().length;
    PageController controller = PageController(initialPage: cardsCount - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

    return Container(
      child: Stack(
        children: <Widget>[
          CardScrollWidget(currentPage, widget._selectedCard),
          Positioned.fill(
            child: PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: cardsCount,
              controller: controller,
              reverse: false,
              allowImplicitScrolling: true,
              itemBuilder: (contex, index) {
                return GestureDetector(
                  onTap: () {
                    widget._selectCard(controller.page);
                  },
                  child: Container(color: Colors.transparent),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

var cardAspectRatio = 86 / 54;
var widgetAspectRatio = cardAspectRatio * 12 / 10;

class CardScrollWidget extends StatelessWidget {
  var currentPage;
  CardServices _service = CardServices();
  GlobalKey _selectedCard;

  CardScrollWidget(this.currentPage, this._selectedCard);

  @override
  Widget build(BuildContext context) {
    int cardsLength = _service.getCards().length;
    return Container(
      child: new AspectRatio(
        aspectRatio: widgetAspectRatio,
        child: LayoutBuilder(builder: (context, contraints) {
          var width = contraints.maxWidth;
          var height = contraints.maxHeight;
          var widthOfPrimaryCard = width * 0.9;
          var primaryCardLeft = width - widthOfPrimaryCard;
          var horizontalInset = primaryCardLeft / 2;

          List<Widget> cardList = new List();

          for (var i = 0; i < cardsLength; i++) {
            var delta = i - currentPage;
            bool isOnRight = delta > 0;
            var start = max(
                primaryCardLeft -
                    horizontalInset * -delta * (isOnRight ? 15 : 1),
                0.0);
            var gap = 10.0 * max(-delta, 0.0);

            Widget cardItem = Positioned.directional(
              top: start,
              start: gap,
              end: gap,
              key: delta == 0 ? _selectedCard : null,
              textDirection: TextDirection.rtl,
              child: Container(
                height: height,
                width: width,
                child: CreditCard(_service.getCardByIndex(i.round())),
              ),
            );

            cardList.add(cardItem);
          }
          return Stack(
            children: cardList,
          );
        }),
      ),
    );
  }
}
