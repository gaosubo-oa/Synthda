var stafid=getQueryString('staffId');
$(function () {
    hetongData();
//    点击相关信息
    $('.xiangguanxinxi').click(function () {
        $('.relewantInfo').slideToggle();
        // $('.relewantInfo').toggle();
    });
//    点击导航切换
    $('.item1').click(function () {
        $(this).find('.headli1_1').addClass('on').end().siblings().find('.headli1_1').removeClass('on');
        var dataNum=$(this).attr('data-num');
        $('.btnNew').attr('data-type',dataNum);
        switch(dataNum)
        {
            case '0':
                $('.boxText').html('个人合同');
                $('.btnNew').html('新建合同信息');
                hetongData();
                break;
            case '1':
                $('.boxText').html('个人奖惩信息');
                $('.btnNew').html('新建奖惩信息');
                jiangchengData();
                break;
            case '2':
                $('.boxText').html('证照信息');
                $('.btnNew').html('新建证照信息');
                zhengzhaoData();
                break;
            case '3':
                $('.boxText').html('学习经历');
                $('.btnNew').html('新建学习经历信息');
                xuexiData();
                break;
            case '4':
                $('.boxText').html('工作经历');
                $('.btnNew').html('新建工作经历信息');
                gongzuoData();
                break;
            case '5':
                $('.boxText').html('劳动技能');
                $('.btnNew').html('新建劳动技能信息');
                laodongData();
                break;
            case '6':
                $('.boxText').html('社会关系');
                $('.btnNew').html('新建社会关系信息');
                guanxiData();
                break;
            case '7':
                $('.boxText').html('人事调动');
                $('.btnNew').html('新建人事调动信息');
                renshiData();
                break;
            case '8':
                $('.boxText').html('员工离职');
                $('.btnNew').html('新建员工离职信息');
                lizhiData();
                break;
            case '9':
                $('.boxText').html('复职信息');
                $('.btnNew').html('新建员工复职信息');
                fuzhiData();
                break;
            case '10':
                $('.boxText').html('职称评定');
                $('.btnNew').html('新建职称评定信息');
                zhichengData();
                break;
            case '11':
                $('.boxText').html('员工关怀');
                $('.btnNew').html('新建员工关怀信息');
                guanhuaiData();
                break;
            case '12':
                $('.boxText').html('员工培训');
                $('.btnNew').html('新建员工培训信息');
                peixunData();
                break;
            default:
                return
        }
    });
//    点击关闭
    $('.item2').click(function () {
        $('.relewantInfo').hide();
    });
//    点击新建
    $('.btnNew').click(function () {
        var dataTypes=$(this).attr('data-type');
        switch(dataTypes)
        {
            case '0':
                $.popWindow('/hr/page/contractNew?typeHr=1','新建合同信息','20','150','1200px','700px');
                break;
            case '1':
                $.popWindow('/Hr/Incentive/bonpenNewedit?typeHr=1','新建奖惩信息','20','150','1200px','700px');
                break;
            case '2':
                $.popWindow('/hr/manage/photoNewedit?typeHr=1','新建证照信息','20','150','1200px','700px');
                break;
            case '3':
                $.popWindow('/learningExperience/newLearningExperience?typeHr=1','新建学习经历信息','20','150','1200px','700px');
                break;
            case '4':
                $.popWindow('/hr/manage/bonpenNewedit?typeHr=1','新建工作经历信息','20','150','1200px','700px');
                break;
            case '5':
                $.popWindow('/hr/manage/Newedit?typeHr=1','新建劳动技能信息','20','150','1200px','700px');
                break;
            case '6':
                $.popWindow('/hr/manage/newSocialRelations?typeHr=1','新建社会关系','20','150','1200px','700px');
                break;
            case '7':
                $.popWindow('/hr/manage/tansferNewedit?typeHr=1','新建人事调动信息','20','150','1200px','700px');
                break;
            case '8':
                break;
            case '9':
                break;
            case '10':
                $.popWindow('/hr/manage/evaluationMessage?typeHr=1','新建职称评定信息','20','150','1200px','700px');
                break;
            case '11':
                $.popWindow('/hr/manage/HrStaffCareNew?typeHr=1','新建员工关怀信息','20','150','1200px','700px');
                break;
            case '12':
                $.popWindow('/record/trainRecordNew?typeHr=1','新建培训记录','20','150','1200px','700px');
                break;
            default:
                return
        }
    });
//    点击编辑
    $('#divTable').on('click','.editData',function () {
        var hrTypr=$('.btnNew').attr('data-type');
        var dataId=$(this).parents('tr').attr('data-id');
        switch(hrTypr)
        {
            case '0':
                $.popWindow('/hr/page/contractNew?typeHr=1&dataId='+dataId,'编辑合同信息','20','150','1200px','700px');
                break;
            case '1':
                $.popWindow('/Hr/Incentive/bonpenNewedit?typeHr=1&dataid='+dataId,'编辑奖惩信息','20','150','1200px','700px');
                break;
            case '2':
                $.popWindow('/hr/manage/photoNewedit?typeHr=1&licenseId='+dataId,'编辑证照信息','20','150','1200px','700px');
                break;
            case '3':
                $.popWindow('/learningExperience/newLearningExperience?typeHr=1&id='+dataId,'编辑学习经历信息','20','150','1200px','700px');
                break;
            case '4':
                $.popWindow('/hr/manage/bonpenNewedit?typeHr=1&dataid='+dataId,'编辑工作经历信息','20','150','1200px','700px');
                break;
            case '5':
                $.popWindow('/hr/manage/Newedit?typeHr=1&dataid='+dataId,'编辑劳动技能信息','20','150','1200px','700px');
                break;
            case '6':
                $.popWindow('/hr/manage/socialRelationUpdate?typeHr=1&id='+dataId,'编辑社会关系','20','150','1200px','700px');
                break;
            case '7':
                $.popWindow('/hr/manage/tansferNewedit?typeHr=1&transferId='+dataId,'编辑人事调动信息','20','150','1200px','700px');
                break;
            case '8':
                break;
            case '9':
                break;
            case '10':
                $.popWindow('/hr/manage/evaluationMessage?typeHr=1&dataid='+dataId,'编辑职称评定信息','20','150','1200px','700px');
                break;
            case '11':
                $.popWindow('/hr/manage/HrStaffCareNew?typeHr=1&careId='+dataId,'编辑员工关怀信息','20','150','1200px','700px');
                break;
            case '12':
                $.popWindow('/hr/manage/HrStaffCareNew?typeHr=1&careId='+dataId,'编辑培训计划','20','150','1200px','700px');
                break;
            default:
                return
        }
    });
//    点击详情
    $('#divTable').on('click','.detailsData',function () {
        var hrTypr=$('.btnNew').attr('data-type');
        var dataId=$(this).parents('tr').attr('data-id');
        switch(hrTypr)
        {
            case '0':
                $.popWindow('/hr/page/contractDetail?contractId='+dataId,'合同信息详情','20','150','1200px','700px');
                break;
            case '1':
                $.popWindow('/Hr/Incentive/bonpenDetail?dataId='+dataId,'合同信息详情','20','150','1200px','700px');
                break;
            case '2':
                $.popWindow('/hr/manage/photoDetail?licenseId='+dataId,'证照信息详情','20','150','1200px','700px');
                break;
            case '3':
                $.popWindow('/learningExperience/learningExperienceDetail?ids='+dataId,'学习经历信息详情','20','150','1200px','700px');
                break;
            case '4':
                $.popWindow('/hr/manage/bonpenDetail?dataId='+dataId,'学习经历信息详情','20','150','1200px','700px');
                break;
            case '5':
                $.popWindow('/hr/manage/Detail?dataId='+dataId,'劳动技能信息详情','20','150','1200px','700px');
                break;
            case '6':
                $.popWindow('/hr/manage/socialRelationsDetail?ids='+dataId,'社会关系详情','20','150','1200px','700px');
                break;
            case '7':
                $.popWindow('/hr/manage/tansferDetail?transferId='+dataId,'人事调动详情','20','150','1200px','700px');
                break;
            case '8':
                break;
            case '9':
                break;
            case '10':
                $.popWindow('/hr/manage/evaluationQueryDetail?dataId='+dataId,'人事调动详情','20','150','1200px','700px');
                break;
            case '11':
                $.popWindow('/hr/manage/HrStaffCareDetail?careId='+dataId,'人事调动详情','20','150','1200px','700px');
                break;
            case '12':
                $.popWindow('/record/goDetail?recordId='+dataId,'培训计划详细信息','20','150','1200px','700px');
                break;
            default:
                return
        }
    })
});
//个人合同
function hetongData() {
    var ajaxPage={
        data:{
            page:1,//当前处于第几页
            pageSize:5,//一页显示几条
            useFlag:true,
            staffName:stafid
        },
        page:function () {
            var me=this;
            $.ajax({
                type:'get',
                url:'/hr/api/getContract',
                dataType:'json',
                data:me.data,
                success:function(res){
                    var str='';
                    var datas=res.obj;
                    var str_s='<tr><th>单位员工</th><th>合同类型</th><th>签署公司</th><th>合同生效日期</th><th>合同到期日期</th><th>操作</th></tr>';
                    if(datas.length > 0){
                        for(var i=0;i<datas.length;i++){
                            str+='<tr data-id="'+datas[i].contractId+'">' +
                                '<td>'+dataundefined(datas[i].staffUserName)+'</td>' +
                                '<td>'+dataundefined((datas[i].contractTypeName))+'</td>' +
                                '<td>'+dataundefined(datas[i].contractEnterpries)+'</td>' +
                                '<td>'+dataundefined((datas[i].probationEffectiveDate))+'</td>' +
                                '<td>'+dataundefined(datas[i].contractEndTime)+'</td>' +
                                '<td>' +
                                '<a href="javascript:;" class="detailsData">查看详情</a>' +
                                '<a href="javascript:;" class="editData" style="margin: 0 10px;">编辑</a>' +
                                '</td>' +
                                '</tr>'
                        }
                    }else{
                        str='<tr><td colspan="6"><img src="/img/main_img/shouyekong.png" alt=""><p>暂无数据</p></td></tr>'
                    }
                    $('#divTable').html(str_s+str);
                    me.pageTwo(res.totleNum,me.data.pageSize,me.data.page);
                }
            });

        },
        pageTwo:function (totalData, pageSize,indexs) {
            var mes=this;
            $('#dbgz_pagesd').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                homePage:'',
                endPage: '',
                current:indexs||1,
                callback: function (index) {
                    mes.data.page=index.getCurrent();
                    mes.page();
                }
            });
        }
    }
    ajaxPage.page();
}
//个人奖惩信息
function jiangchengData() {
    var ajaxPage={
        data:{
            page:1,//当前处于第几页
            pageSize:5,//一页显示几条
            useFlag:true,
            staffName:stafid
        },
        page:function () {
            var me=this;
            $.ajax({
                type:'get',
                url:'/hr/api/getIncentive',
                dataType:'json',
                data:me.data,
                success:function(res){
                    var str='';
                    var datas=res.obj;
                    var str_s='<tr><th>单位员工</th><th>奖惩项目</th><th>奖惩日期</th><th>奖惩属性</th><th>奖惩金额</th><th>操作</th></tr>';
                    if(datas.length > 0){
                        for(var i=0;i<datas.length;i++){
                            str+='<tr data-id="'+datas[i].incentiveId+'">' +
                                '<td>'+dataundefined(datas[i].staffName)+'</td>' +
                                '<td>'+dataundefined((datas[i].incetiveItemName))+'</td>' +
                                '<td>'+dataundefined(datas[i].incentiveTime)+'</td>' +
                                '<td>'+dataundefined((datas[i].incentiveTypeName))+'</td>' +
                                '<td>'+dataundefined(datas[i].incentiveAmount)+'</td>' +
                                '<td>' +
                                '<a href="javascript:;" class="detailsData">查看详情</a>' +
                                '<a href="javascript:;" class="editData" style="margin: 0 10px;">编辑</a>' +
                                '</td>' +
                                '</tr>'
                        }
                    }else{
                        str='<tr><td colspan="6"><img src="/img/main_img/shouyekong.png" alt=""><p>暂无数据</p></td></tr>'
                    }
                    $('#divTable').html(str_s+str);
                    me.pageTwo(res.totleNum,me.data.pageSize,me.data.page);
                }
            });

        },
        pageTwo:function (totalData, pageSize,indexs) {
            var mes=this;
            $('#dbgz_pagesd').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                homePage:'',
                endPage: '',
                current:indexs||1,
                callback: function (index) {
                    mes.data.page=index.getCurrent();
                    mes.page();
                }
            });
        }
    }
    ajaxPage.page();
}
//证照信息
function zhengzhaoData() {
    var ajaxPage={
        data:{
            page:1,//当前处于第几页
            pageSize:5,//一页显示几条
            useFlag:true,
            staffName:stafid
        },
        page:function () {
            var me=this;
            $.ajax({
                type:'get',
                url:'/hr/api/getPhoto',
                dataType:'json',
                data:me.data,
                success:function(res){
                    var str='';
                    var datas=res.obj;
                    var str_s='<tr><th>单位员工</th><th>证件类型</th><th>证件编号</th><th>证件名称</th><th>状态</th><th>操作</th></tr>';
                    if(datas.length > 0){
                        for(var i=0;i<datas.length;i++){
                            str+='<tr data-id="'+datas[i].licenseId+'">' +
                                '<td>'+dataundefined(datas[i].staffName)+'</td>' +
                                '<td>'+dataundefined((datas[i].licenseType))+'</td>' +
                                '<td>'+dataundefined(datas[i].licenseNo)+'</td>' +
                                '<td>'+dataundefined((datas[i].licenseName))+'</td>' +
                                '<td>'+dataundefined(datas[i].status)+'</td>' +
                                '<td>' +
                                '<a href="javascript:;" class="detailsData">查看详情</a>' +
                                '<a href="javascript:;" class="editData" style="margin: 0 10px;">编辑</a>' +
                                '</td>' +
                                '</tr>'
                        }
                    }else{
                        str='<tr><td colspan="6"><img src="/img/main_img/shouyekong.png" alt=""><p>暂无数据</p></td></tr>'
                    }
                    $('#divTable').html(str_s+str);
                    me.pageTwo(res.totleNum,me.data.pageSize,me.data.page);
                }
            });

        },
        pageTwo:function (totalData, pageSize,indexs) {
            var mes=this;
            $('#dbgz_pagesd').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                homePage:'',
                endPage: '',
                current:indexs||1,
                callback: function (index) {
                    mes.data.page=index.getCurrent();
                    mes.page();
                }
            });
        }
    }
    ajaxPage.page();
}
//学习经历
function xuexiData() {
    var ajaxPage={
        data:{
            page:1,//当前处于第几页
            pageSize:5,//一页显示几条
            useFlag:true,
            staffName:stafid
        },
        page:function () {
            var me=this;
            $.ajax({
                type:'get',
                url:'/hr/api/getLearning',
                dataType:'json',
                data:me.data,
                success:function(res){
                    var str='';
                    var datas=res.obj;
                    var str_s='<tr><th>员工姓名</th><th>所学专业</th><th>所获学历</th><th>所在院校</th><th>证明人</th><th>操作</th></tr>';
                    if(datas.length > 0){
                        for(var i=0;i<datas.length;i++){
                            str+='<tr data-id="'+datas[i].id+'">' +
                                '<td>'+dataundefined(datas[i].userId)+'</td>' +
                                '<td>'+dataundefined((datas[i].profession))+'</td>' +
                                '<td>'+dataundefined(datas[i].academic)+'</td>' +
                                '<td>'+dataundefined((datas[i].university))+'</td>' +
                                '<td>'+dataundefined(datas[i].certificate)+'</td>' +
                                '<td>' +
                                '<a href="javascript:;" class="detailsData">查看详情</a>' +
                                '<a href="javascript:;" class="editData" style="margin: 0 10px;">编辑</a>' +
                                '</td>' +
                                '</tr>'
                        }
                    }else{
                        str='<tr><td colspan="6"><img src="/img/main_img/shouyekong.png" alt=""><p>暂无数据</p></td></tr>'
                    }
                    $('#divTable').html(str_s+str);
                    me.pageTwo(res.totleNum,me.data.pageSize,me.data.page);
                }
            });

        },
        pageTwo:function (totalData, pageSize,indexs) {
            var mes=this;
            $('#dbgz_pagesd').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                homePage:'',
                endPage: '',
                current:indexs||1,
                callback: function (index) {
                    mes.data.page=index.getCurrent();
                    mes.page();
                }
            });
        }
    }
    ajaxPage.page();
}
//工作经历
function gongzuoData() {
    var ajaxPage={
        data:{
            page:1,//当前处于第几页
            pageSize:5,//一页显示几条
            useFlag:true,
            staffName:stafid
        },
        page:function () {
            var me=this;
            $.ajax({
                type:'get',
                url:'/hr/api/getWork',
                dataType:'json',
                data:me.data,
                success:function(res){
                    var str='';
                    var datas=res.obj;
                    var str_s='<tr><th>员工姓名</th><th>工作单位</th><th>行业类别</th><th>担任职务</th><th>证明人</th><th>操作</th></tr>';
                    if(datas.length > 0){
                        for(var i=0;i<datas.length;i++){
                            str+='<tr data-id="'+datas[i].wExperienceId+'">' +
                                '<td>'+dataundefined(datas[i].staffName)+'</td>' +
                                '<td>'+dataundefined((datas[i].workUnit))+'</td>' +
                                '<td>'+dataundefined(datas[i].mobile)+'</td>' +
                                '<td>'+dataundefined((datas[i].postOfJob))+'</td>' +
                                '<td>'+dataundefined(datas[i].witness)+'</td>' +
                                '<td>' +
                                '<a href="javascript:;" class="detailsData">查看详情</a>' +
                                '<a href="javascript:;" class="editData" style="margin: 0 10px;">编辑</a>' +
                                '</td>' +
                                '</tr>'
                        }
                    }else{
                        str='<tr><td colspan="6"><img src="/img/main_img/shouyekong.png" alt=""><p>暂无数据</p></td></tr>'
                    }
                    $('#divTable').html(str_s+str);
                    me.pageTwo(res.totleNum,me.data.pageSize,me.data.page);
                }
            });

        },
        pageTwo:function (totalData, pageSize,indexs) {
            var mes=this;
            $('#dbgz_pagesd').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                homePage:'',
                endPage: '',
                current:indexs||1,
                callback: function (index) {
                    mes.data.page=index.getCurrent();
                    mes.page();
                }
            });
        }
    }
    ajaxPage.page();
}
//劳动技能
function laodongData() {
    var ajaxPage={
        data:{
            page:1,//当前处于第几页
            pageSize:5,//一页显示几条
            useFlag:true,
            staffName:stafid
        },
        page:function () {
            var me=this;
            $.ajax({
                type:'get',
                url:'/hr/manage/getSkill',
                dataType:'json',
                data:me.data,
                success:function(res){
                    var str='';
                    var datas=res.obj;
                    var str_s='<tr><th>单位员工</th><th>技能名称</th><th>级别</th><th>发证日期</th><th>有效期</th><th>操作</th></tr>';
                    if(datas.length > 0){
                        for(var i=0;i<datas.length;i++){
                            str+='<tr data-id="'+datas[i].skillsId+'">' +
                                '<td>'+dataundefined(datas[i].staffName)+'</td>' +
                                '<td>'+dataundefined(datas[i].abilityName)+'</td>' +
                                '<td>'+dataundefined((datas[i].skillsLevel))+'</td>' +
                                '<td>'+dataundefined(datas[i].issueDate)+'</td>' +
                                '<td>'+dataundefined((datas[i].expires))+'</td>' +
                                '<td>' +
                                '<a href="javascript:;" class="detailsData">查看详情</a>' +
                                '<a href="javascript:;" class="editData" style="margin: 0 10px;">编辑</a>' +
                                '</td>' +
                                '</tr>'
                        }
                    }else{
                        str='<tr><td colspan="6"><img src="/img/main_img/shouyekong.png" alt=""><p>暂无数据</p></td></tr>'
                    }
                    $('#divTable').html(str_s+str);
                    me.pageTwo(res.totleNum,me.data.pageSize,me.data.page);
                }
            });

        },
        pageTwo:function (totalData, pageSize,indexs) {
            var mes=this;
            $('#dbgz_pagesd').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                homePage:'',
                endPage: '',
                current:indexs||1,
                callback: function (index) {
                    mes.data.page=index.getCurrent();
                    mes.page();
                }
            });
        }
    }
    ajaxPage.page();
}
//社会关系
function guanxiData() {
    var ajaxPage={
        data:{
            page:1,//当前处于第几页
            pageSize:5,//一页显示几条
            useFlag:true,
            staffName:stafid
        },
        page:function () {
            var me=this;
            $.ajax({
                type:'get',
                url:'/hr/api/getSocia',
                dataType:'json',
                data:me.data,
                success:function(res){
                    var str='';
                    var datas=res.obj;
                    var str_s='<tr><th>员工姓名</th><th>成员姓名</th><th>与本人关系</th><th>职业</th><th>联系电话（个人）</th><th>操作</th></tr>';
                    if(datas.length > 0){
                        for(var i=0;i<datas.length;i++){
                            str+='<tr data-id="'+datas[i].socialRelId+'">' +
                                '<td>'+dataundefined(datas[i].staffRole)+'</td>' +
                                '<td>'+dataundefined(datas[i].staffName)+'</td>' +
                                '<td>'+dataundefined((datas[i].relationShipName))+'</td>' +
                                '<td>'+dataundefined(datas[i].occupation)+'</td>' +
                                '<td>'+dataundefined((datas[i].phone))+'</td>' +
                                '<td>' +
                                '<a href="javascript:;" class="detailsData">查看详情</a>' +
                                '<a href="javascript:;" class="editData" style="margin: 0 10px;">编辑</a>' +
                                '</td>' +
                                '</tr>'
                        }
                    }else{
                        str='<tr><td colspan="6"><img src="/img/main_img/shouyekong.png" alt=""><p>暂无数据</p></td></tr>'
                    }
                    $('#divTable').html(str_s+str);
                    me.pageTwo(res.totleNum,me.data.pageSize,me.data.page);
                }
            });

        },
        pageTwo:function (totalData, pageSize,indexs) {
            var mes=this;
            $('#dbgz_pagesd').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                homePage:'',
                endPage: '',
                current:indexs||1,
                callback: function (index) {
                    mes.data.page=index.getCurrent();
                    mes.page();
                }
            });
        }
    }
    ajaxPage.page();
}
//人事调动
function renshiData() {
    var ajaxPage={
        data:{
            page:1,//当前处于第几页
            pageSize:5,//一页显示几条
            useFlag:true,
            staffName:stafid
        },
        page:function () {
            var me=this;
            $.ajax({
                type:'get',
                url:'/hr/api/getTrans',
                dataType:'json',
                data:me.data,
                success:function(res){
                    var str='';
                    var datas=res.obj;
                    var str_s='<tr><th>调动人员</th><th>调动类型</th><th>调动日期</th><th>调动生效日期</th><th>操作</th></tr>';
                    if(datas.length > 0){
                        for(var i=0;i<datas.length;i++){
                            str+='<tr data-id="'+datas[i].transferId+'">' +
                                '<td>'+dataundefined(datas[i].transferPersonName)+'</td>' +
                                '<td>'+dataundefined(datas[i].transferType)+'</td>' +
                                '<td>'+dataundefined((datas[i].transferDate))+'</td>' +
                                '<td>'+dataundefined(datas[i].transferEffectiveDate)+'</td>' +
                                '<td>' +
                                '<a href="javascript:;" class="detailsData">查看详情</a>' +
                                '<a href="javascript:;" class="editData" style="margin: 0 10px;">编辑</a>' +
                                '</td>' +
                                '</tr>'
                        }
                    }else{
                        str='<tr><td colspan="5"><img src="/img/main_img/shouyekong.png" alt=""><p>暂无数据</p></td></tr>'
                    }
                    $('#divTable').html(str_s+str);
                    me.pageTwo(res.totleNum,me.data.pageSize,me.data.page);
                }
            });

        },
        pageTwo:function (totalData, pageSize,indexs) {
            var mes=this;
            $('#dbgz_pagesd').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                homePage:'',
                endPage: '',
                current:indexs||1,
                callback: function (index) {
                    mes.data.page=index.getCurrent();
                    mes.page();
                }
            });
        }
    }
    ajaxPage.page();
}
//员工离职
function lizhiData() {
    var ajaxPage={
        data:{
            page:1,//当前处于第几页
            pageSize:5,//一页显示几条
            useFlag:true,
            staffName:stafid
        },
        page:function () {
            var me=this;
            $.ajax({
                type:'get',
                url:'/hr/api/getLeave',
                dataType:'json',
                data:me.data,
                success:function(res){
                    var str='';
                    var datas=res.obj;
                    var str_s='<tr><th>离职人员</th><th>离职类型</th><th>拟离职日期</th><th>工资截止日期</th><th>操作</th></tr>';
                    if(datas.length > 0){
                        for(var i=0;i<datas.length;i++){
                            str+='<tr data-id="'+datas[i].leaveId+'">' +
                                '<td>'+dataundefined(datas[i].leavePerson)+'</td>' +
                                '<td>'+dataundefined(datas[i].quitType)+'</td>' +
                                '<td>'+dataundefined((datas[i].quitTimePlan))+'</td>' +
                                '<td>'+dataundefined(datas[i].lastSalaryTime)+'</td>' +
                                '<td>' +
                                '<a href="javascript:;" class="detailsData">查看详情</a>' +
                                '<a href="javascript:;" class="editData" style="margin: 0 10px;">编辑</a>' +
                                '</td>' +
                                '</tr>'
                        }
                    }else{
                        str='<tr><td colspan="5"><img src="/img/main_img/shouyekong.png" alt=""><p>暂无数据</p></td></tr>'
                    }
                    $('#divTable').html(str_s+str);
                    me.pageTwo(res.totleNum,me.data.pageSize,me.data.page);
                }
            });

        },
        pageTwo:function (totalData, pageSize,indexs) {
            var mes=this;
            $('#dbgz_pagesd').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                homePage:'',
                endPage: '',
                current:indexs||1,
                callback: function (index) {
                    mes.data.page=index.getCurrent();
                    mes.page();
                }
            });
        }
    }
    ajaxPage.page();
}
//复职信息
function fuzhiData() {
    var ajaxPage={
        data:{
            page:1,//当前处于第几页
            pageSize:5,//一页显示几条
            useFlag:true,
            staffName:stafid
        },
        page:function () {
            var me=this;
            $.ajax({
                type:'get',
                url:'/hr/api/getReins',
                dataType:'json',
                data:me.data,
                success:function(res){
                    var str='';
                    var datas=res.obj;
                    var str_s='<tr><th>复职人员</th><th>复职类型</th><th>拟复职日期</th><th>工资恢复日期</th><th>操作</th></tr>';
                    if(datas.length > 0){
                        for(var i=0;i<datas.length;i++){
                            str+='<tr data-id="'+datas[i].reinstatementId+'">' +
                                '<td>'+dataundefined(datas[i].reinstatementPerson)+'</td>' +
                                '<td>'+dataundefined(datas[i].reappointmentType)+'</td>' +
                                '<td>'+dataundefined((datas[i].reappointmentTimePlan))+'</td>' +
                                '<td>'+dataundefined(datas[i].firstSalaryTime)+'</td>' +
                                '<td>' +
                                '<a href="javascript:;" class="detailsData">查看详情</a>' +
                                '<a href="javascript:;" class="editData" style="margin: 0 10px;">编辑</a>' +
                                '</td>' +
                                '</tr>'
                        }
                    }else{
                        str='<tr><td colspan="5"><img src="/img/main_img/shouyekong.png" alt=""><p>暂无数据</p></td></tr>'
                    }
                    $('#divTable').html(str_s+str);
                    me.pageTwo(res.totleNum,me.data.pageSize,me.data.page);
                }
            });

        },
        pageTwo:function (totalData, pageSize,indexs) {
            var mes=this;
            $('#dbgz_pagesd').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                homePage:'',
                endPage: '',
                current:indexs||1,
                callback: function (index) {
                    mes.data.page=index.getCurrent();
                    mes.page();
                }
            });
        }
    }
    ajaxPage.page();
}
//职称评定
function zhichengData() {
    var ajaxPage={
        data:{
            page:1,//当前处于第几页
            pageSize:5,//一页显示几条
            useFlag:true,
            staffName:stafid
        },
        page:function () {
            var me=this;
            $.ajax({
                type:'get',
                url:'/hr/api/getEval',
                dataType:'json',
                data:me.data,
                success:function(res){
                    var str='';
                    var datas=res.obj;
                    var str_s='<tr><th>评定对象</th><th>批准人</th><th>获取职称</th><th>获取方式</th><th>获取时间</th><th>操作</th></tr>';
                    if(datas.length > 0){
                        for(var i=0;i<datas.length;i++){
                            str+='<tr data-id="'+datas[i].evaluationId+'">' +
                                '<td>'+dataundefined(datas[i].byEvaluStaffs)+'</td>' +
                                '<td>'+dataundefined(datas[i].approvePerson)+'</td>' +
                                '<td>'+dataundefined((datas[i].postName))+'</td>' +
                                '<td>'+dataundefined(datas[i].getMethod)+'</td>' +
                                '<td>'+dataundefined(datas[i].receiveTime)+'</td>' +
                                '<td>' +
                                '<a href="javascript:;" class="detailsData">查看详情</a>' +
                                '<a href="javascript:;" class="editData" style="margin: 0 10px;">编辑</a>' +
                                '</td>' +
                                '</tr>'
                        }
                    }else{
                        str='<tr><td colspan="6"><img src="/img/main_img/shouyekong.png" alt=""><p>暂无数据</p></td></tr>'
                    }
                    $('#divTable').html(str_s+str);
                    me.pageTwo(res.totleNum,me.data.pageSize,me.data.page);
                }
            });

        },
        pageTwo:function (totalData, pageSize,indexs) {
            var mes=this;
            $('#dbgz_pagesd').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                homePage:'',
                endPage: '',
                current:indexs||1,
                callback: function (index) {
                    mes.data.page=index.getCurrent();
                    mes.page();
                }
            });
        }
    }
    ajaxPage.page();
}
//员工关怀
function guanhuaiData() {
    var ajaxPage={
        data:{
            page:1,//当前处于第几页
            pageSize:5,//一页显示几条
            useFlag:true,
            staffName:stafid
        },
        page:function () {
            var me=this;
            $.ajax({
                type:'get',
                url:'/hr/api/getCare',
                dataType:'json',
                data:me.data,
                success:function(res){
                    var str='';
                    var datas=res.obj;
                    var str_s='<tr><th>关怀类型</th><th>被关怀员工</th><th>关怀开支费用</th><th>参与人</th><th>关怀日期</th><th>操作</th></tr>';
                    if(datas.length > 0){
                        for(var i=0;i<datas.length;i++){
                            str+='<tr data-id="'+datas[i].careId+'">' +
                                '<td>'+dataundefined(datas[i].careTypeName)+'</td>' +
                                '<td>'+dataundefined(datas[i].byCareStaffs)+'</td>' +
                                '<td>'+dataundefined((datas[i].careFees))+'</td>' +
                                '<td>'+dataundefined(datas[i].participants)+'</td>' +
                                '<td>'+dataundefined(datas[i].careDate)+'</td>' +
                                '<td>' +
                                '<a href="javascript:;" class="detailsData">查看详情</a>' +
                                '<a href="javascript:;" class="editData" style="margin: 0 10px;">编辑</a>' +
                                '</td>' +
                                '</tr>'
                        }
                    }else{
                        str='<tr><td colspan="6"><img src="/img/main_img/shouyekong.png" alt=""><p>暂无数据</p></td></tr>'
                    }
                    $('#divTable').html(str_s+str);
                    me.pageTwo(res.totleNum,me.data.pageSize,me.data.page);
                }
            });

        },
        pageTwo:function (totalData, pageSize,indexs) {
            var mes=this;
            $('#dbgz_pagesd').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                homePage:'',
                endPage: '',
                current:indexs||1,
                callback: function (index) {
                    mes.data.page=index.getCurrent();
                    mes.page();
                }
            });
        }
    }
    ajaxPage.page();
}
//员工培训
function peixunData() {
    var ajaxPage={
        data:{
            page:1,//当前处于第几页
            pageSize:5,//一页显示几条
            useFlag:true,
            staffName:stafid
        },
        page:function () {
            var me=this;
            $.ajax({
                type:'get',
                url:'/hr/api/getRecord',
                dataType:'json',
                data:me.data,
                success:function(res){
                    var str='';
                    var datas=res.obj;
                    var str_s='<tr><th>培训计划名称</th><th>受训人</th><th>培训费用</th><th>培训机构</th><th>操作</th></tr>';
                    if(datas.length > 0){
                        for(var i=0;i<datas.length;i++){
                            str+='<tr data-id="'+datas[i].recordId+'">' +
                                '<td>'+dataundefined(datas[i].tPlanName)+'</td>' +
                                '<td>'+dataundefined(datas[i].staffUserId)+'</td>' +
                                '<td>'+dataundefined((datas[i].trainningCost))+'</td>' +
                                '<td>'+dataundefined(datas[i].tInstitutionName)+'</td>' +
                                '<td>' +
                                '<a href="javascript:;" class="detailsData">查看详情</a>' +
                                '<a href="javascript:;" class="editData" style="margin: 0 10px;">编辑</a>' +
                                '</td>' +
                                '</tr>'
                        }
                    }else{
                        str='<tr><td colspan="5"><img src="/img/main_img/shouyekong.png" alt=""><p>暂无数据</p></td></tr>'
                    }
                    $('#divTable').html(str_s+str);
                    me.pageTwo(res.totleNum,me.data.pageSize,me.data.page);
                }
            });

        },
        pageTwo:function (totalData, pageSize,indexs) {
            var mes=this;
            $('#dbgz_pagesd').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                homePage:'',
                endPage: '',
                current:indexs||1,
                callback: function (index) {
                    mes.data.page=index.getCurrent();
                    mes.page();
                }
            });
        }
    }
    ajaxPage.page();
}
//获取url参数
function getQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return r[2];
    return '';
}
//undefined 判断
function dataundefined(data) {
    if(data == undefined){
        return '';
    }else {
        return data;
    }
}