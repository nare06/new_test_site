/*
 * @freebie: blue-notification-navigation
 * @author: Francisco Neves
 */
 
$(document).ready(function()
{
	$("ul.dropdown li > div.header").click(function()
	{
		$(this).parent().find("ul.menu").slideToggle();
	});
});
