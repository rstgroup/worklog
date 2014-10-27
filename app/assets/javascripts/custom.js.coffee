$ ->
  
$('textarea').focus(
    function(){
        $(this).parent('div').css('background-color','#efefef');
    }).blur(
    function(){
        $(this).parent('div').css('background-color','#efefef');
    });