<%--
  Created by IntelliJ IDEA.
  User: linhuorong
  Date: 2020/6/23
  Time: ����9:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html" pageEncoding="GBK"%>
<html>
<head>
  <meta charset="utf-8">
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>��ʼʹ��layui</title>
  <link rel="stylesheet" href="./layui/css/layui.css" media="all">

</head>
<body>
<script src="./layui/layui.js"></script>
<script>
  //һ��ֱ��д��һ��js�ļ���
  layui.use(['layer', 'form'], function(){
    var layer = layui.layer
            ,form = layui.form;

    layer.msg('Hello World');
  });
</script>


<script src="./layui/layui.js"></script>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
  <legend>����ʹ�ã���ͨͼƬ�ϴ�</legend>
</fieldset>

<div class="layui-upload">
  <button type="button" class="layui-btn" id="test1">�ϴ�ͼƬ</button>
  <div class="layui-upload-list">
    <img class="layui-upload-img" id="demo1">
    <p id="demoText"></p>
  </div>
</div>
<hr>
<p></p>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
  <legend>�ϴ�����ͼƬ</legend>
</fieldset>

<div class="layui-upload">
  <button type="button" class="layui-btn" id="test2">��ͼƬ�ϴ�</button>
  <blockquote class="layui-elem-quote layui-quote-nm" style="margin-top: 10px;">
    Ԥ��ͼ��
    <div class="layui-upload-list" id="demo2"></div>
  </blockquote>
</div>

<script>
  layui.use('upload', function(){
    var $ = layui.jquery
            ,upload = layui.upload;

    //��ͨͼƬ�ϴ�
    var uploadInst = upload.render({
      elem: '#test1'
      ,url: 'https://httpbin.org/post' //�ĳ����Լ����ϴ��ӿ�
      ,before: function(obj){
        //Ԥ�������ļ�ʾ������֧��ie8
        obj.preview(function(index, file, result){
          $('#demo1').attr('src', result); //ͼƬ���ӣ�base64��
        });
      }
      ,done: function(res){
        //����ϴ�ʧ��
        if(res.code > 0){
          return layer.msg('�ϴ�ʧ��');
        }
        //�ϴ��ɹ�
      }
      ,error: function(){
        //��ʾʧ��״̬����ʵ���ش�
        var demoText = $('#demoText');
        demoText.html('<span style="color: #FF5722;">�ϴ�ʧ��</span> <a class="layui-btn layui-btn-xs demo-reload">����</a>');
        demoText.find('.demo-reload').on('click', function(){
          uploadInst.upload();
        });
      }
    });

    //��ͼƬ�ϴ�
    upload.render({
      elem: '#test2'
      ,url: 'https://httpbin.org/post' //�ĳ����Լ����ϴ��ӿ�
      ,multiple: true
      ,before: function(obj){
        //Ԥ�������ļ�ʾ������֧��ie8
        obj.preview(function(index, file, result){
          $('#demo2').append('<img src="'+ result +'" alt="'+ file.name +'" class="layui-upload-img">')
        });
      }
      ,done: function(res){
        //�ϴ����
      }
    });

    //ָ�������ϴ����ļ�����
    upload.render({
      elem: '#test3'
      ,url: 'https://httpbin.org/post' //�ĳ����Լ����ϴ��ӿ�
      ,accept: 'file' //��ͨ�ļ�
      ,done: function(res){
        layer.msg('�ϴ��ɹ�');
        console.log(res);
      }
    });
    upload.render({ //�����ϴ����ļ���׺
      elem: '#test4'
      ,url: 'https://httpbin.org/post' //�ĳ����Լ����ϴ��ӿ�
      ,accept: 'file' //��ͨ�ļ�
      ,exts: 'zip|rar|7z' //ֻ�����ϴ�ѹ���ļ�
      ,done: function(res){
        layer.msg('�ϴ��ɹ�');
        console.log(res)
      }
    });
    upload.render({
      elem: '#test5'
      ,url: 'https://httpbin.org/post' //�ĳ����Լ����ϴ��ӿ�
      ,accept: 'video' //��Ƶ
      ,done: function(res){
        layer.msg('�ϴ��ɹ�');
        console.log(res)
      }
    });
    upload.render({
      elem: '#test6'
      ,url: 'https://httpbin.org/post' //�ĳ����Լ����ϴ��ӿ�
      ,accept: 'audio' //��Ƶ
      ,done: function(res){
        layer.msg('�ϴ��ɹ�');
        console.log(res)
      }
    });

    //�趨�ļ���С����
    upload.render({
      elem: '#test7'
      ,url: 'https://httpbin.org/post' //�ĳ����Լ����ϴ��ӿ�
      ,size: 60 //�����ļ���С����λ KB
      ,done: function(res){
        layer.msg('�ϴ��ɹ�');
        console.log(res)
      }
    });

    //ͬʱ�󶨶��Ԫ�أ����������趨��Ԫ����
    upload.render({
      elem: '.demoMore'
      ,before: function(){
        layer.tips('�ӿڵ�ַ��'+ this.url, this.item, {tips: 1});
      }
      ,done: function(res, index, upload){
        var item = this.item;
        console.log(item); //��ȡ��ǰ�����ϴ���Ԫ�أ�layui 2.1.0 ����
      }
    })

    //ѡ���ļ����Զ��ϴ�
    upload.render({
      elem: '#test8'
      ,url: 'https://httpbin.org/post' //�ĳ����Լ����ϴ��ӿ�
      ,auto: false
      //,multiple: true
      ,bindAction: '#test9'
      ,done: function(res){
        layer.msg('�ϴ��ɹ�');
        console.log(res)
      }
    });

    //��ק�ϴ�
    upload.render({
      elem: '#test10'
      ,url: 'https://httpbin.org/post' //�ĳ����Լ����ϴ��ӿ�
      ,done: function(res){
        layer.msg('�ϴ��ɹ�');
        layui.$('#uploadDemoView').removeClass('layui-hide').find('img').attr('src', res.files.file);
        console.log(res)
      }
    });

    //���ļ��б�ʾ��
    var demoListView = $('#demoList')
            ,uploadListIns = upload.render({
      elem: '#testList'
      ,url: 'https://httpbin.org/post' //�ĳ����Լ����ϴ��ӿ�
      ,accept: 'file'
      ,multiple: true
      ,auto: false
      ,bindAction: '#testListAction'
      ,choose: function(obj){
        var files = this.files = obj.pushFile(); //��ÿ��ѡ����ļ�׷�ӵ��ļ�����
        //��ȡ�����ļ�
        obj.preview(function(index, file, result){
          var tr = $(['<tr id="upload-'+ index +'">'
            ,'<td>'+ file.name +'</td>'
            ,'<td>'+ (file.size/1024).toFixed(1) +'kb</td>'
            ,'<td>�ȴ��ϴ�</td>'
            ,'<td>'
            ,'<button class="layui-btn layui-btn-xs demo-reload layui-hide">�ش�</button>'
            ,'<button class="layui-btn layui-btn-xs layui-btn-danger demo-delete">ɾ��</button>'
            ,'</td>'
            ,'</tr>'].join(''));

          //�����ش�
          tr.find('.demo-reload').on('click', function(){
            obj.upload(index, file);
          });

          //ɾ��
          tr.find('.demo-delete').on('click', function(){
            delete files[index]; //ɾ����Ӧ���ļ�
            tr.remove();
            uploadListIns.config.elem.next()[0].value = ''; //��� input file ֵ������ɾ�������ͬ���ļ�����ѡ
          });

          demoListView.append(tr);
        });
      }
      ,done: function(res, index, upload){
        if(res.files.file){ //�ϴ��ɹ�
          var tr = demoListView.find('tr#upload-'+ index)
                  ,tds = tr.children();
          tds.eq(2).html('<span style="color: #5FB878;">�ϴ��ɹ�</span>');
          tds.eq(3).html(''); //��ղ���
          return delete this.files[index]; //ɾ���ļ������Ѿ��ϴ��ɹ����ļ�
        }
        this.error(index, upload);
      }
      ,error: function(index, upload){
        var tr = demoListView.find('tr#upload-'+ index)
                ,tds = tr.children();
        tds.eq(2).html('<span style="color: #FF5722;">�ϴ�ʧ��</span>');
        tds.eq(3).find('.demo-reload').removeClass('layui-hide'); //��ʾ�ش�
      }
    });

    //��ԭʼ�ļ���
    upload.render({
      elem: '#test20'
      ,url: 'https://httpbin.org/post' //�ĳ����Լ����ϴ��ӿ�
      ,done: function(res){
        layer.msg('�ϴ��ɹ�');
        console.log(res)
      }
    });

  });
</script>
</body>
</html>
