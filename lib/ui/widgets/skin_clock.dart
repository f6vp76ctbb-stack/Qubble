/// A running clock for the animated block skins.
///
/// Only an animated skin needs one, and only while it is on screen and the
/// player has not switched to reduced effects — so the ticker starts and
/// stops with [SkinClock.running] instead of costing a frame per vsync for
/// every static skin. Painters take the clock as their `repaint` listenable:
/// a tick repaints the cells without rebuilding a single widget.
library;

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

class SkinClock extends StatefulWidget {
  const SkinClock({super.key, required this.running, required this.builder});

  /// Whether time moves. When false the builder gets no clock, and the cells
  /// draw their still frame.
  final bool running;

  /// Builds the painting subtree. [clock] holds seconds since the clock
  /// started; null while it is not running.
  final Widget Function(BuildContext context, ValueListenable<double>? clock)
  builder;

  @override
  State<SkinClock> createState() => _SkinClockState();
}

class _SkinClockState extends State<SkinClock>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<double> _time = ValueNotifier<double>(0);

  late final Ticker _ticker = createTicker((elapsed) {
    _time.value = elapsed.inMicroseconds / Duration.microsecondsPerSecond;
  });

  @override
  void initState() {
    super.initState();
    _sync();
  }

  @override
  void didUpdateWidget(SkinClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    _sync();
  }

  void _sync() {
    if (widget.running && !_ticker.isActive) {
      _ticker.start();
    } else if (!widget.running && _ticker.isActive) {
      _ticker.stop();
      _time.value = 0;
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    _time.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      widget.builder(context, widget.running ? _time : null);
}
