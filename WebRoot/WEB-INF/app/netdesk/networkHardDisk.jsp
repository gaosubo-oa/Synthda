<%--
  Created by IntelliJ IDEA.
  User: 骆鹏
  Date: 2017/7/4
  Time: 16:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags"%>

<html>
<head>
    <title><fmt:message code="main.network" /></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <link rel="stylesheet" type="text/css" href="../css/easyui/easyui.css">
    <link rel="stylesheet" type="text/css" href="../css/easyui/icon.css">
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>

    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/swiper.min.css"/>

    <link rel="stylesheet" type="text/css" href="../css/file/swiper.css">

    <link rel="stylesheet" type="text/css" href="../css/cabinet.css?20201106.1">
    <link rel="stylesheet" type="text/css" href="/css/netdesk/networkHardDisk.css?20201106.1">
    <%--<script type="text/javascript" src="../js/easyui/jquery.min.js"></script>--%>
    <script src="/js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="../js/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/easyui/easyui-lang-zh_CN.js"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="../js/base/base.js?20190924.1" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/laydate/laydate.js" type="text/javascript" charset="utf-8"></script>

    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>

    <%--<script src="../js/jquery/jquery.form.min.js" type="text/javascript" ></script>--%>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="/js/common/language.js"></script>
    <script src="/lib/swiper.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/js/networkHardDisk.js?20230113.1" type="text/javascript" ></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>

    <style type="text/css">
        .tree-title{
            color: #333;
            font-size: 14px;
        }
        .addBackground{
            background: #bbbbbb !important;
        }

        .filename{
            width: 100%;
        }

        .head {
            height: 45px;
            line-height: 45px;
            border-bottom: 2px solid #A8C9EA;
            background-color: #F0F4F7;
            width: 660px;
            float: right;
        }
        .neww{
            float: left;
            height: 45px;
            line-height: 45px;
            border-bottom: 2px solid #A8C9EA;
            background-color: #F0F4F7;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        /*定义菜单滚动条*/
        body::-webkit-scrollbar
        {
            width: 0px;
            /*height: 16px;*/
            /*background-color: #F5F5F5;*/
        }
        /*定义滚动条轨道 内阴影+圆角*/
        body::-webkit-scrollbar-track
        {
            /*-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);*/
            border-radius: 50px;
            background-color: #ffffff;
        }

        /*定义滑块 内阴影+圆角*/
        body::-webkit-scrollbar-thumb
        {
            border-radius: 50px;
            /*-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);*/
            background-color: #c0c0c0;
        }
        .floatDiv{
            position: absolute;
            left: 30px;
            width: 150px;
            /*height: 60px;*/
            border: #ccc 1px solid;
            border-radius: 4px;
            background-color: #ffffff;
            z-index: 99;
        }
        .floatDiv>div{
            height: 29px;
            width: 100%;
            line-height: 29px;
            text-align: center;
            cursor: pointer;
        }
        .floatDiv>div:hover{
            background-color: #6ea1d5;
            color: #ffffff;
        }
        .closeBtn{
            width: 60px;
            height: 60px;
            border-radius: 50%;
            position: fixed;
            right: 20px;
            top: 20px;
            z-index: 99;
        }
        .M-box3 {
            margin-top: 10px;
            float: right;
        }
        .M-box3 .active {
            margin: 0px 3px;
            width: 29px;
            height: 29px;
            line-height: 29px;
            background: #2b7fe0;
            font-size: 12px;
            border: 1px solid #2b7fe0;
        }
        .jump-ipt {
            margin: 0 3px;
            width: 29px;
            height: 29px;
            line-height: 29px;
            font-size: 12px;
            float: left;
        }
        .jump-ipt {
            border: #ccc 1px solid;
        }
        .M-box3 a {
            margin: 0 3px;
            width: 29px;
            height: 29px;
            line-height: 29px;
            font-size: 12px;
            text-decoration: none;
        }
        #fileName p {
            font-size: 11pt;
            line-height: 25px;
        }
        .bar {
            height: 26px;
            background: green;
        }
        .viewer-container,.viewer-navbar{background-color:#000;overflow:hidden}
        .viewer-canvas,.viewer-container,.viewer-footer,.viewer-player{right:0;bottom:0;left:0}
        .viewer-button,.viewer-canvas,.viewer-container,.viewer-footer,.viewer-list,.viewer-navbar,.viewer-open,.viewer-title,.viewer-toolbar,.viewer-toolbar>li{overflow:hidden}
        .viewer-close:before,.viewer-flip-horizontal:before,.viewer-flip-vertical:before,.viewer-fullscreen-exit:before,.viewer-fullscreen:before,.viewer-next:before,.viewer-one-to-one:before,.viewer-play:before,.viewer-prev:before,.viewer-reset:before,.viewer-rotate-left:before,.viewer-rotate-right:before,.viewer-zoom-in:before,.viewer-zoom-out:before{font-size:0;line-height:0;display:block;width:20px;height:20px;color:transparent;background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAARgAAAAUCAYAAABWOyJDAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEgAACxIB0t1+/AAAABx0RVh0U29mdHdhcmUAQWRvYmUgRmlyZXdvcmtzIENTNui8sowAAAQPSURBVHic7Zs/iFxVFMa/0U2UaJGksUgnIVhYxVhpjDbZCBmLdAYECxsRFBTUamcXUiSNncgKQbSxsxH8gzAP3FU2jY0kKKJNiiiIghFlccnP4p3nPCdv3p9778vsLOcHB2bfveeb7955c3jvvNkBIMdxnD64a94GHMfZu3iBcRynN7zAOI7TG15gHCeeNUkr8zaxG2lbYDYsdgMbktBsP03jdQwljSXdtBhLOmtjowC9Mg9L+knSlcD8TNKpSA9lBpK2JF2VdDSR5n5J64m0qli399hNFMUlpshQii5jbXTbHGviB0nLNeNDSd9VO4A2UdB2fp+x0eCnaXxWXGA2X0au/3HgN9P4LFCjIANOJdrLr0zzZ+BEpNYDwKbpnQMeAw4m8HjQtM6Z9qa917zPQwFr3M5KgA6J5rTJCdFZJj9/lyvGhsDvwFNVuV2MhhjrK6b9bFiE+j1r87eBl4HDwCF7/U/k+ofAX5b/EXBv5JoLMuILzf3Ap6Z3EzgdqHMCuF7hcQf4HDgeoHnccncqdK/TvSDWffFXI/exICY/xZyqc6XLWF1UFZna4gJ7q8BsRvgd2/xXpo6P+D9dfT7PpECtA3cnWPM0GXGFZh/wgWltA+cDNC7X+AP4GzjZQe+k5dRxuYPeiuXU7e1qwLpDz7dFjXKRaSwuMLvAlG8zZlG+YmiK1HoFqT7wP2z+4Q45TfEGcMt01xLoNZEBTwRqD4BLpnMLeC1A41UmVxsXgXeBayV/Wx20rpTyrpnWRft7p6O/FdqzGrDukPNtkaMoMo3FBdBSQMOnYBCReyf05s126fU9ytfX98+mY54Kxnp7S9K3kj6U9KYdG0h6UdLbkh7poFXMfUnSOyVvL0h6VtIXHbS6nOP+s/Zm9mvyXW1uuC9ohZ72E9uDmXWLJOB1GxsH+DxPftsB8B6wlGDN02TAkxG6+4D3TWsbeC5CS8CDFce+AW500LhhOW2020TRjK3b21HEmgti9m0RonxbdMZeVzV+/4tF3cBpP7E9mKHNL5q8h5g0eYsCMQz0epq8gQrwMXAgcs0FGXGFRcB9wCemF9PkbYqM/Bas7fxLwNeJPdTdpo4itQti8lPMqTpXuozVRVXPpbHI3KkNTB1NfkL81j2mvhDp91HgV9MKuRIqrykj3WPq4rHyL+axj8/qGPmTqi6F9YDlHOvJU6oYcTsh/TYSzWmTE6JT19CtLTJt32D6CmHe0eQn1O8z5AXgT4sx4Vcu0/EQecMydB8z0hUWkTd2t4CrwNEePqMBcAR4mrBbwyXLPWJa8zrXmmLEhNBmfpkuY2102xxrih+pb+ieAb6vGhuA97UcJ5KR8gZ77K+99xxeYBzH6Q3/Z0fHcXrDC4zjOL3hBcZxnN74F+zlvXFWXF9PAAAAAElFTkSuQmCC);background-repeat:no-repeat}
        .viewer-zoom-in:before{content:'Zoom In';background-position:0 0}
        .viewer-zoom-out:before{content:'Zoom Out';background-position:-20px 0}
        .viewer-one-to-one:before{content:'One to One';background-position:-40px 0}
        .viewer-reset:before{content:'Reset';background-position:-60px 0}
        .viewer-prev:before{content:'Previous';background-position:-80px 0}
        .viewer-play:before{content:'Play';background-position:-100px 0}
        .viewer-next:before{content:'Next';background-position:-120px 0}
        .viewer-rotate-left:before{content:'Rotate Left';background-position:-140px 0}
        .viewer-rotate-right:before{content:'Rotate Right';background-position:-160px 0}
        .viewer-flip-horizontal:before{content:'Flip Horizontal';background-position:-180px 0}
        .viewer-flip-vertical:before{content:'Flip Vertical';background-position:-200px 0}
        .viewer-fullscreen:before{content:'Enter Full Screen';background-position:-220px 0}
        .viewer-fullscreen-exit:before{content:'Exit Full Screen';background-position:-240px 0}
        .viewer-close:before{content:'Close';background-position:-260px 0}
        .viewer-container{font-size:0;line-height:0;position:absolute;top:0;-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;background-color:rgba(0,0,0,.5);direction:ltr!important;-ms-touch-action:none;touch-action:none;-webkit-tap-highlight-color:transparent;-webkit-touch-callout:none}.viewer-container ::-moz-selection,.viewer-container::-moz-selection{background-color:transparent}.viewer-container ::selection,.viewer-container::selection{background-color:transparent}.viewer-container img{display:block;width:100%;min-width:0!important;max-width:none!important;height:auto;min-height:0!important;max-height:none!important}.viewer-player,.viewer-tooltip{display:none;position:absolute}.viewer-canvas{position:absolute;top:0}.viewer-canvas>img{width:auto;max-width:90%!important;height:auto;margin:15px auto}
        .viewer-footer{position:absolute;text-align:center}
        .viewer-navbar{background-color:rgba(0,0,0,.5)}
        .viewer-list{-webkit-box-sizing:content-box;-moz-box-sizing:content-box;box-sizing:content-box;height:50px;margin:0;padding:1px 0}
        .viewer-list>li{font-size:0;line-height:0;float:left;overflow:hidden;width:30px;height:50px;cursor:pointer;opacity:.5;color:transparent;filter:alpha(opacity=50)}
        .viewer-list>li+li{margin-left:1px}.viewer-list>.viewer-active{opacity:1;filter:alpha(opacity=100)}
        .viewer-player{top:0;cursor:none;background-color:#000}
        .viewer-player>img{position:absolute;top:0;left:0}
        .viewer-toolbar{width:280px;margin:0 auto 5px;padding:3px 0}
        .viewer-toolbar>li{float:left;width:24px;height:24px;cursor:pointer;border-radius:50%;background-color:#000;background-color:rgba(0,0,0,.5)}
        .viewer-toolbar>li:hover{background-color:#000;background-color:rgba(0,0,0,.8)}
        .viewer-toolbar>li:before{margin:2px}.viewer-toolbar>li+li{margin-left:1px}
        .viewer-toolbar>.viewer-play{width:30px;height:30px;margin-top:-3px;margin-bottom:-3px}
        .viewer-toolbar>.viewer-play:before{margin:5px}
        .viewer-tooltip{font-size:12px;line-height:20px;top:50%;left:50%;width:50px;height:20px;margin-top:-10px;margin-left:-25px;text-align:center;color:#fff;border-radius:10px;background-color:#000;background-color:rgba(0,0,0,.8)}
        .viewer-title{font-size:12px;line-height:1;display:inline-block;max-width:90%;margin:0 5% 5px;white-space:nowrap;text-overflow:ellipsis;opacity:.8;color:#ccc;filter:alpha(opacity=80)}
        .viewer-title:hover{opacity:1;filter:alpha(opacity=100)}.viewer-button{position:absolute;top:-40px;right:-40px;width:80px;height:80px;cursor:pointer;border-radius:50%;background-color:#000;background-color:rgba(0,0,0,.5)}
        .viewer-button:before{position:absolute;bottom:15px;left:15px}.viewer-fixed{position:fixed}
        .viewer-show{display:block}.viewer-hide{display:none}.viewer-invisible{visibility:hidden}
        .viewer-move{cursor:move;cursor:-webkit-grab;cursor:-moz-grab;cursor:grab}
        .viewer-fade{opacity:0;filter:alpha(opacity=0)}.viewer-in{opacity:1;filter:alpha(opacity=100)}
        .viewer-transition{-webkit-transition:all .3s ease-out;-o-transition:all .3s ease-out;transition:all .3s ease-out}@media (max-width:767px){.viewer-hide-xs-down{display:none}}@media (max-width:991px){.viewer-hide-sm-down{display:none}}@media (max-width:1199px){.viewer-hide-md-down{display:none}}

    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<form id="form" action="/netdisk/downLoadZipFile" method="post" style="visibility: hidden">
    <input type="hidden" id="pathName" value="">
    <button type="submit" id="submit" style="visibility: hidden"></button>
</form>
<div class="diskDiv" style="width: 100%">
    <div class="cabinet_left">
        <div  id="personal" style="width:100%;height:44px;line-height:44px;border-bottom: #9e9e9e 1px solid;">
            <div class="div_Img">
                <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_publicFile.png" style="vertical-align: middle;" alt="">
            </div>
            <div class="divP"><fmt:message code="main.network" /></div>
        </div>
        <div id="fileTransfor">

        </div>
    </div>
    <div class="cabinet_info">


        <div class="noData" id="noFile" style="display: none;"><!--路径-->
            <div class="bgImg">
                <div class="IMG">
                    <img src="../img/sys/icon64_info.png">
                </div>
                <div class="TXT" id="TXT"><fmt:message code="doc.th.IncorrectPath" /></div>
            </div>
        </div>




        <%--style="line-height: 33px;margin: 10px 0px;background: #ebeef5;padding-left: 10px;font-size: 11pt;"--%>
        <div class="mainContent" id="mainContent" style="display: block"><!--文档-->
            <div class="neww">
                <span style="margin-left: 20px;font-size: 11pt;"><fmt:message code="main.network" /></span>
                <label>
                    <span></span>
                </label>
            </div>
            <div class="head w clearfix">
                <input type="hidden" class="wangpanId" value="">
                <div id="batch" class="ss twos clearfix" style="position: relative">
                    <form id="uploadimgform" target="uploadiframe" action="" enctype="multipart/form-data" method="post">
                        <div class="formfile formfile1" style="top: 0;left: -80px;">
                            <input type="hidden" name="path">
                            <a href="javascript:void(0)" ><img style="margin-top: -3px;margin-left: -17px;margin-right: 3px;" src="../../img/mywork/newbuildworjk.png" alt=""><fmt:message code="doc.th.SingleUpload" /></a>
                            <input type="file" name="file"  onchange="filechangess($(this),0)"  class="w-icon5" num="1" >
                        </div>


                        <div class="formfile formfile2" style="top: 0;right: 0px;">
                            <a href="javascript:void(0)" id="uploadimg"><img style="margin-top: -3px;margin-left: -17px;margin-right: 3px;" src="../../img/mywork/shangchuan.png" alt=""><fmt:message code="notice.th.up" /></a>
                            <input type="file" name="file" id="uploadinputimg" onchange="filechangess($(this),1)"    multiple="multiple" class="w-icon5"  num="2">

                        </div>
                    </form>
                </div>
                <div class="ss one" id="newsAdd"> <a id="contentAdd" href="javascript:;"><img style="margin-top: -3px;margin-left: -17px;margin-right: 3px;" src="../../img/mywork/newbuildworjk.png" alt=""><fmt:message code="adding.th.newF"/></a></div>
                <div class="selected" id="one_selected" style="display: block;">

                    <div id="TitleOne" class="doTitle"><img src="/img/file/icon_fileCabinet.png" style="margin-right: 4px;margin-left: -2px;margin-bottom: 3px;" alt=""><fmt:message code="file.th.op" /><img src="/img/file/icon_triangle.png" style="margin-left: 5px;margin-bottom: 3px;" alt=""></div>
                    <div id="classA" class="hideDiv" style="display: none;width: 125px;">
                        <ul>
                            <li data-id="1" id="folderEdit" style="display: none;"><fmt:message code="doc.th.RenameFolder" /></li>
                            <li data-id="2" id="folderDelete" style="display: block;"><fmt:message code="doc.th.DeleteFolder" /></li>
                        </ul>
                    </div>
                </div>
                <%--<div id="SEARCH" class="ss three"> <a class="SEARCH" href="javascript:;"><fmt:message code="workflow.th.sousuo" /></a></div>--%>


                <div class="selected"  style="display: block;width: 85px;">

                    <div  class="doTitle"><img src="/img/file/icon_fileCabinet.png" style="margin-right: 4px;margin-left: -2px;margin-bottom: 3px;" alt=""><fmt:message code="global.lang.order" /><img src="/img/file/icon_triangle.png" style="margin-left: 5px;margin-bottom: 3px;" alt=""></div>
                    <div  class="hideDiv" style="display: none;width: 125px;">
                        <ul id="typeActive" style="border-bottom: 1px solid #ddd">
                            <li class="typeActive" data-id="0"><fmt:message code="doc.th.ByName" /></li>
                            <li data-id="1"><fmt:message code="doc.th.Bytype" /></li>
                            <li data-id="2"><fmt:message code="doc.th.BySize" /></li>
                            <li data-id="3"><fmt:message code="doc.th.PressModifyTime" /></li>
                        </ul>
                        <ul id="sortActive">
                            <li class="sortActive" data-num="0"><fmt:message code="netdisk.th.asc" /></li>
                            <li data-num="1"><fmt:message code="netdisk.th.desc" /></li>
                        </ul>
                    </div>
                </div>




            </div>
            <div style="clear: both;"></div>
            <!--middle部分开始-->
            <div class="w" style="margin-top: 10px;">
                <div class="wrap">
                    <input type="hidden" name="sortTxt" value="<fmt:message code="doc.th.CompanySystem" />">
                    <input type="hidden" name="folderId" value="6">
                    <table class="w">
                        <thead>
                        <tr>
                            <td class="th" align="center" width="10%"><input id="checkedAll" type="checkbox">
                                <label for="checkedAll"><fmt:message code="notice.th.allchose" /></label></td>
                            <td class="th" width="40%" align="center"><fmt:message code="file.th.name" /></td>
                            <td class="th" width="10%" align="center"><fmt:message code="notice.th.type" /></td>
                            <td class="th" width="15%" align="center">
                                <fmt:message code="netdisk.th.Size" />
                            </td>
                            <td class="th" width="25%" align="center">
                                <fmt:message code="email.th.time" />
                            </td>
                        </tr>
                        </thead>
                        <tbody id="file_Tachr">
                        </tbody>
                    </table>
                    <div class="right" style="height: 42px;">
                        <!-- 分页按钮-->
                        <div class="M-box3" id="dbgz_pagesd"></div>
                    </div>
                </div>
            </div>
            <!--bottom 部分开始-->
            <div class="bottom w">

                <div class="boto addBackground" id="singReading" style="display: none; width: 100px;">
                    <a class="ONES dowmloadOne" href="javascript:void (0)" style="width: 100px;"><img src="/img/file/icon_download.png" style="margin-right: 4px;margin-left: -2px;margin-bottom: 3px;" alt=""><fmt:message code="file.th.download" /></a>
                </div>
                <div class="boto addBackground" id="copy" style="display: none;">
                    <a class="TWOS copyfile" data-numcopy="0" href="javascript:void (0)"><img src="/img/file/icon_copy.png" style="margin-right: 4px;margin-left: -2px;margin-bottom: 3px;" alt=""><fmt:message code="file.th.copy" /></a>
                </div>
                <div class="boto addBackground" id="shear" style="display: none;">
                    <a class="copyfile" data-numcopy="1" href="javascript:void (0)"><img src="/img/file/icon_cut.png" style="margin-right: 4px;margin-left: -2px;margin-bottom: 3px;" alt=""><fmt:message code="file.th.cut" /></a>
                </div>
                <div class="boto addBackground" id="paste" style="display: none;">
                    <a class="SIX" href="javascript:void (0)"><img src="/img/file/icon_paste_s.png" style="margin-right: 4px;margin-left: -2px;margin-bottom: 3px;" alt=""><fmt:message code="fille.th.paste" /></a>
                </div>
                <div class="boto addBackground" id="deletebtn" style="display: none;">
                    <a class="FOURs" href="javascript:void (0)"><img src="/img/file/icon_fileDelete.png" style="margin-right: 4px;margin-left: -2px;margin-bottom: 3px;" alt=""><fmt:message code="global.lang.delete" /></a>
                </div>
                <div class="boto addBackground" id="download" style="display: none;">
                    <a class="FIVE" href="javascript:void (0)"><img src="/img/file/icon_download.png" style="margin-right: 4px;margin-left: -2px;margin-bottom: 3px;" alt=""><fmt:message code="file.th.download" /></a>
                </div>

            </div>
            <div class="attach" style="display: none">
                <div style="overflow: hidden;">
                    <div class="progress" id="progress" style="width: 200px;float: left;margin-left: 10px;margin-top: -12px;">
                        <div class="bar" style="width: 0%;"></div>
                    </div>
                    <div class="barText" style="float: left;margin-left: 10px;"></div>
                </div>

                <div class="box" id="fileName"></div>
                <%--<div class="remind">
                    <p>事务提醒：</p>
                    <input type="radio" name="remindUser" value="">
                    <span>手动选择被提醒人员</span>
                    <input type="radio" name="remindUser" value="">
                    <span>提醒全部有权限人员</span>
                </div>
                <div class="inPole">
                    <textarea name="txt" id="dePsenduser" user_id='' value="" disabled style="min-width: 200px;min-height: 50px;"></textarea>
                    <span class="add_img" style="margin-left: 10px">
                        <a href="javascript:;" id="selectUserDep" class="Add " style="color:#207bd6;">添加</a>
                    </span>
                    <span class="add_img">
						<a href="javascript:;" class="clear" style="color:#207bd6;">清除</a>
					</span>
                </div>
                <div class="share">
                    <input type="checkbox" name="share" value="">
                    <span>分享到企业社区</span>
                </div>--%>
                <div id="reminds">
                    <input type="checkbox" name="remind" class="remindCheck" value="0" checked>
                    <fmt:message code="notice.th.remindermessage" />&nbsp;
                    <input type="checkbox" name="smsDefault"  class="smsDefault" value="1" >
                    <span class="hideSpan" ><fmt:message code="vote.th.UseRemind" /></span>
                </div>
                <div class="divBtns" style="margin-top:12px">
                    <div class="start" id="start" onclick="startUpload()"><fmt:message code="file.th.StartUploading"/></div>
                    <div class="cancle" onclick="cancless()"><fmt:message code="file.th.cancelAll"/></div>
                </div>
            </div>
        </div>
    </div>
</div>

<div style="clear: both;"></div>

<div class="footer" style="display: none;">
    <div class="closeBtn"><img src="/img/closelunbo.png" alt=""></div>
    <div class="swiper-container">
        <div class="swiper-wrapper">

        </div>
        <!-- Add Arrows -->
        <div class="swiper-button-next"></div>
        <div class="swiper-button-prev"></div>
    </div>
</div>

</body>
</html>
