$(document).ready(init);
var minWidth = 1022;
function init()
{	
   	$(window).scroll(scrollHandler);
	$("header").hover(overHandler,outHandler);
	$("#top").click(topHandler);
}
function topHandler(){
	//alert($("body").height());
	$("html, body").animate({scrollTop: 0}, $("body").height()*0.1);
}
function scrollHandler(){
	if($(window).width()>minWidth){
		if($(window).scrollTop()>0){
			$("header").delay(10).animate({height:"60px"}, 100).stop();
			$("header").css("opacity", 0.7);
			$("#mainMenu").addClass("scrollDown");
			$("#logoImg").delay(10).animate({height:"30px"}, 300).stop();
		}else{
			$("header").animate({height:"80px"}, 300).finish();
			$("header").css("opacity", 1);
			$("#mainMenu").removeClass("scrollDown");
			$("#logoImg").animate({height:"100%"}, 300).finish();
		}
	}
	if($(window).scrollTop()>200) $("#top").css({"display":"block"});
	else $("#top").css({"display":"none"});
}
function overHandler(){
	if($(window).width()>minWidth && $(window).scrollTop()>0) {
		$("header").css("opacity", 1);
	}
}
function outHandler(){
	if($(window).width()>minWidth && $(window).scrollTop()>0) {
		$("header").css("opacity", 0.7);
	}
}
