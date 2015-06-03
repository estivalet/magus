$(document).ready(function(){

/* interface */

$(function() {
  $('#jsi_login').html('<img src="images/button_login.jpg" width="120" height="40" alt="Log In" />');
  $('#jsi_faq').html('<img src="images/button_faq.jpg" width="107" height="40" alt="F.A.Q." />');
  $('#jsi_faq').after('<div class="clr"></div>');
  $('#jsi_logout').before('<a href="#"><img src="images/button_logout.jpg" width="17" height="17" class="logout" /></a>');
  $('#jsi_monitor').html('<img src="images/button_r1.gif" width="54" height="51" />');
  $('#jsi_manadmin').html('<img src="images/button_r2.gif" width="176" height="51" />');
  $('#jsi_h1').html('<span>Perfect time for new</span><br /><span>admin area that works for you</span>');
  $('#tm').before('<img src="images/icon_clock2.gif" width="26" height="26" />');

  $('.header').wrapInner('<div class="header_res"></div>');
  $('.content').wrapInner('<div class="content_res"></div>');
  $('.footer').wrapInner('<div class="footer_res"></div>');

  $('.jsi_gv').children('h3').wrap('<div class="gadget_title vertsortable_head"></div>');
  $('.jsi_gh').children('h3').wrap('<div class="gadget_title horizsortable_head"></div>');
  $('.jsi_gd').children('h3').wrap('<div class="gadget_title"></div>');
  $('.jsi_gv').children('.gadget_title').children('h3').before('<a href="#" class="hidegadget" rel="hide_block"><img src="images/spacer.gif" width="19" height="35" /></a>');
  $('.jsi_gh').children('.gadget_title').children('h3').before('<a href="#" class="hidegadget" rel="hide_block"><img src="images/spacer.gif" width="19" height="35" /></a>');
  $('.jsi_gd').children('.gadget_title').children('h3').before('<a href="#" class="close closegadget"><img src="images/spacer.gif" width="19" height="35" /></a>');
  $('.jsi_file').children('a').html('<img src="images/icon_dld.gif" width="32" height="32" alt="Download file" />');

  $('.err_mes').append(' <a href="#" class="close_mess"><img src="images/spacer.gif" width="24" height="38" /></a>');
  $('.jsi_mes_green').prepend('<img src="images/pimpa_green.gif" width="13" height="13" class="pimpa" /> ');
  $('.jsi_mes_red').prepend('<img src="images/pimpa_red.gif" width="13" height="13" class="pimpa" /> ');
  $('.jsi_acl').html('<img src="images/spacer.gif" width="40" height="24" />');
  $('.jsi_prevpix').parent('a').wrap('<div class="bg_shade"></div>');
  });

});
