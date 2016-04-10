// load jquery in page
var jq = document.createElement('script');
// jq.src = "http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js";
jq.src = "https://code.jquery.com/jquery-2.2.3.min.js";
document.getElementsByTagName('head')[0].appendChild(jq);
jQuery.noConflict();

// www.meijutt.com
copy(jQuery('.downurl li .adds input:text').map(function(){ return $(this).val(); }).toArray().join('\n'));
