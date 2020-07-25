import 'dart:io';
import 'package:Walls/rating/smiley_painter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:Walls/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:Walls/sidebar/menu_item.dart';
import 'package:Walls/rating/launch_review.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:wiredash/wiredash.dart';
class SideBar extends StatefulWidget {

  @override
  _SideBarState createState() => _SideBarState();
 
}

class _SideBarState extends State<SideBar> with SingleTickerProviderStateMixin{
   String coffee_button = 'coffee_button';
   String tenrs ='tenrs';
  /// Is the API available on the device
  bool available = true;

  /// The In App Purchase plugin
  InAppPurchaseConnection _iap = InAppPurchaseConnection.instance;

  /// Products for sale
  List<ProductDetails> _products = [];

  /// Past purchases
  List<PurchaseDetails> _purchases = [];

  /// Updates to purchases
  StreamSubscription _subscription;


  AnimationController _animationController ;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  
  final _animationDuration = const Duration(milliseconds: 500);



  @override
  void initState() {
    _initialize();
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;


  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    _subscription.cancel();
    super.dispose();
  }

  void _initialize() async {
    // Check availability of In App Purchases
    available = await _iap.isAvailable();

    if (available) {
      await _getProducts();
      await _getPastPurchases();

      // Verify and deliver a purchase with your own business logic
      _verifyPurchase();
    }
    _subscription = _iap.purchaseUpdatedStream.listen((data) => setState(() {
      print('NEW PURCHASE');
      _purchases.addAll(data);
      _verifyPurchase();
    }));
  }

  void _buyProduct(ProductDetails prod) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: prod);
     _iap.buyNonConsumable(purchaseParam: purchaseParam);
   // _iap.buyConsumable(purchaseParam: purchaseParam, autoConsume: false);
  }

  Future<void> _getProducts() async {
    Set<String> ids = Set.from([coffee_button]);
    ProductDetailsResponse response = await _iap.queryProductDetails(ids);

    setState(() {
      _products = response.productDetails;
      _products.sort((a, b) => a.title.length.compareTo(b.title.length));
    });
  }

  /// Gets past purchases
  Future<void> _getPastPurchases() async {
    QueryPurchaseDetailsResponse response =
    await _iap.queryPastPurchases();

    for (PurchaseDetails purchase in response.pastPurchases) {
      if (Platform.isIOS) {
        InAppPurchaseConnection.instance.completePurchase(purchase);
      }
    }

    setState(() {
      _purchases = response.pastPurchases;
    });
  }

  /// Returns purchase of specific product ID
  PurchaseDetails _hasPurchased(String productID) {
    return _purchases.lastWhere((purchase) => purchase.productID == productID, orElse: () => null);
  }

  /// Your own business logic to setup a consumable
  void _verifyPurchase() {
    PurchaseDetails purchase = _hasPurchased(coffee_button);
    // TODO serverside verification & record consumable in the database

    if (purchase != null && purchase.status == PurchaseStatus.purchased) {

     // _credits = 10;
    }
  }




void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if(isAnimationCompleted)
      {
        isSidebarOpenedSink.add(false);
        _animationController.reverse();
      }
    else
      {
        isSidebarOpenedSink.add(true);
        _animationController.forward();
      }
}
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    int _counter =0;
    void _incrementCounter()
    {
      setState(
              (){
            _counter++;
          }
      );
      Wiredash.of(context).show();
    }

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSidebarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSidebarOpenedAsync.data ? 0 : - screenWidth,
          right: isSidebarOpenedAsync.data ? 0 : screenWidth - 45,
          child: Row(
            children: <Widget>[
              Expanded(child: Container(
                alignment: Alignment.topLeft,
                color: Colors.black,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 100,),
                    ListTile(
                      title: Text("Walls", style: TextStyle(
                        color: Colors.white,
                        fontSize: 30, fontWeight: FontWeight.w800)),
                      subtitle: Text("by Naveen Jujaray", style: TextStyle(
                          color: Color(0xFF1BB5FD), fontSize: 20,
                      ),),
                      leading:
                        Image.asset(
                          "assets/icons/w.png",
                        ),
                    ),
                    Divider(
                      height: 64,
                      thickness: 0.5,
                      color: Colors.white.withOpacity(0.3),
                      indent: 32,
                      endIndent: 32,
                    ),
                    MenuItem(
                      icon: Icons.home,
                      title: "Home",
                      onTap: () {
                        onIconPressed();
                        BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageClickedEvent);
                      },
                    ), //home
                   // MenuItem(
                     // icon: Icons.settings,
                      // title: "Settings",
                      // onTap: () {
                        // onIconPressed();
                        // BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.SettingsPageClickedEvent);
                      // },
                    // ),//Settings
                   // MenuItem(
                     // icon: Icons.library_books,
                     // title: "Feedback",
                    //  onTap: () {
                      //  onIconPressed:
                    //    BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.BlogPageClickedEvent);
                    //  },
                   // ),//About Me
                   // MenuItem(
                     // icon: Icons.vpn_key,
                      //title: "Login",
                      //onTap: () {
                        //onIconPressed();
                        //BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.LoginPageClickedEvent);
                      //},
                    //),//About Me
                    MenuItem(
                      icon: Icons.star,
                      title: "Rate",
                      onTap: () {
                        onIconPressed();
                        showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (context) => SmileyRatingDialog(
                              title: Text('Rate Walls',style: TextStyle(color: Colors.white),),
                              starColor: Colors.yellow,
                              isRoundedButtons: true,
                              positiveButtonText: 'Ok',
                              negativeButtonText: 'Cancel',
                              positiveButtonColor: Colors.blueAccent,
                              negativeButtonColor: Colors.grey,
                              onCancelPressed: () => Navigator.pop(context),
                              onSubmitPressed: (rating)  { LaunchReview.launch(
                                androidAppId: "com.naveenjujaray.walls",
                              ); },
                            ));
                      },
                    ),

                    //MenuItem(
                      //icon: Icons.person,
                 //     title: "About Me",
                   //   onTap: () {
                  //      onIconPressed();
                    //    BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.AboutPageClickedEvent);
                  //    },
                 //   ),//About Me
                    SizedBox(height: 20,),
                        RaisedButton(
                          splashColor: Colors.green,
                          color: Colors.blueAccent,
                          colorBrightness: Brightness.dark,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                            side: BorderSide(color: Colors.black),
                          ),
                          onPressed: () => {
                          for(var prod in _products){
                            Text(prod.title, style: Theme.of(context).textTheme.headline),
                            Text(prod.description),
                             Text(prod.price,
                                 style: TextStyle(color: Colors.greenAccent, fontSize: 60)),
                            _buyProduct(prod),},
                          },
                          padding: EdgeInsets.all(13.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              Icon(FontAwesomeIcons.mugHot,),
                              SizedBox(width: 10,),
                              Text("Buy me coffee",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 20),),
                            ],
                          ),
                        )




                  ],
                ),

              ),),
              Align(
                alignment: Alignment(0, -0.9),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 110,
                      color: Colors.black,
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        icon: AnimatedIcons.menu_close,
                        progress: _animationController.view,
                        color: Colors.white ,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              )

            ],
          ),
        );
      },

    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
   Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width-1, height/2 - 20, width, height/2);
    path.quadraticBezierTo(width+1, height/2 + 20, 10, height-16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }

}

class SmileyRatingDialog extends StatefulWidget{

  // Color of star buttons
  final Color starColor;

  // Called when positive button is clicked
  final ValueSetter<int> onSubmitPressed;

  // Called when negative button is clicked
  final VoidCallback onCancelPressed;

  // Text of Positive Button
  final String positiveButtonText;

  // Text of Positive Button
  final String negativeButtonText;

  // Color of Positive Button
  final Color positiveButtonColor;

  // Color of Positive Button
  final Color negativeButtonColor;

  // Title of Dialog
  final Widget title;

  // Whether the corners of the buttons should be rounded or not
  final bool isRoundedButtons;

  SmileyRatingDialog(
      {this.starColor = Colors.yellow,
        this.title,
        @required this.onSubmitPressed,
        @required this.onCancelPressed,
        @required this.positiveButtonText,
        @required this.negativeButtonText,
        this.isRoundedButtons = true,
        this.positiveButtonColor = Colors.amber,
        this.negativeButtonColor = Colors.amber});

  @override
  _SmileyRatingDialogState createState() => _SmileyRatingDialogState();
}

class _SmileyRatingDialogState extends State<SmileyRatingDialog> {
  int _rating = 0;

  List<Widget> _starWidgets() {
    List<Widget> buttons = [];

    for (int rateValue = 1; rateValue <= 5; rateValue++) {
      final starRatingButton = IconButton(
          icon: Icon(_rating >= rateValue ? Icons.star : Icons.star_border,
              color: widget.starColor, size: 35),
          onPressed: () {
            setState(() {
              _rating = rateValue;
            });
          });
      buttons.add(starRatingButton);
    }

    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: widget.title,
      contentPadding: EdgeInsets.all(20.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 100.0,
            height: 100.0,
            child: CustomPaint(
              painter: SmileyPainter(rating: _rating),
            ),
          ),
          Row(children: _starWidgets()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        widget.isRoundedButtons ? 4.0 : 0.0)),
                color: widget.positiveButtonColor,
                onPressed: () {
                  widget.onSubmitPressed(_rating);
                },
                child: Text(widget.positiveButtonText),
              ),
              FlatButton(
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        widget.isRoundedButtons ? 4.0 : 0.0)),
                color: widget.negativeButtonColor,
                onPressed: () {
                  widget.onCancelPressed();
                },
                child: Text(widget.negativeButtonText),
              ),
            ],
          )
        ],
      ),
    );
  }
}