// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function() {
  var divs = "#flash_success, #flash_notice, #flash_error";
  $(divs).each(function() {
    humanMsg.displayMsg($(this).text());
    return false;
  });

  if(window.location.href.search(/query=/) == -1) {
    $("#query").click(function() {
      $(this).val("");
      $(this).unbind("click");
    });
  }
});
