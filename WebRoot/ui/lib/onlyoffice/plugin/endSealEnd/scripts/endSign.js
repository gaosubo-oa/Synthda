/**
 *
 * (c) Copyright Ascensio System SIA 2020
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

// Example insert text into editors (different implementations)
(function(window, undefined){
	
    window.Asc.plugin.init = function()
    {
				debugger;
				console.log('父页面地址：'+parent.window.location.search.split('&parentOrigin=')[1])
				var parentUrl = parent.window.location.search.split('&parentOrigin=')[1];
			
				var signId = parent.window.g_asc_plugins.api.signId;
				if(!signId){
					alert('您未在文档签章，签章日志记录失败！')
					return
				}
				var callbackUrl = parent.window.g_asc_plugins.api.vIc;
				// var callbackUrl = parent.window.g_asc_plugins.api.fTc;
				var AID = callbackUrl.split('&AID=')[1].split('&')[0];
				console.log(callbackUrl.split('&uid=')[1])
				var uid = callbackUrl.split('&uid=')[1].split('&')[0];
				var runId = '', prcsId = '', flowPrcs = '';
				if(callbackUrl.indexOf('&runId=') > -1){
					runId = callbackUrl.split('&runId=')[1].split('&')[0];
					prcsId = callbackUrl.split('&prcsId=')[1].split('&')[0];
					flowPrcs = callbackUrl.split('&flowPrcs=')[1].split('&')[0];
				}
			
				$.ajax({
						type: 'get',
						url: parentUrl + '/xsign/saveOnlyOfficeSignLog',
						dataType: 'jsonp',
						data:{
								aid: AID,
								signId: signId,
								uid: uid,
								runId: runId,
								prcsId: prcsId,
								flowPrcs: flowPrcs
						},
						success: function (res) {
								if(res.flag){	
										alert('签章日志记录成功！')
										parent.window.AscDesktopEditor_Save();
								}else{
										alert('签章日志记录失败！')
								}

						}
				}); 

    };

})(window, undefined);
