import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wallet/services/card.service.dart';
import 'package:wallet/widgets/credit_card.dart';
import 'package:wallet/widgets/page_view_cards.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

class CreditCards extends StatefulWidget {
  CreditCards({Key key}) : super(key: key);

  @override
  _CreditCardsState createState() => _CreditCardsState();
}

class _CreditCardsState extends State<CreditCards>
    with TickerProviderStateMixin {
  CardServices _service = CardServices();
  GlobalKey _card = GlobalKey();
  GlobalKey _animCard = GlobalKey();
  GlobalKey _selectedCard = GlobalKey();

  int _currentCard = 0;
  AnimCardPositions _position = new AnimCardPositions();

  AnimationController controller;
  SequenceAnimation sequenceAnimation;

  AnimationController bgController;
  SequenceAnimation bgSequenceAnimation;

  // Widget MovingCardWidget;
  Widget CCWidget;
  Widget CCBGWidget;
  LinearGradient _oldBgLinearGradient;

  Function _selectCard(index) {
    // // selected card
    final RenderBox __cardFromScrollView =
        _selectedCard.currentContext.findRenderObject();
    final __cardFromScrollViewPosition =
        __cardFromScrollView.localToGlobal(Offset.zero);
    final __cardFromScrollViewSize = __cardFromScrollView.size;

    final RenderBox __cardFromStaticView =
        _card.currentContext.findRenderObject();
    final __cardFromStaticViewPosition =
        __cardFromStaticView.localToGlobal(Offset.zero);
    final __cardFromStaticViewSize = __cardFromStaticView.size;

    _position.start_dy = __cardFromScrollViewPosition.dy;
    _position.start_dx = __cardFromScrollViewPosition.dx;
    _position.start_width = __cardFromScrollViewSize.width;
    _position.start_height = __cardFromScrollViewSize.height;

    _position.end_dy = __cardFromStaticViewPosition.dy;
    _position.end_dx = __cardFromStaticViewPosition.dx;
    _position.end_width = __cardFromStaticViewSize.width;
    _position.end_height = __cardFromStaticViewSize.height;
    _currentCard = index.toInt();

    // // anim card positioning
    setState(() {
      Timer(Duration(milliseconds: 500), () {
        CCWidget = CreditCard(_service.getCardByIndex(_currentCard));
        CCBGWidget =
            _service.getCardByIndex(_currentCard).backgroundGradientReverse();
        controller.reset();
        controller.forward();

        //
        _oldBgLinearGradient =
            _service.getCardByIndex(_currentCard).backgroundLinearGradient();
      });

      bgController.reset();
      bgController.forward();
    });
  }

  @override
  void initState() {
    super.initState();

    // card animation
    controller = AnimationController(vsync: this);
    sequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
            animatable: Tween<double>(begin: 0, end: 1),
            from: const Duration(milliseconds: 0),
            to: const Duration(milliseconds: 50),
            tag: 'fade')
        .animate(controller);

    controller.reset();
    controller.forward();

    // background animation
    bgController = AnimationController(vsync: this);
    bgSequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
            animatable: Tween<double>(begin: 0, end: 1),
            from: const Duration(milliseconds: 0),
            to: const Duration(milliseconds: 500),
            tag: 'fade')
        .animate(bgController);

    bgController.reset();
    bgController.forward();

    // select default card
    CCWidget = CreditCard(_service.getCardByIndex(_currentCard));
    CCBGWidget =
        _service.getCardByIndex(_currentCard).backgroundGradientReverse();
    _oldBgLinearGradient =
        _service.getCardByIndex(_currentCard).backgroundLinearGradient();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: _oldBgLinearGradient,
      ),
      child: Stack(
        children: <Widget>[
          AnimatedBuilder(
            animation: bgController,
            builder: (context, child) => Opacity(
              opacity: bgSequenceAnimation['fade'].value,
              child: CCBGWidget,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          Positioned(
            top: 50,
            left: 25,
            right: 25,
            child: AnimatedBuilder(
              animation: controller,
              key: _card,
              builder: (context, child) => Opacity(
                opacity: sequenceAnimation['fade'].value,
                child: CCWidget,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 25,
            right: 25,
            child: pageViewCards(_selectedCard, _selectCard),
          ),
          Builder(
            builder: (BuildContext context) {
              if (_position.end_width > 0) {
                return new MovingCard(_currentCard, _position);
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}

class MovingCard extends StatefulWidget {
  int selectedCardIndex;
  AnimCardPositions _position;

  MovingCard(this.selectedCardIndex, this._position);

  @override
  _MovingCardState createState() => _MovingCardState();
}

class _MovingCardState extends State<MovingCard> with TickerProviderStateMixin {
  AnimationController controller;
  SequenceAnimation sequenceAnimation;
  CardServices _service = CardServices();

  @override
  void initState() {
    super.initState();

    const int _animTime = 500;
    controller = AnimationController(vsync: this);
    sequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
            animatable: Tween<double>(begin: 0, end: widget._position.start_dy),
            from: const Duration(milliseconds: 0),
            to: const Duration(milliseconds: 1),
            curve: Curves.easeInOutQuint,
            tag: 'position-top')
        .addAnimatable(
            animatable:
                Tween<double>(begin: 0, end: widget._position.start_height),
            from: const Duration(milliseconds: 0),
            to: const Duration(milliseconds: 1),
            tag: 'height')
        .addAnimatable(
            animatable:
                Tween<double>(begin: 0, end: widget._position.start_width),
            from: const Duration(milliseconds: 0),
            to: const Duration(milliseconds: 1),
            tag: 'width')
        .addAnimatable(
            animatable: Tween<double>(begin: 0, end: 1),
            from: const Duration(milliseconds: 1),
            to: const Duration(milliseconds: 2),
            tag: 'fade')
        .addAnimatable(
            animatable: Tween<double>(
                begin: widget._position.start_height,
                end: widget._position.end_height),
            from: const Duration(milliseconds: 2),
            to: const Duration(milliseconds: _animTime),
            tag: 'height')
        .addAnimatable(
            animatable: Tween<double>(
                begin: widget._position.start_width,
                end: widget._position.end_width),
            from: const Duration(milliseconds: 2),
            to: const Duration(milliseconds: _animTime),
            tag: 'width')
        .addAnimatable(
            animatable: Tween<double>(
                begin: widget._position.start_dy, end: widget._position.end_dy),
            from: const Duration(milliseconds: 2),
            to: const Duration(milliseconds: _animTime),
            curve: Curves.easeInOutQuint,
            tag: 'position-top')
        .addAnimatable(
            animatable: Tween<double>(begin: 1, end: 0),
            from: const Duration(milliseconds: _animTime),
            to: const Duration(milliseconds: _animTime + 100),
            tag: 'fade')
        .animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.reset();
    controller.forward();

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Positioned(
        top: sequenceAnimation['position-top'].value,
        left: 25.0,
        child: Opacity(
          opacity: sequenceAnimation['fade'].value,
          child: Container(
            height: sequenceAnimation['height'].value,
            width: sequenceAnimation['width'].value,
            child:
                CreditCard(_service.getCardByIndex(widget.selectedCardIndex)),
          ),
        ),
      ),
    );

  }
}
