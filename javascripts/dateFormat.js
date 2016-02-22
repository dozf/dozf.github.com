// 将日期类型转换成字符串型格式 yyyy-MM-dd hh:mm:ss
 
function ChangeTimeToString ( DateIn )
{
    var Year = 0 ;
    var Month = 0 ;
    var Day = 0 ;
    var Hour = 0 ;
    var Minute = 0 ;
    var Seconds = 0;
    var CurrentDate = "" ;
 
    // 初始化时间
    Year = DateIn . getFullYear();
    Month = DateIn . getMonth ()+ 1 ;
    Day = DateIn . getDate ();
    Hour = DateIn . getHours ();
    Minute = DateIn . getMinutes ();
    Seconds = DateIn .getSeconds();
    CurrentDate = Year + "-" ;
    if ( Month >= 10 ){
        CurrentDate = CurrentDate + Month + "-" ;
    }else {
        CurrentDate = CurrentDate + "0" + Month + "-" ;
    }
    if ( Day >= 10 ){
        CurrentDate = CurrentDate + Day ;
    }else{
        CurrentDate = CurrentDate + "0" + Day ;
    }
   
    if ( Hour >= 10 ){
        CurrentDate = CurrentDate + " " + Hour ;
    }else{
        CurrentDate = CurrentDate + " 0" + Hour ;
    }
    if ( Minute >= 10 ){
        CurrentDate = CurrentDate + ":" + Minute ;
    }else{
        CurrentDate = CurrentDate + ":0" + Minute ;
    }      
    if ( Seconds >= 10 ){
        CurrentDate = CurrentDate + ":" + Seconds ;
    }else{
        CurrentDate = CurrentDate + ":0" + Seconds ;
    } 
    return CurrentDate ;
}

//显示现在时刻
function showNowDate(){
	var nowDate = ChangeTimeToString(new Date());
	span=document.getElementById("nowDateId");//现在时刻
	alert(nowDate);
	span.innerHTML = nowDate;
	setTimeout('getDate()',1000);
}
showNowDate();

