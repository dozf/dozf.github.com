<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>好员工</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="css/an.css">

  </head>
  
  <body> 
  <script type="text/javascript">
  function getDate(){
    var thedate = new Date();
    var lunchTime = 12*60*60; //中饭时间
	var dinnerTime = 17*60*60 + 30*60; //晚饭时间
    var h=thedate.getHours();
    var mins=thedate.getMinutes();
    var s=thedate.getSeconds();
    var nowTime=h*60*60+mins*60+s; 
    span1=document.getElementById("word");//显示字
    span2=document.getElementById("time");//显示时间
    span3=document.getElementById("unit");//显示秒数
    var hour1=12-h;
    var hour2=17-h;
    var minute=60-mins;
    var second=60-s;
				//吃中饭
				if(lunchTime >= nowTime) {
					span1.innerHTML = "想吃饭先好好工作吧，距离吃中饭还剩 ";
					if(mins>30){
						minute=89-mins;
						hour1=11-h;
					}else{
						minute=29-mins;
					}
					span2.innerHTML =hour1+":"+minute+":"+second;
					span3.innerHTML ="，即("+(lunchTime - nowTime)+")秒";
					setTimeout('getDate()',1000);
					
				//吃晚饭
				} else if(dinnerTime >= nowTime) {
					span1.innerHTML = "好好工作买房，距离吃晚饭还剩 ";
					if(mins>30){
						minute=89-mins;
						hour2=16-h;
					}else{
						minute=29-mins;
					}
					span2.innerHTML =hour2+":"+minute+":"+second;
					span3.innerHTML ="，即("+(dinnerTime - nowTime)+")秒";
					setTimeout('getDate()',1000);
					
				//加班	
    			} else if(nowTime > dinnerTime) {
					span1.innerHTML = "加班伤肾啊，已经加班 ";
					span2.innerHTML = (nowTime - dinnerTime)+"秒！";
					setTimeout('getDate()',1000);
				
				} 
           }
  </script>
    <center><h3>请叫我好员工</h3></center>
    
    <div class="show" >
    <input type="button" value="点击查看吃饭时间" class="an1" onclick="getDate()"/>
    <span id="word"></span><span id="time" style="font-size:50px;color:red;width:150px"></span><span id="unit"></span>
    </div>
  </body>
</html>
