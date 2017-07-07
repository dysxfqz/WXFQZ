function setCookie(c_name,value,expiredays)
{
    var exdate=new Date();
    exdate.setDate(exdate.getDate()+expiredays);
    document.cookie=c_name+ "=" +escape(value)+
    ((expiredays==null) ? "" : ";expires="+exdate.toGMTString())+ "; path=/";
}
//读取cookie
function getCookie(name){
	var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
	if(arr=document.cookie.match(reg))
	return unescape(arr[2]);
	else
	return null;
	}
function delCookie(name) {
	  var exp = new Date();
	  exp.setTime(exp.getTime() + (-1 * 24 * 60 * 60 * 1000));
	  var cval = getCookie(name);
	  document.cookie = name + "=" + cval + "; expires=" + exp.toGMTString()+ "; path=/";
	}