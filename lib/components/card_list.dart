import 'dart:async';

import 'package:flutter/material.dart';

import '../components/air_quality_card.dart';
import '../manager/auto_change_theme.dart';
import '../manager/setup.dart';
import '../models/setup.dart';

class CardList extends StatefulWidget {
  const CardList({
    Key? key,
  }) : super(key: key);

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  final Stream<bool> stream = cardListBackgroundState.stream;

  @override
  void initState() {
    super.initState();
    stream.listen((i) {
      updateState(i);
    });
  }

  void updateState(bool i) {
    if (!mounted) return;
    setState(() {
      imageBackgroud();
    });
  }

  List<AirQualityCard> cards = generateCards();

  BoxDecoration imageBackgroud() {
    return getImageBackgroud();
  }

  Map<String, AirQualityCard> generateMap(List<AirQualityCard> cards) {
    Map<String, AirQualityCard> map = {};
    for (AirQualityCard card in cards) {
      map[card.setup.id] = card;
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: imageBackgroud(),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 28,
            right: 28,
            top: 50,
            bottom: 50,
          ),
          child: ReorderableListView(
            buildDefaultDragHandles: false,
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (cards.length > 1 && oldIndex != newIndex) {
                  cards.insert(newIndex, cards.removeAt(oldIndex));
                  List<Setup> setups = [];
                  for (AirQualityCard card in cards) {
                    setups.add(card.setup);
                  }
                  updateSetupsOrder(setups);
                }
              });
            },
            children: [
              for (AirQualityCard card in cards)
                buildCard(cards.indexOf(card), card)
            ],
          ),
        ));
  }
}

Widget buildCard(int index, AirQualityCard card) {
  return ReorderableDragStartListener(
    key: ValueKey(card),
    index: index,
    child: ListTile(
      key: ValueKey(card),
      subtitle: card,
    ),
  );
}
