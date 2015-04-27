// JavaScript Document
var index=0;
var interval;
var	count;
function ShowImg(i){
	$(".banner img").hide();
	$(".bannerCtrl li").each(function() {
			 this.className="bannerCtrl01";
        });
		$(".banner img").eq(i).fadeIn("fast");
		$(".bannerCtrl li").each(function(index, element) {
			if(index==i)
			 element.className="bannerCtrl01 liSelect";
        });
	}
function ShowNext()	{		
	if(index==$(".bannerCtrl li").length-1)
		index=0;
		else
		index++;
	ShowImg(index);
	}
$(function(){
	$(".bannerCtrl li").click(function(){
			clearInterval(interval);
			interval = window.setInterval(ShowNext,3000);
			var b = $(".bannerCtrl li").index($(this));
			ShowImg(b);
			index = b;
	});	
	interval = window.setInterval(ShowNext,3000);
});


function reducebutton(){
		if($("#shoppinginput").val()>0){
			$("#shoppinginput").val(parseInt(""+$("#shoppinginput").val()+"") - 1);
			return;
			}
	}
	
function  addbutton(){
		$("#shoppinginput").val(parseInt(""+$("#shoppinginput").val()+"") + 1);
	return;
}

function reducebutton1(){
		if($("#shoppinginput1").val()>0){
			$("#shoppinginput1").val(parseInt(""+$("#shoppinginput1").val()+"") - 1);
			return;
			}
	}
	
function  addbutton1(){
		$("#shoppinginput1").val(parseInt(""+$("#shoppinginput1").val()+"") + 1);
	return;
}

function reducebutton2(){
		if($("#shoppinginput2").val()>0){
			$("#shoppinginput2").val(parseInt(""+$("#shoppinginput2").val()+"") - 1);
			return;
			}
	}
	
function  addbutton2(){
		$("#shoppinginput2").val(parseInt(""+$("#shoppinginput2").val()+"") + 1);
	return;
}

