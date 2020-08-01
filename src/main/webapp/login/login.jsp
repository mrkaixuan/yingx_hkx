<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>应学App后台登录</title>
    <!-- CSS -->
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/form-elements.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="shortcut icon" href="assets/ico/favicon.png">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="${path}/login/assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="${path}/login/assets/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="${path}/login/assets/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="${path}/login/assets/ico/apple-touch-icon-57-precomposed.png">
    <script src="${path}/bootstrap/js/jquery.min.js"></script>
    <script src="${path}/login/assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="${path}/login/assets/js/jquery.backstretch.min.js"></script>
    <script src="${path}/login/assets/js/scripts.js"></script>
    <script src="${path}/login/assets/js/jquery.validate.min.js"></script>
    <script>
        /*异步登陆*/
        $(function () {
            //点击切换验证码
            $("#captchaImage").click(function () {
                //欺骗浏览器,浏览器认为不是一个请求,一秒一次,gettime
                $("#captchaImage").prop("src","${path}/admin/getImageCode?d="+new Date().getTime());
            });


        //jquery validator 表单验证
        $.extend($.validator.messages, {
            //表单验证  必填验证  需要在要验证的input框上加入  required
            required: "<span style='color: red'>这是必填字段</span>",
            //表单验证  最小字符验证  需要在要验证的input框上加入  minlength=4
            minlength: $.validator.format("<span style='color:red'>最少要输入4个字符</span>"),
        });

        //ajax 表单异步提交
        $("#loginButtonId").click(function () {
            //判断表单验证是否通过
            var isOK = $("#loginForm").valid();

            if (isOK){//提交表单
                $.ajax({
                        url:"${path}/admin/login",
                        type:"post",
                        dataType:"json",
                        data:$("#loginForm").serialize(),  //序列化表单的值传递数据
                        success:function (data) {
                            //判断是否登陆成功
                            if (data.status=="200"){
                                location.href="${path}/main/main.jsp";
                            }else {
                                $("#msgDiv").html("<span style='color: red'><strong>"+data.message+"</strong></span>");
                            }
                        }
                    });

            }
        });
        });


    </script>

</head>

<body>

<!-- Top content -->
<div class="top-content">

    <div class="inner-bg">
        <div class="container">
            <div class="row">
                <div class="col-sm-8 col-sm-offset-2 text">
                    <h1 align="center"><strong>应学App后台管理系统</strong> </h1>
                    <div class="description">
                        <p>
                            <a href="#"><strong>该系统主要用于内部数据管理</strong></a>
                        </p>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6 col-sm-offset-3 form-box">
                    <div class="form-top" style="width: 450px">
                        <div class="form-top-left">
                            <h3>管理员登录</h3>
                            <p>请输入用户名密码 :</p>
                        </div>
                        <div class="form-top-right">
                            <i class="fa fa-key"></i>
                        </div>
                    </div>
                    <div class="form-bottom" style="width: 450px">
                        <form role="form" action="" method="post" class="login-form" id="loginForm">
                            <span id="msgDiv"></span>
                            <div class="form-group">
                                <label class="sr-only" for="form-username">Username</label>
                                <input type="text" required name="username" placeholder="请输入用户名..." class="form-username form-control" required id="form-username">
                            </div>
                            <div class="form-group">
                                <label class="sr-only" for="form-password">Password</label>
                                <input type="password"  required  name="password" placeholder="请输入密码..." class="form-password form-control" required id="form-password">
                            </div>
                            <div class="form-group">
                                <%--<label class="sr-only" for="form-code">Code</label>--%>
                                <img id="captchaImage" style="height: 48px" class="captchaImage" src="${path}/admin/getImageCode">
                                <input style="width: 289px;height: 50px;border:3px solid #ddd;border-radius: 4px;"  required  minlength="4" placeholder="请输入验证码..." type="test" name="enCode" id="form-code">
                            </div>

                            <input type="button" style="width: 400px;border:1px solid #9d9d9d;border-radius: 4px;" id="loginButtonId" value="登录">
<%--                            <button type="submit" class="btn btn-success" id="loginButtonId">登陆</button>--%>
                           <%-- <input type="submit" style="width: 400px;border:1px solid #9d9d9d;border-radius: 4px;" id="loginButtonId" value="登录">--%>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<div class="copyrights">Collect from <a href="http://www.cssmoban.com/" title="网站模板">网站模板</a></div>


<!-- Javascript -->

<!--[if lt IE 10]>
<script src="assets/js/placeholder.js"></script>
<![endif]-->

</body>

</html>