$(document).ready(init);
var minWidth = 1022;
function init()
{	
   	$(window).scroll(scrollHandler);
	$("header").hover(overHandler,outHandler);
	$("#top").click(topHandler);
	$("input.category").change(selectHandler);
}
function topHandler(){
	//alert($("body").height());
	$("html, body").animate({scrollTop: 0}, $("body").height()*0.1);
}
function scrollHandler(){
	if($(window).width()>minWidth){
		if($(window).scrollTop()>0){
			$("header").css("height", "60px").css("opacity", 0.7);
			$("#mainMenu").addClass("scrollDown");
		}else{
			$("header").css("height", "80px").css("opacity", 1);
			$("#mainMenu").removeClass("scrollDown");
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
var final_quantity;
function selectHandler(e){
	if($(e).attr('name')=="selectAll"){
		$("input[type='checkbox']").each(select);
		final_quantity = Number($("input.total").attr("data-total"));
	}else if($(e).attr('name')=="cancelAll"){
		$("input[type='checkbox']").each(cancel);
		final_quantity = 0;
	}else{
		if(e.target.checked) $(this).prop('checked',true);
		else $(this).prop('checked',false);
		final_quantity = 0;
		$("input[type='checkbox']").each(selectCount);
	}
	$("span.categories").html(final_quantity);
}
function select(){
	$(this).prop('checked',true);
}
function cancel(){
	$(this).prop('checked',false);
}
function selectCount(){
	final_quantity += Number($(this).prop("checked"));
}
