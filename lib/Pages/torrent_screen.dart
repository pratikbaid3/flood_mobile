import 'package:flood_mobile/Components/add_torrent_sheet.dart';
import 'package:flood_mobile/Components/filter_by_status.dart';
import 'package:flood_mobile/Components/torrent_tile.dart';
import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:flood_mobile/Provider/client_provider.dart';
import 'package:flood_mobile/Provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_reveal/pull_to_reveal.dart';

class TorrentScreen extends StatefulWidget {
  @override
  _TorrentScreenState createState() => _TorrentScreenState();
}

List<String> trackerURIsList = [];

class _TorrentScreenState extends State<TorrentScreen> {
  String keyword = '';

  @override
  Widget build(BuildContext context) {
    double hp = MediaQuery.of(context).size.height;
    double wp = MediaQuery.of(context).size.width;
    return Consumer<HomeProvider>(
      builder: (context, model, child) {
        return Consumer<ClientSettingsProvider>(
            builder: (context, clientModel, child) {
          return KeyboardDismissOnTap(
            child: Scaffold(
              body: Container(
                height: double.infinity,
                width: double.infinity,
                color: ThemeProvider.theme.primaryColor,
                child: (model.torrentList.length != 0)
                    ? PullToRevealTopItemList(
                        itemCount: model.torrentList.length,
                        itemBuilder: (BuildContext context, int index) {
                          trackerURIsList =
                              model.torrentList[index].trackerURIs;
                          if (model.torrentList[index].name
                                      .toLowerCase()
                                      .contains(keyword.toLowerCase()) &&
                                  model.torrentList[index].status.contains(
                                      filterStatus
                                          .toString()
                                          .split(".")
                                          .last) ||
                              model.torrentList[index].trackerURIs
                                  .toString()
                                  .contains(trackerURISelected) ||
                              filterStatus.toString().split(".").last ==
                                  "all") {
                            if (model.torrentList[index].name
                                .toLowerCase()
                                .contains(keyword.toLowerCase())) {
                              return TorrentTile(
                                  model: model.torrentList[index]);
                            }
                          }
                          return Container();
                        },
                        revealableHeight: 165,
                        revealableBuilder: (BuildContext context,
                            RevealableToggler opener,
                            RevealableToggler closer,
                            BoxConstraints constraints) {
                          return Column(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: wp * 0.15,
                                      left: wp * 0.15,
                                      top: hp * 0.01,
                                      bottom: hp * 0.02),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.arrow_upward_rounded,
                                            color: ThemeProvider
                                                .theme.primaryColorDark,
                                            size: 25,
                                          ),
                                          Text(
                                            model.upSpeed,
                                            style: TextStyle(
                                              color: ThemeProvider
                                                  .theme.primaryColorDark,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.arrow_downward_rounded,
                                            color:
                                                ThemeProvider.theme.accentColor,
                                            size: 25,
                                          ),
                                          Text(
                                            model.downSpeed,
                                            style: TextStyle(
                                              color: ThemeProvider
                                                  .theme.accentColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: wp * 0.05,
                                    left: wp * 0.05,
                                    top: 0,
                                    bottom: 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Filter type:',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: ThemeProvider.theme.accentColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      trackerURISelected == 'all' ||
                                              trackerURISelected == 'null' ||
                                              trackerURISelected == ''
                                          ? 'Filter by status'
                                          : 'Filter by trackers',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: ThemeProvider
                                            .theme.primaryColorDark,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: wp * 0.05,
                                    left: wp * 0.05,
                                    top: hp * 0.005,
                                    bottom: hp * 0.02),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Filter selected:',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: ThemeProvider.theme.accentColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      trackerURISelected == 'all' ||
                                              trackerURISelected == 'null' ||
                                              trackerURISelected == ''
                                          ? '${filterStatus.toString().split(".").last}'
                                          : '$trackerURISelected',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: ThemeProvider
                                            .theme.primaryColorDark,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 100,
                                  padding: EdgeInsets.only(
                                      left: wp * 0.05, right: wp * 0.05),
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        keyword = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 15),
                                      hintText: 'Search Torrent',
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.filter_list_alt,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(15),
                                                    topLeft:
                                                        Radius.circular(15),
                                                  ),
                                                ),
                                                isScrollControlled: true,
                                                context: context,
                                                backgroundColor: ThemeProvider
                                                    .theme.backgroundColor,
                                                builder: (context) {
                                                  return FilterByStatus();
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      )
                    : Center(
                        child: SvgPicture.asset(
                          'assets/images/empty_dark.svg',
                          width: 120,
                          height: 120,
                        ),
                      ),
              ),
              floatingActionButton: FloatingActionButton(
                elevation: 0,
                onPressed: () {
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                      ),
                    ),
                    isScrollControlled: true,
                    context: context,
                    backgroundColor: ThemeProvider.theme.backgroundColor,
                    builder: (context) {
                      return AddTorrentSheet(
                          clientSettings: clientModel.clientSettings);
                    },
                  );
                },
                backgroundColor: ThemeProvider.theme.primaryColorDark,
                child: Icon(Icons.add, color: Colors.white),
              ),
            ),
          );
        });
      },
    );
  }
}
