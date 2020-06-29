<%--
  Created by IntelliJ IDEA.
  User: linhuorong
  Date: 2020/6/23
  Time: ����10:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html" pageEncoding="GBK"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
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
<div class="layui-upload">
    <button type="button" class="layui-btn layui-btn-normal" id="testList">ѡ��ͼƬ</button>
    <div class="layui-upload-list">
        <table class="layui-table">
            <thead>
            <tr><th>�ļ���</th>
                <th>��С</th>
                <th>״̬</th>
                <th>����</th>
            </tr></thead>
            <tbody id="demoList"></tbody>
        </table>
    </div>
    <button type="button" class="layui-btn" id="testListAction">��ʼ�ϴ�</button>
</div>




<script src="./layui/layui.js"></script>
<!-- ע�⣺�����ֱ�Ӹ������д��뵽���أ�����js·����Ҫ�ĳ��㱾�ص� -->
<script>
    layui.use('upload', function(){
        var $ = layui.jquery
            ,upload = layui.upload;

        upload.render({ //�����ϴ����ļ���׺
            elem: '#test4'
            ,url: '/LayUI_Demo/LayUiUpload'
            ,accept: 'file' //��ͨ�ļ�
            ,exts: 'zip|rar|7z' //ֻ�����ϴ�ѹ���ļ�
            ,done: function(res){
                console.log(res)
            }
        });

        //�趨�ļ���С����
        upload.render({
            elem: '#test7'
            ,url: '/LayUI_Demo/LayUiUpload'
            ,size: 60 //�����ļ���С����λ KB
            ,done: function(res){
                console.log(res)
            }
        });

        //���ļ��б�ʾ��
        var demoListView = $('#demoList')
            ,uploadListIns = upload.render({
            elem: '#testList'
            ,url: '/LayUI_Demo/LayUiUpload'
            //  ,size: 60 //�����ļ���С����λ KB
            ,accept: 'image/*'
            ,data:{'ID':277}   //�ɷ���չ����  key-value
            ,multiple: true
            ,auto: false
            ,bindAction: '#testListAction'
            ,choose: function(obj){
                var files = this.files = obj.pushFile(); //��ÿ��ѡ����ļ�׷�ӵ��ļ�����
                //��ȡ�����ļ�
                obj.preview(function(index, file, result){
                    var tr = $(['<tr id="upload-'+ index +'">'
                        ,'<td>'+ file.name +'</td>'
                        ,'<td>'+ (file.size/1014).toFixed(1) +'kb</td>'
                        ,'<td>�ȴ��ϴ�</td>'
                        ,'<td>'
                        ,'<button class="layui-btn layui-btn-mini demo-reload layui-hide">�ش�</button>'
                        ,'<button class="layui-btn layui-btn-mini layui-btn-danger demo-delete">ɾ��</button>'
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
                if(res.code == 0){ //�ϴ��ɹ�
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
    });
</script>

</body>
</html>
