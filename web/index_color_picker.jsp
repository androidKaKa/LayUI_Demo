<%--
  Created by IntelliJ IDEA.
  User: linhuorong
  Date: 2020/6/24
  Time: 下午7:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html" pageEncoding="GBK"%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>a color picker</title>
    <link rel="stylesheet" href="./layui/css/layui.css" media="all">

</head>
<body>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
    <legend>常规使用</legend>
</fieldset>

<div style="margin-left: 30px;margin-top: 250px" >
    <div id="test1"></div>
    <p id="test-form-color2">当前颜色值</p>
        <input type="text" value="" placeholder="请选择颜色" class="layui-input" id="test-form-color">
</div>


<p id ="demo"> 111</p>


<script src="./layui/layui.js"></script>
<script>
    layui.use('colorpicker', function() {
        var $ = layui.$
            , colorpicker = layui.colorpicker;
        //常规使用
        colorpicker.render({
            elem: '#test1' //绑定元素
            , change: function (color) { //颜色改变的回调
                $('#test-form-color').val(color);
                document.getElementById("demo").innerHTML = color;
                console.log(color)
                layer.tips('选择了：' + color, this.elem, {
                    tips: 1
                });


            }
        });
    });
</script>
</body>
</html>
