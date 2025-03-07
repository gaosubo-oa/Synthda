document.addEventListener("plusready", function() {
	var _BARCODE = 'SimbaPlugin',
	B = window.plus.bridge;

	var SimbaPlugin = {
                          
        quitApp : function () {
            if ('iOS' == plus.os.name) {
                plus.SimbaPlugin.quitAppFunction("", function(result) {}, function(result) {});
            } else {
                plus.runtime.quit();
            }
        },

        quitAppFunction : function (Argus, successCallback, errorCallback) {
            var success = typeof successCallback !== 'function' ? null : function(args) {
                    successCallback(args);
                },
                fail = typeof errorCallback !== 'function' ? null : function(code) {
                    errorCallback(code);
                };
            callbackID = B.callbackId(success, fail);
            return B.exec(_BARCODE, "quitAppFunction", [callbackID, Argus]);
        },

		//选择联系人
		chooseUsers: function(Argus,successCallback, errorCallback) {
			var success = typeof successCallback !== 'function' ? null : function(args) {
					successCallback(args);
				},
				fail = typeof errorCallback !== 'function' ? null : function(code) {
					errorCallback(code);
				};
			callbackID = B.callbackId(success, fail);
			return B.exec(_BARCODE, "chooseUsers", [callbackID,Argus]);
		},
		
		
		//获取token
		getToken : function (Argus, successCallback, errorCallback) {
				var success = typeof successCallback !== 'function' ? null : function(args) {
						successCallback(args);
					},
					fail = typeof errorCallback !== 'function' ? null : function(code) {
						errorCallback(code);
					};
				callbackID = B.callbackId(success, fail);
				return B.exec(_BARCODE, "getToken", [callbackID, Argus]);
		},
		
		//获取当前客户端版本号
		getAppVersion : function (Argus, successCallback, errorCallback) {
				var success = typeof successCallback !== 'function' ? null : function(args) {
						successCallback(args);
					},
					fail = typeof errorCallback !== 'function' ? null : function(code) {
						errorCallback(code);
					};
				callbackID = B.callbackId(success, fail);
				return B.exec(_BARCODE, "getAppVersion", [callbackID, Argus]);
		},
		
		//获取用户的信息
		getUserInfo : function (Argus, successCallback, errorCallback) {
				var success = typeof successCallback !== 'function' ? null : function(args) {
						successCallback(args);
					},
					fail = typeof errorCallback !== 'function' ? null : function(code) {
						errorCallback(code);
					};
				callbackID = B.callbackId(success, fail);
				return B.exec(_BARCODE, "getUserInfo", [callbackID, Argus]);
		},
		
		//添加好友
		addFriend : function (Argus, successCallback, errorCallback) {
				var success = typeof successCallback !== 'function' ? null : function(args) {
						successCallback(args);
					},
					fail = typeof errorCallback !== 'function' ? null : function(code) {
						errorCallback(code);
					};
				callbackID = B.callbackId(success, fail);
				return B.exec(_BARCODE, "addFriend", [callbackID, Argus]);
		},
		
		//视频呼叫
		callVideo: function(Argus, successCallback, errorCallback) {
			var success = typeof successCallback !== 'function' ? null : function(args) {
					successCallback(args);
				},
				fail = typeof errorCallback !== 'function' ? null : function(code) {
					errorCallback(code);
				};
			callbackID = B.callbackId(success, fail);
			return B.exec(_BARCODE, "callVideo", [callbackID, Argus]);
		},
		
		//添加群组
		addTribe : function (Argus, successCallback, errorCallback) {
				var success = typeof successCallback !== 'function' ? null : function(args) {
						successCallback(args);
					},
					fail = typeof errorCallback !== 'function' ? null : function(code) {
						errorCallback(code);
					};
				callbackID = B.callbackId(success, fail);
				return B.exec(_BARCODE, "addTribe", [callbackID, Argus]);
		},
		
		//创建讨论组
		createDiscussion : function (Argus, successCallback, errorCallback) {
				var success = typeof successCallback !== 'function' ? null : function(args) {
						successCallback(args);
					},
					fail = typeof errorCallback !== 'function' ? null : function(code) {
						errorCallback(code);
					};
				callbackID = B.callbackId(success, fail);
				return B.exec(_BARCODE, "createDiscussion", [callbackID, Argus]);
		},
		
		//语音呼叫					
		callNumber: function(Argus, successCallback, errorCallback) {
			var success = typeof successCallback !== 'function' ? null : function(args) {
					successCallback(args);
				},
				fail = typeof errorCallback !== 'function' ? null : function(code) {
					errorCallback(code);
				};
			callbackID = B.callbackId(success, fail);
			return B.exec(_BARCODE, "callNumber", [callbackID, Argus]);
		},

		//拨号界面
		showTelePhone: function(Argus, successCallback, errorCallback) {
			var success = typeof successCallback !== 'function' ? null : function(args) {
					successCallback(args);
				},
				fail = typeof errorCallback !== 'function' ? null : function(code) {
					errorCallback(code);
				};
			callbackID = B.callbackId(success, fail);
			return B.exec(_BARCODE, "showTelePhone", [callbackID, Argus]);
		},
		
		//打开聊天界面							
		openChatByUser: function(Argus, successCallback, errorCallback) {
			var success = typeof successCallback !== 'function' ? null : function(args) {
					successCallback(args);
				},
				fail = typeof errorCallback !== 'function' ? null : function(code) {
					errorCallback(code);
				};
			callbackID = B.callbackId(success, fail);
			return B.exec(_BARCODE, "openChatByUser", [callbackID, Argus]);
		},					
		
		//打开电话会议
		openTeleconference: function(Argus, successCallback, errorCallback) {
			var success = typeof successCallback !== 'function' ? null : function(args) {
					successCallback(args);
				},
				fail = typeof errorCallback !== 'function' ? null : function(code) {
					errorCallback(code);
				};
			callbackID = B.callbackId(success, fail);
			return B.exec(_BARCODE, "openTeleconference", [callbackID, Argus]);
		},
		
		//跳转用户资料界面
		showUserInfo: function(Argus, successCallback, errorCallback) {
			var success = typeof successCallback !== 'function' ? null : function(args) {
					successCallback(args);
				},
				fail = typeof errorCallback !== 'function' ? null : function(code) {
					errorCallback(code);
				};
			callbackID = B.callbackId(success, fail);
			return B.exec(_BARCODE, "showUserInfo", [callbackID, Argus]);
		},		
			
		//获取网络状态
		getNetworkType: function(Argus, successCallback, errorCallback) {
			var success = typeof successCallback !== 'function' ? null : function(args) {
					successCallback(args);
				},
				fail = typeof errorCallback !== 'function' ? null : function(code) {
					errorCallback(code);
				};
			callbackID = B.callbackId(success, fail);
			return B.exec(_BARCODE, "getNetworkType", [callbackID, Argus]);
		},

		//打开我的文件
		showMyFiles: function(Argus, successCallback, errorCallback) {
			var success = typeof successCallback !== 'function' ? null : function(args) {
					successCallback(args);
				},
				fail = typeof errorCallback !== 'function' ? null : function(code) {
					errorCallback(code);
				};
			callbackID = B.callbackId(success, fail);
			return B.exec(_BARCODE, "showMyFiles", [callbackID, Argus]);
		},
		
		//打开电话会议记录
		showTeleconferenceRecord: function(Argus, successCallback, errorCallback) {
			var success = typeof successCallback !== 'function' ? null : function(args) {
					successCallback(args);
				},
				fail = typeof errorCallback !== 'function' ? null : function(code) {
					errorCallback(code);
				};
			callbackID = B.callbackId(success, fail);
			return B.exec(_BARCODE, "showTeleconferenceRecord", [callbackID, Argus]);
		},
		
		//下载企业组织架构
		downloadEntInfo: function(Argus, successCallback, errorCallback) {
			var success = typeof successCallback !== 'function' ? null : function(args) {
					successCallback(args);
				},
				fail = typeof errorCallback !== 'function' ? null : function(code) {
					errorCallback(code);
				};
			callbackID = B.callbackId(success, fail);
			return B.exec(_BARCODE, "downloadEntInfo", [callbackID, Argus]);
		},
		
		//获取群列表
		getMyTribeList: function(Argus, successCallback, errorCallback) {
			var success = typeof successCallback !== 'function' ? null : function(args) {
					successCallback(args);
				},
				fail = typeof errorCallback !== 'function' ? null : function(code) {
					errorCallback(code);
				};
			callbackID = B.callbackId(success, fail);
			return B.exec(_BARCODE, "getMyTribeList", [callbackID, Argus]);
		},
		
		//获取群成员列表
		getTribeMemberList: function(Argus, successCallback, errorCallback) {
			var success = typeof successCallback !== 'function' ? null : function(args) {
					successCallback(args);
				},
				fail = typeof errorCallback !== 'function' ? null : function(code) {
					errorCallback(code);
				};
			callbackID = B.callbackId(success, fail);
			return B.exec(_BARCODE, "getTribeMemberList", [callbackID, Argus]);
		},

		//添加日历提醒事件
		calendarEvent : function (Argus, successCallback, errorCallback) {
				var success = typeof successCallback !== 'function' ? null : function(args) {
						successCallback(args);
					},
					fail = typeof errorCallback !== 'function' ? null : function(code) {
						errorCallback(code);
					};
				callbackID = B.callbackId(success, fail);
				return B.exec(_BARCODE, "calendarEvent", [callbackID, Argus]);
		},
		
		//跳转到直播界面
		openLiveVideo : function (Argus, successCallback, errorCallback) {
				var success = typeof successCallback !== 'function' ? null : function(args) {
						successCallback(args);
					},
					fail = typeof errorCallback !== 'function' ? null : function(code) {
						errorCallback(code);
					};
				callbackID = B.callbackId(success, fail);
				return B.exec(_BARCODE, "openLiveVideo", [callbackID, Argus]);
			}
		};
	window.plus.SimbaPlugin = SimbaPlugin;
}, true);