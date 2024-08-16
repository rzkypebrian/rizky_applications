library flutter_google_places.src;

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';

typedef WidgetFromDataBuilder<T> = Widget Function(T value);

class PlacesAutocompleteWidget extends StatefulWidget {
  final String apiKey;
  final String hint;
  final Location location;
  final num offset;
  final num radius;
  final String language;
  final String sessionToken;
  final List<String> types;
  final List<Component> components;
  final bool strictbounds;
  final String region;
  final Mode mode;
  final Widget logo;
  final ValueChanged<PlacesAutocompleteResponse> onError;
  final ValueChanged<Prediction> onTap;
  final WidgetFromDataBuilder<List<Prediction>> builder;
  final WidgetFromDataBuilder<Prediction> itemBuilder;
  final double heightParent;
  final double heightSearch;

  /// optional - sets 'proxy' value in google_maps_webservice
  ///
  /// In case of using a proxy the baseUrl can be set.
  /// The apiKey is not required in case the proxy sets it.
  /// (Not storing the apiKey in the app is good practice)
  final String proxyBaseUrl;

  /// optional - set 'client' value in google_maps_webservice
  ///
  /// In case of using a proxy url that requires authentication
  /// or custom configuration
  final BaseClient httpClient;
  final WidgetFromDataBuilder<TextEditingController> inputSearchContainer;
  final WidgetFromDataBuilder<Widget> itemContainer;
  final WidgetFromDataBuilder<BuildContext> onEmptyResult;

  PlacesAutocompleteWidget({
    @required this.apiKey,
    this.mode = Mode.fullscreen,
    this.hint = "Search",
    this.offset,
    this.location,
    this.radius,
    this.language,
    this.sessionToken,
    this.types,
    this.components,
    this.strictbounds,
    this.region,
    this.logo,
    this.onError,
    this.onTap,
    Key key,
    this.proxyBaseUrl,
    this.httpClient,
    this.itemBuilder,
    this.inputSearchContainer,
    this.itemContainer,
    this.builder,
    this.onEmptyResult,
    this.heightParent = 400,
    this.heightSearch = 50,
  }) : super(key: key);

  @override
  State<PlacesAutocompleteWidget> createState() {
    if (mode == Mode.fullscreen) {
      return _PlacesAutocompleteScaffoldState();
    }
    return _PlacesAutocompleteOverlayState();
  }

  @Deprecated('Use findAncestorStateOfType instead. '
      'This feature was deprecated after v1.12.1.')
  static PlacesAutocompleteState of(BuildContext context) =>
      context.findAncestorStateOfType<PlacesAutocompleteState>();
}

class _PlacesAutocompleteScaffoldState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    final body = PlacesAutocompleteResult(
      onTap: (prediction) {
        widget.onTap(prediction);
      },
      logo: widget.logo,
      builder: widget.builder,
      itemBuilder: widget.itemBuilder,
      itemContainer: widget.itemContainer,
      onEmptyResult: widget.onEmptyResult,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: widget.heightParent < 50 ? 50 : widget.heightParent,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Container(
              height: widget.heightSearch,
              child: AppBarPlacesAutoCompleteTextField(
                inputSearchContainer: widget.inputSearchContainer,
              ),
            ),
            Expanded(child: body),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}

class _PlacesAutocompleteOverlayState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final header = Column(
      children: <Widget>[
        Material(
            color: theme.dialogBackgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  color: theme.brightness == Brightness.light
                      ? Colors.black45
                      : null,
                  icon: _iconBack,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                    child: Padding(
                  child: _textField(context),
                  padding: const EdgeInsets.only(right: 8.0),
                )),
              ],
            )),
        Divider(
            //height: 1.0,
            )
      ],
    );

    var body;

    if (_searching) {
      body = Stack(
        children: <Widget>[_Loader()],
        alignment: FractionalOffset.bottomCenter,
      );
    } else if (_queryTextController.text.isEmpty ||
        _response == null ||
        _response.predictions.isEmpty) {
      body = Material(
        color: theme.dialogBackgroundColor,
        child: widget.logo ?? PoweredByGoogleImage(),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(2.0),
            bottomRight: Radius.circular(2.0)),
      );
    } else {
      body = SingleChildScrollView(
        child: Material(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(2.0),
            bottomRight: Radius.circular(2.0),
          ),
          color: theme.dialogBackgroundColor,
          child: ListBody(
            children: _response.predictions
                .map(
                  (p) => PredictionTile(
                    prediction: p,
                    onTap: Navigator.of(context).pop,
                  ),
                )
                .toList(),
          ),
        ),
      );
    }

    final container = Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
        child: Stack(children: <Widget>[
          header,
          Padding(padding: EdgeInsets.only(top: 48.0), child: body),
        ]));

    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return Padding(padding: EdgeInsets.only(top: 8.0), child: container);
    }
    return container;
  }

  Icon get _iconBack => Theme.of(context).platform == TargetPlatform.iOS
      ? Icon(Icons.arrow_back_ios)
      : Icon(Icons.arrow_back);

  Widget _textField(BuildContext context) => TextField(
        controller: _queryTextController,
        autofocus: true,
        style: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black87
                : null,
            fontSize: 16.0),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black45
                : null,
            fontSize: 16.0,
          ),
          border: InputBorder.none,
        ),
      );
}

class _Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(maxHeight: 2.0),
        child: LinearProgressIndicator());
  }
}

class PlacesAutocompleteResult extends StatefulWidget {
  final ValueChanged<Prediction> onTap;
  final Widget logo;
  final WidgetFromDataBuilder<List<Prediction>> builder;
  final WidgetFromDataBuilder<Prediction> itemBuilder;
  final WidgetFromDataBuilder<Widget> itemContainer;
  final WidgetFromDataBuilder<BuildContext> onEmptyResult;

  PlacesAutocompleteResult({
    this.onTap,
    this.logo,
    this.itemBuilder,
    this.itemContainer,
    this.builder,
    this.onEmptyResult,
  });

  @override
  _PlacesAutocompleteResult createState() => _PlacesAutocompleteResult();
}

class _PlacesAutocompleteResult extends State<PlacesAutocompleteResult> {
  @Deprecated('Use findAncestorStateOfType instead. '
      'This feature was deprecated after v1.12.1.')
  @override
  Widget build(BuildContext context) {
    final state = PlacesAutocompleteWidget.of(context);
    assert(state != null);

    if (state._queryTextController.text.isEmpty ||
        state._response == null ||
        state._response.predictions.isEmpty) {
      final children = <Widget>[];
      if (state._searching) {
        children.add(_Loader());
      }
      if (widget.onEmptyResult != null) {
        children.add(widget.onEmptyResult(context));
      }
      children.add(widget.logo ?? PoweredByGoogleImage());
      return Stack(children: children);
    }
    return PredictionsListView(
      predictions: state._response.predictions,
      onTap: widget.onTap,
      builder: widget.builder,
      itemBuilder: widget.itemBuilder,
      itemContainer: widget.itemContainer,
    );
  }
}

class AppBarPlacesAutoCompleteTextField extends StatefulWidget {
  final WidgetFromDataBuilder<TextEditingController> inputSearchContainer;

  const AppBarPlacesAutoCompleteTextField({
    Key key,
    this.inputSearchContainer,
  }) : super(key: key);

  @override
  _AppBarPlacesAutoCompleteTextFieldState createState() =>
      _AppBarPlacesAutoCompleteTextFieldState();
}

class _AppBarPlacesAutoCompleteTextFieldState
    extends State<AppBarPlacesAutoCompleteTextField> {
  @Deprecated('Use findAncestorStateOfType instead. '
      'This feature was deprecated after v1.12.1.')
  @override
  Widget build(BuildContext context) {
    final state = PlacesAutocompleteWidget.of(context);
    assert(state != null);

    return Container(
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(15),
          //   topRight: Radius.circular(15),
          // ),
          ),
      child: widget.inputSearchContainer != null
          ? widget.inputSearchContainer(state._queryTextController)
          : TextField(
              controller: state._queryTextController,
              autofocus: true,
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black.withOpacity(0.9)
                    : Colors.white.withOpacity(0.9),
                fontSize: 16.0,
              ),
              decoration: InputDecoration(
                hintText: state.widget.hint,
                filled: true,
                fillColor: Theme.of(context).brightness == Brightness.light
                    ? Colors.white30
                    : Colors.black38,
                hintStyle: TextStyle(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black38
                      : Colors.white30,
                  fontSize: 16.0,
                ),
                border: InputBorder.none,
              ),
            ),
    );
  }
}

class PoweredByGoogleImage extends StatelessWidget {
  // final _poweredByGoogleWhite =
  //     "packages/flutter_google_places/assets/google_white.png";
  // final _poweredByGoogleBlack =
  //     "packages/flutter_google_places/assets/google_black.png";

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Padding(
        padding: EdgeInsets.all(16.0),
        // child: Image.asset(
        //   Theme.of(context).brightness == Brightness.light
        //       ? _poweredByGoogleWhite
        //       : _poweredByGoogleBlack,
        //   scale: 2.5,
        // )
      )
    ]);
  }
}

class PredictionsListView extends StatelessWidget {
  final List<Prediction> predictions;
  final ValueChanged<Prediction> onTap;
  final WidgetFromDataBuilder<List<Prediction>> builder;
  final WidgetFromDataBuilder<Prediction> itemBuilder;
  final WidgetFromDataBuilder<Widget> itemContainer;

  PredictionsListView({
    @required this.predictions,
    this.onTap,
    this.builder,
    this.itemBuilder,
    this.itemContainer,
  });

  @override
  Widget build(BuildContext context) {
    if (builder != null) {
      return builder(predictions);
    } else {
      return itemContainer != null ? itemContainer(itemList()) : itemList();
    }
  }

  Widget itemList() {
    return ListView(
      children: predictions
          .map((Prediction p) => itemBuilder != null
              ? this.itemBuilder(p)
              : PredictionTile(prediction: p, onTap: onTap))
          .toList(),
    );
  }
}

class PredictionTile extends StatelessWidget {
  final Prediction prediction;
  final ValueChanged<Prediction> onTap;

  PredictionTile({@required this.prediction, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.location_on),
      title: Text(prediction.description),
      onTap: () {
        if (onTap != null) {
          onTap(prediction);
        }
      },
    );
  }
}

enum Mode { overlay, fullscreen }

abstract class PlacesAutocompleteState extends State<PlacesAutocompleteWidget> {
  TextEditingController _queryTextController;
  PlacesAutocompleteResponse _response;
  GoogleMapsPlaces _places;
  bool _searching;

  final _queryBehavior = BehaviorSubject<String>.seeded('');

  @override
  void initState() {
    super.initState();
    _queryTextController = TextEditingController(text: "");

    _places = GoogleMapsPlaces(
        apiKey: widget.apiKey,
        baseUrl: widget.proxyBaseUrl,
        httpClient: widget.httpClient);
    _searching = false;

    _queryTextController.addListener(_onQueryChange);

    _queryBehavior.stream
        .debounce(const Duration(milliseconds: 300))
        .listen(doSearch);
  }

  Future<Null> doSearch(String value) async {
    if (mounted && value.isNotEmpty) {
      setState(() {
        _searching = true;
      });

      final res = await _places.autocomplete(
        value,
        offset: widget.offset,
        location: widget.location,
        radius: widget.radius,
        language: widget.language,
        sessionToken: widget.sessionToken,
        types: widget.types,
        components: widget.components,
        strictbounds: widget.strictbounds,
        region: widget.region,
      );

      if (res.errorMessage?.isNotEmpty == true ||
          res.status == "REQUEST_DENIED") {
        onResponseError(res);
      } else {
        onResponse(res);
      }
    } else {
      onResponse(null);
    }
  }

  void _onQueryChange() {
    _queryBehavior.add(_queryTextController.text);
  }

  @override
  void dispose() {
    super.dispose();

    _places.dispose();
    _queryBehavior.close();
    _queryTextController.removeListener(_onQueryChange);
  }

  @mustCallSuper
  void onResponseError(PlacesAutocompleteResponse res) {
    if (!mounted) return;

    if (widget.onError != null) {
      widget.onError(res);
    }
    setState(() {
      _response = null;
      _searching = false;
    });
  }

  @mustCallSuper
  void onResponse(PlacesAutocompleteResponse res) {
    if (!mounted) return;

    setState(() {
      _response = res;
      _searching = false;
    });
  }
}

class PlacesAutocomplete {
  static Future<Prediction> show(
      {@required BuildContext context,
      @required String apiKey,
      Mode mode = Mode.fullscreen,
      String hint = "Search",
      num offset,
      Location location,
      num radius,
      String language,
      String sessionToken,
      List<String> types,
      List<Component> components,
      bool strictbounds,
      String region,
      Widget logo,
      ValueChanged<PlacesAutocompleteResponse> onError,
      String proxyBaseUrl,
      Client httpClient}) {
    final builder = (BuildContext ctx) => PlacesAutocompleteWidget(
        apiKey: apiKey,
        mode: mode,
        language: language,
        sessionToken: sessionToken,
        components: components,
        types: types,
        location: location,
        radius: radius,
        strictbounds: strictbounds,
        region: region,
        offset: offset,
        hint: hint,
        logo: logo,
        onError: onError,
        proxyBaseUrl: proxyBaseUrl,
        httpClient: httpClient);

    if (mode == Mode.overlay) {
      return showDialog(context: context, builder: builder);
    }
    return Navigator.push(context, MaterialPageRoute(builder: builder));
  }
}
