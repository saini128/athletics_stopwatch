import 'dart:async';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int sec = 0, min = 0, hrs = 0, ms = 0;
  String digSec = "00", digMin = "00", digHrs = "00", digMS = "00";
  Timer? timer;
  bool started = false;
  List laps = [];
  List revLaps = [];

  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  void reset() {
    timer!.cancel();
    laps = [];
    setState(() {
      sec = 0;
      min = 0;
      hrs = 0;
      ms = 0;
      digHrs = "00";
      digMin = "00";
      digSec = "00";
      digMS = "00";
      started = false;
    });
  }

  void addLaps() {
    String lap = "$digMin:$digSec:$digMS";
    setState(() {
      laps.add(lap);
      revLaps = new List.from(laps.reversed);
    });
  }

  void start() {
    started = true;
    timer = Timer.periodic(Duration(milliseconds: 20), (timer) {
      int localMS = ms + 20;
      int localSec = sec;
      int localMin = min;

      if (localMS > 980) {
        if (localSec > 59) {
          localMin++;
          localSec = 0;
        } else {
          localSec++;
          localMS = 0;
        }
      }
      setState(() {
        ms = localMS;
        sec = localSec;
        min = localMin;
        digSec = (sec >= 10) ? "$sec" : "0$sec";
        digMin = (min >= 10) ? "$min" : "0$min";
        digMS = (ms >= 100) ? "$ms".substring(0, 2) : "0$ms".substring(0, 2);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 4, 131),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'StopWatch',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "$digMin:$digSec:$digMS",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: ListView.builder(
                  itemCount: laps.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Lap ${laps.length - index}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "${revLaps[index]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RawMaterialButton(
                    onPressed: () {
                      (!started) ? start() : stop();
                    },
                    shape: const StadiumBorder(
                      side: BorderSide(color: Colors.blue),
                    ),
                    child: Text(
                      (!started) ? "Start" : "Stop",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                IconButton(
                    color: Colors.white,
                    onPressed: () {},
                    icon: Icon(Icons.flag)),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: RawMaterialButton(
                    onPressed: () {
                      (!started) ? reset() : addLaps();
                    },
                    fillColor: Colors.blue,
                    shape: const StadiumBorder(),
                    child: Text(
                      (!started) ? "Reset" : "Lap",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
