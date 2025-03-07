/**
 * Created by 骆鹏 on 2017/7/25.
 */
var urlsObj=null;
function formatDate(now) {
    var year=now.getYear();
    var month=now.getMonth()+1;
    var date=now.getDate();
    var hour=now.getHours();
    var minute=now.getMinutes();
    var second=now.getSeconds();
    return "20"+year+"-"+month+"-"+date+" "+hour+":"+minute+":"+second;
}

$(function () {
    urlsObj=$.GetRequest();


    $.post('/hr/api/selectStaffInfoById',{staffId:urlsObj.staffId},function(json){
        if(json.flag){
            var arr=json.object;
            var str=' <table border="0" width="100%" cellspacing="0" cellpadding="3" class="small">\
                            <tbody>\
                                <tr>\
                                    <td class="Big">\
                                        <img src="/static/images/menu/hr_manage.gif" width="17" height="17">\
                                    <span class="big3"> '+vote_th_Details+'（'+Filing_time+'：'+function () {
                    return arr.addTime.substring(arr.addTime,arr.addTime.length-2)
                }()+' "'+netdisk_th_Lastmodifiedtime+'"：'+function () {
                    return arr.lastUpdateTime.substring(0,arr.lastUpdateTime.length-2)
                }()+'</span>\
                                    <br>\
                                    </td>\
                                </tr>\
                             </tbody>\
                     </table>\
                      <table class="TableBlock" width="80%" align="center">\
                <tbody>\
                <tr>\
                <td nowrap="" class="TableHeader" colspan="6"><b>&nbsp;'+url_th_EssentialInformation+'</b></td>\
            </tr>\
            <tr>\
            <td nowrap="" align="left" class="TableContent">OA'+global_lang_user+'：</td>\
            <td class="TableData" colspan="4">'+arr.userId+'</td>\
                <td class="TableData" align="center" rowspan="6" colspan="2">\
                <div class="avatar"><a href="javascript:void(0)">' +
            '<img src="../../img/hr/'+arr.photoName+'" width="130">' +
            '</a></div>\
                </td>\
                </tr>\
                <tr>\
                <td nowrap="" align="left" class="TableContent">'+userManagement_th_department+'：</td>\
            <td nowrap="" align="left" class="TableData">'+arr.deptName+'</td>\
                <td nowrap="" align="left" class="TableContent">'+userManagement_th_role+'：</td>\
            <td class="TableData" colspan="2">'+arr.userPrivName+'</td>\
                </tr>\
                <tr>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_number+'：</td>\
            <td nowrap="" align="left" class="TableData" width="180">'+arr.staffNo+'</td>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_JobNumber+'：</td>\
            <td class="TableData" colspan="2">'+arr.workNo+'</td>\
                </tr>\
                <tr>\
                <td nowrap="" align="left" class="TableContent">'+userDetails_th_name+'：</td>\
            <td class="TableData" width="180">'+arr.staffName+'</td>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_NameUsedBefore+'：</td>\
            <td class="TableData" colspan="2">'+arr.beforeName+'</td>\
                </tr>\
                <tr>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_EnglishName+'：</td>\
            <td class="TableData">'+arr.staffEName+'</td>\
                <td nowrap="" align="left" class="TableContent">'+userDetails_th_Gender+'：</td>\
            <td class="TableData" colspan="2">'+function () {
                   if(arr.staffSex==1){
                       return userInfor_th_female
                   }else {
                       return userInfor_th_male
                   }
                }()+'</td>\
                </tr>\
                <tr>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_IDNumber+'：</td>\
            <td class="TableData">'+arr.staffCardNo+'</td>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_DateOfBirth+'：</td>\
            <td class="TableData" colspan="2">'+function () {
                    if(arr.staffBirth==undefined || arr.staffBirth=='0000-00-00'){
                        return ''
                    }
                    return arr.staffBirth;
                }()+' </td>\
                </tr>\
                <tr>\
                <td nowrap="" align="left" class="TableContent">'+url_th_Zodiac+'</td>\
                <td class="TableData">狗</td>\
                <td nowrap="" align="left" class="TableContent">'+url_th_constellation+'</td>\
                <td class="TableData">天蝎座</td>\
                <td nowrap="" align="left" class="TableContent">'+url_th_BloodType+'</td>\
                <td class="TableData">AB </td>\
                </tr>\
                <tr>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_Age+'：</td>\
            <td class="TableData" width="180">'+arr.staffAge+'</td>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_annualLeave+':</td>\
            <td class="TableData" colspan="3">'+function () {
                    if(arr.leaveType==undefined){
                        return ''
                    }else {
                        return arr.leaveType
                    }
                }()+ '</td>\
                </tr>\
                <tr>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_PlaceOfOrigin+'：</td>\
            <td class="TableData">'+arr.staffNativePlace2+'</td>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_Nation+'：</td>\
            <td class="TableData" colspan="3">'+arr.staffNationality+'</td>\
                </tr>\
                <tr>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_MaritalStatus+'：</td>\
            <td class="TableData" width="180">'+function () {
                   if(arr.staffMaritalStatus==1){
                       return hr_th_married
                   } else if(arr.staffMaritalStatus==0){
                       return hr_th_unmarried
                   }else if(arr.staffMaritalStatus==2){
                       return hr_th_Divorce
                   }else if(arr.staffMaritalStatus==0){
                       return hr_th_Widowed
                   }
                }()+' </td>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_Health+'：</td>\
            <td class="TableData" colspan="3">'+arr.staffHealth+'</td>\
                </tr><tr>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_PoliticalOutlook+'：</td>\
            <td class="TableData" width="180">'+function () {
                    if(arr.staffPoliticalStatus==0){
                        return ''
                    }else if(arr.staffPoliticalStatus==1){
                        return hr_th_TheMasses
                    }else if(arr.staffPoliticalStatus==2){
                        return hr_th_Communist
                    }else if(arr.staffPoliticalStatus==3){
                        return hr_th_CPCMembers
                    }else if(arr.staffPoliticalStatus==4){
                        return hr_th_CPCProbationaryParty
                    }else if(arr.staffPoliticalStatus==5){
                        return hr_th_DemocraticParties
                    }else if(arr.staffPoliticalStatus==4){
                        return hr_th_PersonagesWithoutParty
                    }
                }()+'</td>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_PartyMembershipTime+'：</td>\
            <td class="TableData" colspan="3">'+function(){
                        if(arr.joinPartyTime==undefined){
                            return ''
                        }else {
                            return arr.joinPartyTime
                        }
                }()+'</td>\
                </tr>\
                <tr>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_Household+'：</td>\
            <td class="TableData" width="180">'+function () {
                        if(arr.staffType==0){
                            return ''
                        }else if(arr.staffType==1){
                            return hr_th_UrbanMunicipality
                        }else if(arr.staffType==2){
                            return hr_th_WorkersTowns
                        }else if(arr.staffType==3){
                            return hr_th_MigrantCity
                        }else if(arr.staffType==4){
                            return hr_th_MigrantWorkers
                        }else if(arr.staffType==5){
                            return hr_th_RuralLabor
                        }else if(arr.staffType==6){
                            return hr_th_OutOfTown
                        }

                }()+'</td>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_RegisteredResidence+':</td>\
            <td class="TableData" colspan="3">'+arr.staffDomicilePlace+'</td>\
                </tr>\
                <tr>\
                <td nowrap="" class="TableHeader" colspan="6"><b>&nbsp;'+hr_th_Position+'：</b></td>\
            </tr>\
            <tr>\
            <td nowrap="" align="left" class="TableContent">'+hr_th_TypeWork+'：</td>\
            <td class="TableData" width="180">'+arr.workType+'</td>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_AdministrativeLevel+'：</td>\
            <td class="TableData" width="180">'+arr.administrationLevel+'</td>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_EmployeeType+':</td>\
            <td class="TableData">'+arr.staffOccupation+' </td>\
                </tr>\
                <tr>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_TitleLevel+'：</td>\
            <td class="TableData" width="180">'+function(){
                            if(arr.workLevel==undefined){
                                return ''
                            }else {
                                return arr.workLevel
                            }
                }()+'</td>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_post+'：</td>\
            <td class="TableData" width="180">'+arr.workJob+'</td>\
                <td nowrap="" align="left" class="TableContent">'+user_th_AttendanceType+'：</td>\
            <td class="TableData" width="180">'+hr_th_RegularClass+'</td>\
                </tr>\
                <tr>\
                <td nowrap="" align="left" class="TableContent">'+userDetails_th_post+'：</td>\
            <td class="TableData" width="180">'+arr.jobPosition+'</td>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_Title+'：</td>\
            <td class="TableData" width="180">'+function(){
                                if(arr.presentPosition==undefined){
                                    return ''
                                }else if(arr.presentPosition==''){
                                    return ''
                                }else if(arr.presentPosition=='01'){
                                    return hr_th_Engineer
                                }else if(arr.presentPosition=='02'){
                                    return hr_th_AssistantEngineer
                                }else if(arr.presentPosition=='03'){
                                    return hr_th_SeniorEngineer
                                }else if(arr.presentPosition=='04'){
                                    return hr_th_Senior
                                }else if(arr.presentPosition=='07'){
                                    return hr_th_Title
                                }else if(arr.presentPosition=='08'){
                                    return hr_th_SeniorTitles
                                }
                }()+'</td>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_InductionTime+'：</td>\
            <td class="TableData" width="180">'+function () {
                                if(arr.datesEmployed==undefined || arr.datesEmployed=='0000-00-00'){
                                    return ''
                                }
                    /*return formatDate(new Date(arr.datesEmployed))*/
                    return arr.datesEmployed
                }()+'</td>\
                </tr>\
                <tr>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_LengthUnit+':</td>\
            <td class="TableData" width="180">'+arr.jobAge+'</td>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_StartingSalary+':</td>\
            <td class="TableData" width="180">'+function () {
                                    if(arr.beginSalsryTime==undefined || arr.beginSalsryTime=='0000-00-00'){
                                        return ''
                                    }
                    return arr.beginSalsryTime
                }()+'</td>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_Incumbency+':</td>\
            <td class="TableData" width="180">'+arr.workStatus+'</td>\
                </tr>\
                <tr>\
                <td nowrap="" align="left" class="TableContent">'+hra_th_TotalLengthOfService+'：</td>\
            <td class="TableData" width="180">'+arr.workAge+'</td>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_WorkingHours+'：</td>\
            <td class="TableData" width="180">'+function () {
                                        if(arr.jobBeginning==undefined  || arr.jobBeginning=='0000-00-00'){
                                            return ''
                                        }
                    return arr.jobBeginning
                }()+'</td>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_ContactNumber+'：</td>\
            <td class="TableData" width="180">'+arr.staffPhone+'</td>\
                </tr>\
                <tr>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_PhoneNumber+'：</td>\
            <td class="TableData">'+arr.staffMobile+'</td>\
                <!--<td nowrap align="left" class="TableContent">'+hr_th_smalltong+'：</td>\
            <td class="TableData"  width="180"></td>-->\
                <td nowrap="" align="left" class="TableContent">MSN：</td>\
            <td class="TableData" colspan="3">'+arr.staffMsn+'</td>\
                </tr>\
                <tr>\
                <td nowrap="" align="left" class="TableContent">'+main_email+'：</td>\
            <td class="TableData" width="180">'+arr.staffEmail +'</td>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_HomeAddress+'：</td>\
            <td class="TableData" colspan="3">'+arr.homeAddress+'</td>\
                </tr>\
                <tr>\
                <td nowrap="" align="left" class="TableContent">QQ：</td>\
            <td class="TableData" width="180">'+arr.staffQq+'</td>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_OtherInformation+'：</td>\
            <td class="TableData" colspan="3">'+arr.otherContact+'</td>\
                </tr>\
                <tr>\
                <td nowrap="" align="left" class="TableContent">'+depatement_th_Openingbank+'1：</td>\
            <td class="TableData" width="180">'+arr.bank1+'</td>\
                <td nowrap="" align="left" class="TableContent">'+depatement_th_Accountnumber+'1：</td>\
            <td class="TableData" colspan="3">'+arr.bankAccount1+'</td>\
                </tr>\
                <tr>\
                <td nowrap="" align="left" class="TableContent">'+depatement_th_Openingbank+'2：</td>\
            <td class="TableData" width="180">'+arr.bank2+'</td>\
                <td nowrap="" align="left" class="TableContent">'+depatement_th_Accountnumber+'2：</td>\
            <td class="TableData" colspan="3">'+arr.bankAccount2+'</td>\
                </tr>\
                <tr>\
                <td nowrap="" class="TableHeader" colspan="6"><b>&nbsp;'+hr_th_educationalBackground+'：</b></td>\
            </tr>\
            <tr>\
            <td nowrap="" align="left" class="TableContent">'+hr_th_Education+'：</td>\
            <td class="TableData" width="180">'+function () {
                    if(arr.staffHighestSchool==''){
                        return ''
                    }else if(arr.staffHighestSchool=='1'){
                        return vote_hr_1
                    }else if(arr.staffHighestSchool=='2'){
                        return vote_hr_2
                    }else if(arr.staffHighestSchool=='3'){
                        return vote_hr_3
                    }else if(arr.staffHighestSchool=='4'){
                        return vote_hr_4
                    }else if(arr.staffHighestSchool=='5'){
                        return vote_hr_5
                    }else if(arr.staffHighestSchool=='6'){
                        return vote_hr_6
                    } else if(arr.staffHighestSchool=='7'){
                        return vote_hr_7
                    }else if(arr.staffHighestSchool=='8'){
                        return vote_hr_8
                    }else if(arr.staffHighestSchool=='9'){
                        return vote_hr_9
                    }else if(arr.staffHighestSchool=='11'){
                        return vote_hr_10
                    }
                }()+ '</td>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_AcademicDegree+'：</td>\
            <td class="TableData" width="180">'+function () {
                    if(arr.staffHighestDegree==''){
                        return ''
                    }else if(arr.staffHighestDegree=='1'){
                        return vote_hr_9
                    }else if(arr.staffHighestDegree=='2'){
                        return vote_hr_8
                    }else if(arr.staffHighestDegree=='3'){
                        return 'MBA'
                    }else if(arr.staffHighestDegree=='4'){
                        return vote_hr_13
                    }else if(arr.staffHighestDegree=='5'){
                        return vote_hr_12
                    }else if(arr.staffHighestDegree=='6'){
                        return vote_hr_11
                    } else if(arr.staffHighestDegree=='7'){
                        return event_th_nothing
                    }
                }()+ '</td>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_GraduationTime+'：</td>\
            <td class="TableData" width="180">'+function () {
                                            if(arr.graduationDate==undefined  || arr.graduationDate=='0000-00-00'){
                                                return ''
                                            }
                    return arr.graduationDate
                }()+'</td>\
                </tr>\
                <tr>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_GraduationSchool+'：</td>\
            <td class="TableData" width="180">'+arr.graduationSchool+'</td>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_major+'：</td>\
            <td class="TableData" width="180">'+arr.staffMajor+'</td>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_ComputerLevel+'：</td>\
            <td class="TableData" width="180">'+arr.computerLevel+'</td>\
                </tr>\
                <tr>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_ForeignLanguage+'1：</td>\
            <td class="TableData" width="180">'+arr.foreignLanguage1+'</td>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_ForeignLanguage+'2：</td>\
            <td class="TableData" width="180">'+arr.foreignLanguage2+'</td>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_ForeignLanguage+'3：</td>\
            <td class="TableData" width="180">'+arr.foreignLanguage3+'</td>\
                </tr>\
                <tr>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_ForeignLanguageProficiency+'1：</td>\
            <td class="TableData" width="180">'+arr.foreignLevel1+'</td>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_ForeignLanguageProficiency+'2：</td>\
            <td class="TableData" width="180">'+arr.foreignLevel2+'</td>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_ForeignLanguageProficiency+'3：</td>\
            <td class="TableData" width="180">'+arr.foreignLevel3+'</td>\
                </tr>\
                <tr>\
                <td nowrap="" align="left" class="TableContent">'+hr_th_Specialty+'：</td>\
            <td class="TableData" colspan="5">'+arr.staffSkills+'</td>\
                </tr>\
                <tr>\
                <td nowrap="" align="left" colspan="3" class="TableHeader">'+hr_th_JobStatus+'：</td>\
            <td nowrap="" align="left" colspan="3" class="TableHeader">'+HR_TH_WarrantyRecord+'：</td>\
            </tr>\
            <tr>\
            <td class="TableData" colspan="3" style="vertical-align:top;">'+arr.certificate+'</td>\
                <td class="TableData" colspan="3" style="vertical-align:top;">'+arr.surety+'</td>\
                </tr>\
                <tr>\
                <td nowrap="" class="TableHeader" colspan="3"><b>&nbsp;'+HR_TH_SocialPayment+'：</b></td>\
            <td nowrap="" class="TableHeader" colspan="3"><b>&nbsp;'+HR_TH_PhysicalRecord+'：</b></td>\
            </tr>\
            <tr>\
            <td class="TableData" colspan="3" style="vertical-align:top;">'+arr.insure+'</td>\
                <td class="TableData" colspan="3" style="vertical-align:top;">'+arr.bodyExamim+'</td>\
                </tr>\
                <tr>\
                <td colspan="6">\
                <table width="100%" class="TableBlock">\
                <tbody><tr>\
                <td class="TableHeader" colspan="2">'+main_customset+'：'+arr.userdef1+'</td>\
            </tr>\
            </tbody></table>\
            </td>\
            </tr>\
            <tr>\
            <td nowrap="" align="left" colspan="6" class="TableHeader">'+journal_th_Remarks+'：</td>\
            </tr>\
            <tr>\
            <td nowrap="" class="TableData" colspan="6">'+arr.remark+'</td>\
                </tr>\
                <tr>\
                <td nowrap="" class="TableHeader" colspan="6">'+depatement_th_Attachmentdocument+'：</td>\
            </tr>\
            <tr>\
            <td nowrap="" align="left" class="TableData" colspan="6">\
                '+hr_th_NoAttachments+'    </td>\
                </tr>\
                <tr>\
                <td nowrap="" align="left" class="TableHeader" colspan="6">'+HR_TH_resume+':</td>\
            </tr>\
            <tr>\
            <td nowrap="" class="TableData" colspan="6" style="vertical-align:top;">'+arr.resume+'</td>\
                </tr>\
                <tr align="center" class="TableControl">\
                <td colspan="6">\
                <input type="button" value="'+global_lang_close+'" class="BigButton" onclick="window.close();" title="'+global_long_closeWin+'">\
                </td>\
                </tr>\
                </tbody>\
                </table>'
            $('body').html(str)

        }
    },'json')

})

