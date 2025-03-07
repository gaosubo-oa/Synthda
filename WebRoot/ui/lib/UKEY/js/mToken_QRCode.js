
	/////////////////////////////////////////
	//按指定模板生成JSON
	function Template_Cert(appid, certSN, UKeySN, Random, validTime, certoid, sessionid, tokenid)
	{
		var json = " {";
		json += " \"appid\": \"" + appid +"\", ";
		json += " \"ukeysn\": \"" + UKeySN +"\", ";
		json += " \"certsn\": \"" + certSN +"\", ";
		json += " \"random\": \"" + Random +"\", ";
		json += " \"certdateto\": \"" + validTime +"\", ";
		json += " \"certoid\": \"" + certoid +"\", ";
		json += " \"extdatas\": {";
		json += " \"sessionid\": \"" + sessionid +"\", ";
		json += " \"token\": \"" + tokenid +"\" ";
		json += " } ";
		json += " } ";
		return json;
	}
	//生成二维码
	function generateQRCode()
	{
		signCert = document.getElementById("cerInfo").value;
		if(signCert == "")
		{
			alert("请先导出证书");
			return;	
		}
		
		var ukeySN =  token.SOF_GetDeviceInfo(token.SGD_DEVICE_SERIAL_NUMBER);
		var certSN = token.SOF_GetCertInfo(signCert, token.SGD_CERT_SERIAL);
		var certTimeEnd = token.SOF_GetCertInfo(signCert, token.SGD_CERT_VALID_TIME);
		var Random = token.SOF_GenerateRandom(16);
		
		var appid = "appid_1235";
		var certoid = "certoid_1122";
		var sessionid = "sid_889900";
		var tokenid = "token_6677";
		var qrcode_infors = Template_Cert(appid, certSN, ukeySN, Random, certTimeEnd, certoid, sessionid, tokenid);
		var imgData = token.SOF_GenerateQRCode(qrcode_infors);
		var srcData = "data:image/png;base64,";
		srcData += imgData;
		document.getElementById("Image_QRCode").src = srcData;	
	}
	
	var timer_ID = 0;
	var _ukeySN = "";
	function QueryUKeyResult(ukeySN)
	{
		//等待结果并登录UKey 
		var uri_query = document.getElementById("QR_QueryURL").value;
		var param_query = "?params=" + _Base64encode(_ukeySN);
		var ret = token.SOF_QueryQRResult(uri_query, param_query, "");
		if((ret == null) || (ret.length <1))
		{
			alert("服务器数据错误.  Retrived invalid data from server.");
			window.clearInterval(timer_ID);
		}
		else if(ret.length >16)
		{
			//Base64 解码
			var strB64Decode = _Base64decode(ret);
			//解析JSON
			var strJson = eval("(" + strB64Decode + ")");
			var bStatus = strJson.status;
			if(bStatus)
			{
				var strResponseKey = strJson.responseKey;
				var nRet = token.SOF_VerifyPinMS(strResponseKey);
				if(nRet == 0)
				{
					alert("成功登录UKey！Successfully logined uKey.");
				}
				else{
					alert("未登录UKey！Failed to login uKey or some errors occured. " + nRet);
				}
			}
			window.clearInterval(timer_ID);
		}
		
		else
		{
			alert("未登录UKey！Failed to login uKey or some errors occured.");
			window.clearInterval(timer_ID);
		}
	}
	
	function StartTimer_QRLoginUKey(ukeySN, interval)
	{
		_ukeySN = ukeySN;
		//定时检测
		timer_ID = window.setInterval(QueryUKeyResult, interval);
	};