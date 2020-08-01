<%@page pageEncoding="UTF-8" isELIgnored="false" contentType="text/html; UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport"
              content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Document</title>
        <script type="text/javascript" src="https://cdn.goeasy.io/goeasy-1.0.3.js"></script>
        <script src="${path}/bootstrap/js/jquery.min.js"></script>
        <!-- 引入 ECharts 文件 -->
        <script src="${path}/js/echarts.js"></script>
        <script type="text/javascript">

            $(function(){

                // 基于准备好的dom，初始化echarts实例
                var myChart = echarts.init(document.getElementById('main'));

                //发请求获取数据
                $.get("${path}/echarts/getUserEcharts",function(data){
                    // 指定图表的配置项和数据
                    var option = {
                        title: {
                            text: '用户统计图',  //标题
                            //show:false  //是否隐藏标题
                            subtext:"纯属虚构", //副标题
                            sublink:"${path}/main/main.jsp"
                        },
                        tooltip: {},  //鼠标的提示
                        legend: {
                            data:['男','女']  //选项卡
                        },
                        xAxis: {  //横坐标
                            data: data.month
                        },
                        yAxis: {},  //纵坐标   自适应
                        series: [{   //数据列表
                            name: '男',  //对应选项卡名称
                            type: 'bar',  //展示的图标类型    bar:柱状图   line:折线图    pie：饼图
                            data: data.boys  //数据
                        },{   //数据列表
                            name: '女',  //对应选项卡名称
                            type: 'bar',  //展示的图标类型    bar:柱状图   line:折线图    pie：饼图
                            data: data.girls  //数据
                        }]
                    };

                    // 使用刚指定的配置项和数据显示图表。
                    myChart.setOption(option);
                },"json");
            });
        </script>
        <script type="text/javascript">

            /*初始化GoEasy*/
            var goEasy = new GoEasy({
                host:'hangzhou.goeasy.io', //应用所在的区域地址: 【hangzhou.goeasy.io |singapore.goeasy.io】
                appkey: "BC-df0a45499f274b2bae29ae50a6a12dc9", //替换为您的应用appkey
            });




            $(function(){

                // 基于准备好的dom，初始化echarts实例
                var myChart = echarts.init(document.getElementById('main'));

                //发请求获取数据
                //$.get("/echarts/getUserEcharts",function(data){
                //GoEasy-OTP可以对appkey进行有效保护,详情请参考​ ​
                //如果需要使用HTTPS/WSS，请在连接初始化GoEasy对象的时候传入参数forceTLS，并设置为true。
                goEasy.subscribe({
                    channel: "My184Channel", //替换为您自己的channel
                    onMessage: function (message) {
                        //获取数据
                        var datas=message.content;

                        //将json字符串转为javascript对象
                        var data=JSON.parse(datas);

                        // 指定图表的配置项和数据
                        var option = {
                            title: {
                                text: '用户统计图',  //标题
                                //show:false  //是否隐藏标题
                                subtext:"纯属虚构", //副标题
                                sublink:"${path}/main/main.jsp"
                            },
                            tooltip: {},  //鼠标的提示
                            legend: {
                                data:['小男孩','小姑娘']  //选项卡
                            },
                            xAxis: {  //横坐标
                                data: data.month
                            },
                            yAxis: {},  //纵坐标   自适应
                            series: [{   //数据列表
                                name: '小男孩',  //对应选项卡名称
                                type: 'bar',  //展示的图标类型    bar:柱状图   line:折线图    pie：饼图
                                data: data.boys  //数据
                            },{   //数据列表
                                name: '小姑娘',  //对应选项卡名称
                                type: 'bar',  //展示的图标类型    bar:柱状图   line:折线图    pie：饼图
                                data: data.girls  //数据
                            }]
                        };

                        // 使用刚指定的配置项和数据显示图表。
                        myChart.setOption(option);
                    }
                });
            });
        </script>
    </head>
    <body>
        <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
        <div id="main" style="width: 600px;height:400px;"></div>

    </body>
</html>