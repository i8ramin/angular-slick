'use strict'

angular.module('slick', [])
  .directive "slick", ($timeout) ->
    restrict: "AEC"
    scope:
      initOnload: "@"
      data: "="
      currentIndex: "="
      accessibility: "@"
      adaptiveHeight: "@"
      arrows: "@"
      asNavFor: "@"
      appendArrows: "@"
      autoplay: "@"
      autoplaySpeed: "@"
      centerMode: "@"
      centerPadding: "@"
      cssEase: "@"
      customPaging: "&"
      dots: "@"
      draggable: "@"
      easing: "@"
      fade: "@"
      infinite: "@"
      initialSlide: "@"
      lazyLoad: "@"
      onBeforeChange: "&"
      onAfterChange: "&"
      onInit: "&"
      onReInit: "&"
      onSetPosition: "&"
      pauseOnHover: "@"
      pauseOnDotsHover: "@"
      responsive: "&"
      rtl: "@"
      slide: "@"
      slidesToShow: "@"
      slidesToScroll: "@"
      speed: "@"
      swipe: "@"
      swipeToSlide: "@"
      touchMove: "@"
      touchThreshold: "@"
      useCSS: "@"
      variableWidth: "@"
      vertical: "@"
      prevArrow:"@"
      nextArrow:"@"

    link: (scope, element, attrs) ->

      initializeSlick = () ->
        $timeout(() ->
          slider = $(element)
          currentIndex = scope.currentIndex if scope.currentIndex?

          slider.slick
            accessibility: scope.accessibility isnt "false"
            adaptiveHeight: scope.adaptiveHeight is "true"
            arrows: scope.arrows isnt "false"
            asNavFor: if scope.asNavFor then scope.asNavFor else null
            appendArrows: if scope.appendArrows then $(appendArrows) else null
            autoplay: scope.autoplay is "true"
            autoplaySpeed: if scope.autoplaySpeed? then parseInt(scope.autoplaySpeed, 10) else 3000
            centerMode: scope.centerMode is "true"
            centerPadding: scope.centerPadding or "50px"
            cssEase: scope.cssEase or "ease"
            customPaging: scope.customPaging or null
            dots: scope.dots is "true"
            draggable: scope.draggable isnt "false"
            easing: scope.easing or "linear"
            fade: scope.fade is "true"
            infinite: scope.infinite isnt "false"
            initialSlide:scope.initialSlide or 0
            lazyLoad: scope.lazyLoad or "ondemand"
            onBeforeChange: scope.onBeforeChange or null
            onAfterChange: (sl, index) ->
              scope.onAfterChange() if scope.onAfterChange
              if currentIndex?
                scope.$apply(->
                  currentIndex = index
                  scope.currentIndex = index
                )
            onInit: (sl) ->
              scope.onInit() if scope.onInit
              if currentIndex?
                sl.slideHandler(currentIndex)
            onReInit: scope.onReInit or null
            onSetPosition: scope.onSetPosition or null
            pauseOnHover: scope.pauseOnHover isnt "false"
            responsive: scope.responsive() or null
            rtl: scope.rtl is "true"
            slide: scope.slide or "div"
            slidesToShow: if scope.slidesToShow? then parseInt(scope.slidesToShow, 10) else 1
            slidesToScroll: if scope.slidesToScroll? then parseInt(scope.slidesToScroll, 10) else 1
            speed: if scope.speed? then parseInt(scope.speed, 10) else 300
            swipe: scope.swipe isnt "false"
            swipeToSlide: scope.swipeToSlide is "true"
            touchMove: scope.touchMove isnt "false"
            touchThreshold: if scope.touchThreshold then parseInt(scope.touchThreshold, 10) else 5
            useCSS: scope.useCSS isnt "false"
            variableWidth: scope.variableWidth isnt "false"
            vertical: scope.vertical is "true"
            prevArrow: if scope.prevArrow then $(scope.prevArrow) else undefined
            nextArrow: if scope.nextArrow then $(scope.nextArrow) else undefined


          scope.$watch("currentIndex", (newVal, oldVal) ->
            if currentIndex? and newVal? and newVal != currentIndex
              slider.slickGoTo(newVal)
          )
        )

      if scope.initOnload
        isInitialized = false
        scope.$watch("data", (newVal, oldVal) ->
          if newVal? and not isInitialized
            initializeSlick()
            isInitialized = true
        )
      else
        initializeSlick()
