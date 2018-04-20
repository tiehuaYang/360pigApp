/**
 * 
 */

$('.goodselect').on('click',function(){
	$(this).css({'border':'2px solid #03b8cc'}).addClass('goodselected');
	$(this).siblings().css({'border':'2px solid rgba(200,200,200,0.5)'}).removeClass('goodselected');
});

$('.littleimg').on('mouseover',function(){
	var srcurl = $(this).children().attr('src');
	$(this).css({'border':'2px solid #e74c3c'});
	$(this).siblings().css({'border':'2px solid transparent'});
	$('.bigimg').attr('src',srcurl);
});

$('.bottomtab').on('click',function(){
	var index = $('.bottomtab').index($(this));
	$(this).addClass('tabselect').siblings().removeClass('tabselect');
	$($('.bottomdiv')[index]).show().siblings().hide();
});
var turncount = 5;
function turnImgBtn(){
	var imglength = $('.littleimg').length+1;
	var ulwidth = parseInt($('.littleimgul').width());
	var liwidth = ulwidth*0.18;
	var move = ulwidth*0.20;
	$('.littleimg').width(ulwidth*0.18);
	if(imglength>5){
		var ulwidth = 21*imglength;
		$('.littleimgul').width(ulwidth+'%');
		$('.imgturnleft').on('click',function(){
			if(turncount  <= 5){
				return;
			}
			$('.littleimg').animate({
				left:'+='+ move
			})
			turncount--;
		});
		$('.imgturnright').on('click',function(){
			if(turncount >= imglength){
				return;
			}
			$('.littleimg').animate({
				left:'-='+ move
			})
			turncount++;
		});
		
	}
}