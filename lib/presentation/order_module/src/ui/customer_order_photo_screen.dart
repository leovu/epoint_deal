import 'package:card_swiper/card_swiper.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/customer_order_photo_model.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';

class CustomerOrderPhotoScreen extends StatefulWidget {
  final List<CustomerOrderPhotoModel>? models;
  final int? initialIndex;
  CustomerOrderPhotoScreen(this.models, {this.initialIndex});
  @override
  _State createState() {
    // TODO: implement createState
    return _State();
  }
}

class _State extends State<CustomerOrderPhotoScreen> with SingleTickerProviderStateMixin {

  final TransformationController _controller = TransformationController();

  late TapDownDetails _details;

  late AnimationController _animationController;
  late Animation<Matrix4> _animation;

  bool _isZoom = false;

  int? _index;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300)
    )..addListener(() {
      _controller.value = _animation.value;
    });

    _index = widget.initialIndex ?? 0;

    _controller.addListener(() {
      bool isInteractive = _controller.value.storage[10] > 1;
      if(!_isZoom){
        if(isInteractive){
          setState(() {
            _isZoom = true;
          });
        }
      }
      else{
        if(!isInteractive){
          setState(() {
            _isZoom = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  // _download(){
  //   CustomDownload.download(context, widget.models![_index!].url);
  // }

  _doubleTap(){
    final position = _details.localPosition;

    final double scale = 3;
    final x = -position.dx * (scale - 1);
    final y = -position.dy * (scale - 1);
    final zoomed = Matrix4.identity()..translate(x, y)..scale(scale);
    final value = _controller.value.isIdentity() ? zoomed : Matrix4.identity();

    _animation = Matrix4Tween(
        begin: _controller.value,
        end: value
    ).animate(CurveTween(
        curve: Curves.easeOut
    ).animate(_animationController));

    _animationController.forward(from: 0);
  }

  Widget _buildButton(IconData icon, GestureTapCallback onTap){
    return InkWell(
      child: Container(
          width: AppSizes.sizeOnTap,
          height: AppSizes.sizeOnTap,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.sizeOnTap!),
              color: AppColors.hintColor.withOpacity(0.7)
          ),
          alignment: Alignment.center,
          child: Icon(
            icon,
            color: AppColors.whiteColor,
          )),
      onTap: onTap,
    );
  }

  Widget _buildContainer(CustomerOrderPhotoModel model){
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Positioned.fill(child: Center(
          child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: GestureDetector(
                onDoubleTapDown: (details) => _details = details,
                onDoubleTap: _doubleTap,
                child: InteractiveViewer(
                  transformationController: _controller,
                  clipBehavior: Clip.none,
                  scaleEnabled: true,
                  panEnabled: true,
                  minScale: 1,
                  maxScale: 3,
                  child: CustomNetworkImage(
                    url: model.url,
                    fit: BoxFit.contain,
                  ),
                ),
              )
          ),
        )),
        if(model.code != null || model.note != null || model.createdAt != null)
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: AppColors.blackColor.withOpacity(0.5)
            ),
            child: CustomListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                  top: AppSizes.maxPadding,
                  left: AppSizes.maxPadding,
                  right: AppSizes.maxPadding,
                  bottom: 60.0
              ),
              children: [
                if((model.code ?? "").isNotEmpty)
                  Text(
                    model.code ?? "",
                    style: AppTextStyles.style14WhiteBold,
                  ),
                if((model.note ?? "").isNotEmpty)
                  Text(
                    model.note ?? "",
                    style: AppTextStyles.style14WhiteNormal,
                  ),
                if(model.createdAt != null)
                  Text(
                    formatDate(model.createdAt),
                    style: AppTextStyles.style14WhiteNormal,
                  )
              ],
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Swiper(
            index: _index,
            itemBuilder: (BuildContext context, int index) {
              return _buildContainer(widget.models![index]);
            },
            itemCount: widget.models?.length ?? 0,
            pagination: new SwiperPagination(
              builder: SwiperPagination.fraction,
            ),
            control: new SwiperControl(size: 0.0),
            loop: false,
            onIndexChanged: (index){
              _index = index;
            },
          ),
          if(_isZoom)
            _buildContainer(widget.models![_index!]),
          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(top: 40.0, right: 20.0),
            child: _buildButton(
              Icons.close,
              () {
                CustomNavigator.pop(context);
              },
            ),
          ),
          // Container(
          //   alignment: Alignment.topLeft,
          //   padding: EdgeInsets.only(top: 40.0, left: 20.0),
          //   child: _buildButton(
          //     Icons.download,
          //     _download,
          //   ),
          // )
        ],
      ),
    );
  }
}