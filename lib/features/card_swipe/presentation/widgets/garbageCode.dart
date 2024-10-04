// I have written this code, to have the animations to the buttons, when the card is swiping, based on the card movements, I am handling the animations of the buttons, but it didn't worked out because of there was a problem in the package(library) cardSwiper.

// if (!_isSwiping && percentThresholdX.abs() > threshold) {
              //   _isSwiping = true;
              // }

              // if (percentThresholdX.abs() < threshold && _swipeState != "center" && _isSwiping) {
              //   Future.microtask(() {
              //     widget.leftButtonSize.value = 50.0;
              //     widget.rightButtonSize.value = 50.0;
              //     // leftButtonSize.value = 50.0;
              //     // rightButtonSize.value = 50.0;
              //   });
              //   _swipeState = "center";
              //   _isSwiping = false;
              // } else if (percentThresholdX < -threshold && _swipeState != "left"){
              //   Future.microtask(() {
              //     widget.leftButtonSize.value = 80.0;
              //     widget.rightButtonSize.value = 50.0;
              //     // leftButtonSize.value = 80.0;
              //     // rightButtonSize.value = 50.0;
              //   });
              //   _swipeState = "left";
              //   _isSwiping = false;
              // } else if (percentThresholdX > threshold && _swipeState != "right") {
              //   Future.microtask(() {
              //     widget.leftButtonSize.value = 50.0;
              //     widget.rightButtonSize.value = 80.0;
              //     // leftButtonSize.value = 50.0;
              //     // rightButtonSize.value = 80.0;
              //   });
              //   _swipeState = "right";
              //   _isSwiping = false;
              // }

              // 
              // _previousSwipeDirection = percentThresholdX.toDouble();

              // Return the card widget