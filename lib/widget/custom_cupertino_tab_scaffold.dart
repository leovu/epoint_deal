part of widget;

class CustomCupertinoTabController extends ChangeNotifier {
  /// Creates a [CupertinoTabController] to control the tab index of [CupertinoTabScaffold]
  /// and [CupertinoTabBar].
  ///
  /// The [initialIndex] must not be null and defaults to 0. The value must be
  /// greater than or equal to 0, and less than the total number of tabs.
  CustomCupertinoTabController({ int initialIndex = 0, required this.length})
      : _index = initialIndex,
        assert(initialIndex >= 0);

  final int length;

  bool _isDisposed = false;

  /// The index of the currently selected tab.
  ///
  /// Changing the value of [index] updates the actively displayed tab of the
  /// [CupertinoTabScaffold] controlled by this [CupertinoTabController], as well
  /// as the currently selected tab item of its [CupertinoTabScaffold.tabBar].
  ///
  /// The value must be greater than or equal to 0, and less than the total
  /// number of tabs.
  int get index => _index;
  int _index;
  set index(int value) {
    assert(value >= 0);
    if (_index == value) {
      return;
    }
    _index = value;
    notifyListeners();
  }

  otherIndex(){
    if (_index == length) {
      return;
    }
    _index =  length;
    notifyListeners();
  }
  otherPageIndex(){
    if (_index == length+1) {
      return;
    }
    _index = length+1;
    notifyListeners();
  }

  @mustCallSuper
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}

class CustomCupertinoTabScaffold extends StatefulWidget {
  /// Creates a layout for applications with a tab bar at the bottom.
  ///
  /// The [tabBar] and [tabBuilder] arguments must not be null.
  CustomCupertinoTabScaffold({
    Key? key,
    required this.tabBar,
    this.tabBuilder,
    this.otherBuilder,this.otherPage,
    this.controller,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.popWhenIndexChange = false
  }) : super(key: key);

  final CustomCupertinoTabBar tabBar;

  /// Controls the currently selected tab index of the [tabBar], as well as the
  /// active tab index of the [tabBuilder]. Providing a different [controller]
  /// will also update the scaffold's current active index to the new controller's
  /// index value.
  ///
  /// Defaults to null.
  final CustomCupertinoTabController? controller;

  /// An [IndexedWidgetBuilder] that's called when tabs become active.
  ///
  /// The widgets built by [IndexedWidgetBuilder] are typically a
  /// [CupertinoTabView] in order to achieve the parallel hierarchical
  /// information architecture seen on iOS apps with tab bars.
  ///
  /// When the tab becomes inactive, its content is cached in the widget tree
  /// [Offstage] and its animations disabled.
  ///
  /// Content can slide under the [tabBar] when they're translucent.
  /// In that case, the child's [BuildContext]'s [MediaQuery] will have a
  /// bottom padding indicating the area of obstructing overlap from the
  /// [tabBar].
  ///
  /// Must not be null.
  final IndexedWidgetBuilder? tabBuilder;
  final Widget? otherBuilder;
  final Widget? otherPage;

  /// The color of the widget that underlies the entire scaffold.
  ///
  /// By default uses [CupertinoTheme]'s `scaffoldBackgroundColor` when null.
  final Color? backgroundColor;

  /// Whether the [child] should size itself to avoid the window's bottom inset.
  ///
  /// For example, if there is an onscreen keyboard displayed above the
  /// scaffold, the body can be resized to avoid overlapping the keyboard, which
  /// prevents widgets inside the body from being obscured by the keyboard.
  ///
  /// Defaults to true and cannot be null.
  final bool resizeToAvoidBottomInset;

  final bool popWhenIndexChange;

  @override
  _CupertinoTabScaffoldState createState() => _CupertinoTabScaffoldState();
}

class _CupertinoTabScaffoldState extends State<CustomCupertinoTabScaffold> {
  CustomCupertinoTabController? _controller;

  @override
  void initState() {
    super.initState();
    _updateTabController();
  }

  void _updateTabController({ bool shouldDisposeOldController = false }) {
    final CustomCupertinoTabController newController =
    // User provided a new controller, update `_controller` with it.
    widget.controller
        ?? CustomCupertinoTabController(initialIndex: widget.tabBar.currentIndex, length: widget.tabBar.items.length);

    if (newController == _controller) {
      return;
    }

    if (shouldDisposeOldController) {
      _controller?.dispose();
    } else if (_controller?._isDisposed == false) {
      _controller!.removeListener(_onCurrentIndexChange);
    }

    newController.addListener(_onCurrentIndexChange);
    _controller = newController;
  }

  void _onCurrentIndexChange() {
    assert(
    _controller!.index >= 0,
    "The $runtimeType's current index ${_controller!.index} is "
        'out of bounds for the tab bar with ${widget.tabBar.items.length} tabs'
    );

    // The value of `_controller.index` has already been updated at this point.
    // Calling `setState` to rebuild using `_controller.index`.
    setState(() {});
  }

  @override
  void didUpdateWidget(CustomCupertinoTabScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _updateTabController(shouldDisposeOldController: oldWidget.controller == null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData existingMediaQuery = MediaQuery.of(context);
    MediaQueryData newMediaQuery = MediaQuery.of(context);

    Widget content = widget.tabBuilder == null?Container():_TabSwitchingView(
      currentTabIndex: _controller!.index,
      tabCount: widget.tabBar.items.length,
      tabBuilder: widget.tabBuilder!,
      otherBuilder: widget.otherBuilder,otherPage: widget.otherPage,
    );
    EdgeInsets contentPadding = EdgeInsets.zero;

    if (widget.resizeToAvoidBottomInset) {
      // Remove the view inset and add it back as a padding in the inner content.
      newMediaQuery = newMediaQuery.removeViewInsets(removeBottom: true);
      contentPadding = EdgeInsets.only(bottom: existingMediaQuery.viewInsets.bottom);
    }

    if ((!widget.resizeToAvoidBottomInset ||
            widget.tabBar.preferredSize.height > existingMediaQuery.viewInsets.bottom)) {
      // TODO(xster): Use real size after partial layout instead of preferred size.
      // https://github.com/flutter/flutter/issues/12912
      final double bottomPadding = widget.tabBar.preferredSize.height + existingMediaQuery.padding.bottom;
          // widget.tabBar.preferredSize.height + existingMediaQuery.padding.bottom;

      // If tab bar opaque, directly stop the main content higher. If
      // translucent, let main content draw behind the tab bar but hint the
      // obstructed area.
      if (widget.tabBar.opaque(context)) {
        contentPadding = EdgeInsets.only(bottom: bottomPadding);
      } else {
        newMediaQuery = newMediaQuery.copyWith(
          padding: newMediaQuery.padding.copyWith(
            bottom: bottomPadding,
          ),
        );
      }
    }

    content = MediaQuery(
      data: newMediaQuery,
      child: Padding(
        padding: contentPadding,
        child: content,
      ),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: widget.backgroundColor != null
            ? CupertinoDynamicColor.resolve(widget.backgroundColor!, context)
            : CupertinoTheme.of(context).scaffoldBackgroundColor,
      ),
      child: Stack(
        children: <Widget>[
          // The main content being at the bottom is added to the stack first.
          content,
          MediaQuery(
            data: existingMediaQuery.copyWith(textScaler: TextScaler.linear(1),),
            child: Align(
              alignment: Alignment.bottomCenter,
              // Override the tab bar's currentIndex to the current tab and hook in
              // our own listener to update the [_controller.currentIndex] on top of a possibly user
              // provided callback.
              child: widget.tabBar.copyWith(
                currentIndex: _controller!.index,
                onTap: (int newIndex) {
                  if(widget.popWhenIndexChange){
                    Navigator.of(context, rootNavigator: true).pop();
                  }
                  _controller!.index = newIndex;
                  // Chain the user's original callback.
                  if (widget.tabBar.onTap != null)
                    widget.tabBar.onTap!(newIndex);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Only dispose `_controller` when the state instance owns it.
    if (widget.controller == null) {
      _controller?.dispose();
    } else if (_controller?._isDisposed == false) {
      _controller!.removeListener(_onCurrentIndexChange);
    }

    super.dispose();
  }
}

/// A widget laying out multiple tabs with only one active tab being built
/// at a time and on stage. Off stage tabs' animations are stopped.
class _TabSwitchingView extends StatefulWidget {
  const _TabSwitchingView({
    required this.currentTabIndex,
    required this.tabCount,
    required this.tabBuilder,
    this.otherBuilder, this.otherPage

  }) : assert(tabCount > 0);

  final int currentTabIndex;
  final int tabCount;
  final IndexedWidgetBuilder tabBuilder;
  final Widget? otherBuilder;
  final Widget? otherPage;

  @override
  _TabSwitchingViewState createState() => _TabSwitchingViewState();
}

class _TabSwitchingViewState extends State<_TabSwitchingView> {
  final List<bool> shouldBuildTab = <bool>[];
  final List<FocusScopeNode> tabFocusNodes = <FocusScopeNode>[];

  // When focus nodes are no longer needed, we need to dispose of them, but we
  // can't be sure that nothing else is listening to them until this widget is
  // disposed of, so when they are no longer needed, we move them to this list,
  // and dispose of them when we dispose of this widget.
  final List<FocusScopeNode> discardedNodes = <FocusScopeNode>[];

  int? _tabCount;

  @override
  void initState() {
    super.initState();
    _updateTabCount();
    shouldBuildTab.addAll(List<bool>.filled(_tabCount!, false));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _focusActiveTab();
  }

  @override
  void didUpdateWidget(_TabSwitchingView oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Only partially invalidate the tabs cache to avoid breaking the current
    // behavior. We assume that the only possible change is either:
    // - new tabs are appended to the tab list, or
    // - some trailing tabs are removed.
    // If the above assumption is not true, some tabs may lose their state.
    final int lengthDiff = _tabCount! - shouldBuildTab.length;
    if (lengthDiff > 0) {
      shouldBuildTab.addAll(List<bool>.filled(lengthDiff, false));
    } else if (lengthDiff < 0) {
      shouldBuildTab.removeRange(_tabCount!, shouldBuildTab.length);
    }
    _focusActiveTab();
  }

  _updateTabCount(){
    if(widget.otherBuilder == null){
      _tabCount = widget.tabCount;
    } else{
      _tabCount = widget.tabCount + 1;
    }
    if(widget.otherPage == null){
      _tabCount = _tabCount;
    }
    else{
      _tabCount = _tabCount! + 1;
    }
  }

  // Will focus the active tab if the FocusScope above it has focus already.  If
  // not, then it will just mark it as the preferred focus for that scope.
  void _focusActiveTab() {
    if (tabFocusNodes.length != _tabCount) {
      if (tabFocusNodes.length > _tabCount!) {
        discardedNodes.addAll(tabFocusNodes.sublist(_tabCount!));
        tabFocusNodes.removeRange(_tabCount!, tabFocusNodes.length);
      } else {
        tabFocusNodes.addAll(
          List<FocusScopeNode>.generate(
            _tabCount! - tabFocusNodes.length,
                (int index) => FocusScopeNode(debugLabel: '$CupertinoTabScaffold Tab ${index + tabFocusNodes.length}'),
          ),
        );
      }
    }
    FocusScope.of(context).setFirstFocus(tabFocusNodes[widget.currentTabIndex]);
  }

  @override
  void dispose() {
    for (FocusScopeNode focusScopeNode in tabFocusNodes) {
      focusScopeNode.dispose();
    }
    for (FocusScopeNode focusScopeNode in discardedNodes) {
      focusScopeNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: List<Widget>.generate(_tabCount!, (int index) {
        final bool active = index == widget.currentTabIndex;
        shouldBuildTab[index] = active || shouldBuildTab[index];

        return Offstage(
          offstage: !active,
          child: TickerMode(
            enabled: active,
            child: FocusScope(
              node: tabFocusNodes[index],
              child: Builder(builder: (BuildContext context) {
                if(shouldBuildTab[index]){
                  if(widget.otherBuilder!=null&&widget.otherPage!=null){
                    if(widget.otherBuilder != null && index == _tabCount! - 2){
                      return widget.otherBuilder!;
                    }else if(widget.otherPage != null && index == _tabCount! - 1){
                      return widget.otherPage!;
                    }else{
                      return widget.tabBuilder(context, index);
                    }
                  }else{
                    return widget.tabBuilder(context, index);
                  }
                }
                else{
                  return Container();
                }
              }),
            ),
          ),
        );
      }),
    );
  }
}
