(function($){'use strict';var Anyslider=function(slider,options){var slides=slider.children(),orgNumSlides=slides.length,numSlides=orgNumSlides,width=slider.width(),next=0,current=1,inner,timer,running=false,defaults={afterChange:function(){},afterSetup:function(){},animation:'slide',beforeChange:function(){},bullets:true,delay:300,easing:'swing',interval:5000,keyboardNav:true,nextLabel:'Next slide',pauseOnHover:true,prevLabel:'Previous slide',responsive:true,rtl:false,showControls:true,speed:400,startSlide:1,touch:true,tasHover:false};function animationCallback(){current=next;if(next===0){current=orgNumSlides;if(options.animation!=='fade'){inner.css('left',-current*width);}}else if(next===numSlides-1){current=1;if(options.animation!=='fade'){inner.css('left',-width);}}
if(options.bullets){slider.next('.as-nav').find('a').removeClass('as-active').filter('[data-num='+current+']').addClass('as-active');}
running=false;options.afterChange.call(slider);}
function run(){if(running){return;}
running=true;options.beforeChange.call(slider);if(options.animation==='fade'){slides.fadeOut().eq(next).delay(options.delay).fadeIn(options.speed,animationCallback);}else{inner.animate({'left':-next*width},options.speed,options.easing,animationCallback);}}
function tick(){timer=setTimeout(function(){next=current+1;if(options.rtl){next=current-1;}
run();tick();},options.interval);}
options=$.extend(defaults,options);if(orgNumSlides>1){slides.eq(0).clone().addClass('clone').appendTo(slider);slides.eq(numSlides-1).clone().addClass('clone').prependTo(slider);}
slides=slider.children();numSlides=slides.length;if(options.startSlide<orgNumSlides){current=options.startSlide;}
slides.wrapAll('<div class="as-slide-inner" />').css('width',width);inner=slider.css('overflow','hidden').find('.as-slide-inner');if(options.animation==='fade'){slides.css({'display':'none','left':0,'position':'absolute','top':0}).eq(current).show();inner.css('width',width);}else{slides.css({'float':'left','position':'relative'});inner.css({'left': -current*width,'width':numSlides*width});}
inner.css({'float':'left','position':'relative'});if(options.showControls){var arrows,arrowSelector='.as-prev-arrow, .as-next-arrow';arrows=slider.prepend('<a href="#" class="as-prev-arrow" title="'+options.prevLabel+'">'+options.prevLabel+'</a>').append('<a href="#" class="as-next-arrow" title="'+options.nextLabel+'">'+options.nextLabel+'</a>').find(arrowSelector).wrapAll('<div class="as-arrows" />');slider.delegate(arrowSelector,'click',function(e){e.preventDefault();if(running){return false;}
next=current+1;if($(this).hasClass('as-prev-arrow')){next=current-1;}
run();});}
if(options.bullets){var i,active,out='<div class="as-nav" />',nav=$(out);for(i=1;i<=orgNumSlides;i++){active='';if(i===current){active='class="as-active"';}
nav.append('<a href="#"'+active+'data-num="'+i+'">'+i+'</a>');}
nav.delegate('a','click',function(e){e.preventDefault();if($(this).hasClass('as-active')||running){return false;}
next=nav.find('a').removeClass('as-active').filter(this).addClass('as-active').data('num');run();});slider.after(nav);}
if(options.keyboardNav){$(document).keydown(function(e){var key=e.keyCode;if(key!==37||key!==39){return;}
next=current+1;if(key===37){next=current-1;}
run();});}
if(options.interval&&orgNumSlides>1){tick();if(!options.tasHover){if(options.pauseOnHover){slider.hover(function(){clearTimeout(timer);},function(){tick();});}}}
if(options.tasHover){clearTimeout(timer);}
if(options.responsive){$(window).resize(function(){if(!running){width=slider.width();inner.css('width',width);slides.css('width',width);if(options.animation!=='fade'){inner.css({'left':-current*width,'width':numSlides*width});}}});}
if(options.touch&&'ontouchstart'in document.documentElement){var startTime,startX;slider.bind('touchstart',function(e){e.preventDefault();startTime=e.timeStamp;startX=e.originalEvent.touches[0].pageX;}).bind('touchmove',function(e){var currentX=e.originalEvent.touches[0].pageX,currentDistance=0,currentTime=e.timeStamp;e.preventDefault();if(startX!==0){currentDistance=Math.abs(currentX-startX);}
if(startTime!==0&&currentTime-startTime<1000&&currentDistance>50){if(currentX<startX){next=current+1;}else if(currentX>startX){next=current-1;}
startTime=0;startX=0;run();}}).bind('touchend',function(){startTime=startX=0;});}
options.afterSetup.call(slider);};$.fn.AnySlider=function(options){return this.each(function(){var slider=$(this),anyslider;if(slider.data('anyslider')){return slider.data('anyslider');}
anyslider=new Anyslider(slider,options);slider.data('anyslider',anyslider);});};}(jQuery));
