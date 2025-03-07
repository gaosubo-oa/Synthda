
//枚举证书容器
function EnumContainers()
{
	var containerLists = "";
	var i = 0;
	for(i=0;i<8;i++)
	{
		var containerName = token.SOF_EnumCertContiner(i);
		if(containerName.length >0)
		{
			containerLists += "Container " + i + ": " + containerName + "\r\n";
		}
	}
	document.getElementById("txt_ContainerLists").value = containerLists;
}

//查找证书容器
function FindContainerName()
{
	var certSN = document.getElementById("txt_CertSN").value;
	var containerName = "";
	containerName = token.SOF_FindContainer(certSN);
	document.getElementById("txt_FindContainer").value = containerName;
}

//删除证书
function DeleteCertificate()
{
	var certSN = document.getElementById("txt_CertSN").value;
	var retVal = 0;
	retVal = token.SOF_DeleteCert(certSN); //0:OK
	alert(retVal);
}
//删除容器
function DeleteContainerName()
{
	var certSN = document.getElementById("txt_CertSN").value;
	var retVal = 0;
	retVal = token.SOF_DeleteContainer(certSN); //0:OK
	alert(retVal);
}

//SM2签名
function SignSM2()
{
	var certSN = document.getElementById("txt_CertSN").value;
	var plain = document.getElementById("txt_SignPlain").value;
	var signature = "";
	document.getElementById("txt_Signature").value = "";
	
	signature = token.SOF_SignByCert(certSN, plain);
	
	document.getElementById("txt_Signature").value = signature;
}

//SM2验证签名
function VerifySM2()
{
	var certSN = document.getElementById("txt_CertSN").value;
	var plain = document.getElementById("txt_SignPlain").value;
	var signature = document.getElementById("txt_Signature").value;
	var retVal = 0;
	retVal = token.SOF_VerifyByCert(certSN, plain, signature); //0:OK
	alert(retVal);
}

//SM2通过证书来验证签名
function VerifyByExtCert()
{
	var cert = document.getElementById("txt_ExtCert").value;
	var plain = document.getElementById("txt_SignPlain").value;
	var signature = document.getElementById("txt_Signature").value;
	var retVal = 0;
	retVal = token.SOF_VerifyByExtCert(cert, plain, signature); //0:OK
	alert(retVal);
}


//生成P10请求
function P10_GenRequest()
{
	var dn = document.getElementById("txt_P10DN").value;
	var selectID = document.getElementById("txt_asymAlg");
	var index = selectID.selectedIndex;
	if(index < 0)
	{
		alert("请选中列表中的算法再操作");
		return;
	}
	var asymAlg = selectID.options[index].text;
	
	var selectID_keyLength = document.getElementById("P10_KeyLength");
	index = selectID_keyLength.selectedIndex;
	if(index < 0)
	{
		alert("请选中列表中的算法再操作");
		return;
	}
	var asym_key_length = selectID_keyLength.options[index].text;
	
	var container = document.getElementById("sele_contentList");
		if(container.selectedIndex < 0)
		{
			alert("请先枚举容器后操作");
			return;
		}
		
		var containerName = container.options[container.selectedIndex].text;
	var keyLength = parseInt(asym_key_length);
	if(asymAlg == "SM2")
	{
		keyLength = 256;
	}
	
	var p10Req = "";
	var keySpec = 1; //sign
	p10Req = token.SOF_GenerateP10Request(containerName, dn, asymAlg, keySpec, keyLength);
	document.getElementById("P10_requestData").value = p10Req;
}

//导入签名证书
function importSignCert()
{
	var container = document.getElementById("sele_contentList");
	if(container.selectedIndex < 0)
	{
		alert("请先枚举容器后操作");
		return;
	}
	
	var containerName = container.options[container.selectedIndex].text;
	if(containerName == null || containerName == "")
	{
		alert("请选择容器操作");
		return;
	}
	var cert = document.getElementById("txt_SignCertData").value;
	
	if(cert.length <256)
	{
		alert("无效的签名证书数据。");
		return;
	}
	var retVal = 0;
	retVal = token.SOF_ImportCert(containerName, cert, 1); //0:OK
	alert(retVal);
}

//导入加密证书
function importEncryptCert()
{
	var container=document.getElementById("txt_ContainerName").value;
	if(container == "")
	{
		alert("容器名称不能为空");
		return;
	}
	
	var asymAlg = "SM1";
	var nAsymAlg = 0x00020100; //SGD_SM2_1
	if(asymAlg == "RSA")
	{
		nAsymAlg = 0x00010000;//SGD_RSA
	}
	
	var symAlg = "RC4";
	var EncryptedSessionKeyData = document.getElementById("txt_EncryptedSessionKeyData").value;
	var EncryptedPrivateKeyData = document.getElementById("txt_EncryptedPrivateKeyData").value;
	var cert = document.getElementById("txt_EncryptCertData").value;
	
	var retVal = 0;
	retVal = token.SOF_ImportCryptoCertAndKey(container, cert, nAsymAlg, EncryptedSessionKeyData, symAlg, EncryptedPrivateKeyData); //0:OK
	alert(retVal);
}

//导入加密证书,此方法根据实际情况而定，多为定制接口
function importEncryptCertEx()
{
	
	var container = document.getElementById("sele_contentList");
	if(container.selectedIndex < 0)
	{
		alert("请先枚举容器后操作");
		return;
	}
	
	var containerName = container.options[container.selectedIndex].text;
	if(containerName == null || containerName == "")
	{
		alert("请选择容器操作");
		return;
	}
	
	var selectID = document.getElementById("txt_asymAlg");
	var nAsymAlgTx = selectID.options[selectID.selectedIndex].text;
	var symAlg = "SM1";  //SM1
	var nAsymAlg = token.SGD_SM2_1;
	if(nAsymAlgTx == "SGD_RSA") //SGD_SM2_1
	{
		symAlg = token.SGD_AES128_CBC; //此值使用mToken.js中的定义
		nAsymAlg = token.SGD_RSA ; //此值使用mToken.js中的定义 0x00010000
	}
	
	var CryptCertData = document.getElementById("txt_CryptCertData").value;
	var EncryptedPrivateKeyData = document.getElementById("txt_EncryptedPrivateKeyData").value;
	
	 

	var retVal = token.SOF_ImportCryptoCertAndKey(containerName, CryptCertData, nAsymAlg, "", symAlg, EncryptedPrivateKeyData, ""); 
	if(retVal!=0){
		alert("导入失败！错误码："+token.SOF_GetLastError());
		return;
	}
	alert("导入成功")
}

function changeSoPin()
{
	var strOldSoPin = document.getElementById("txt_OldSoPin").value;
	var strNewSoPin = document.getElementById("txt_NewSoPin").value;
	var retVal = token.SOF_ChangeSoPin(strOldSoPin, strNewSoPin);
	if(retVal != 0){
		alert("修改管理员失败！错误码："+token.SOF_GetLastError());
		return;
	}
}
//枚举容器，多个容器使用 "||" 分开 
function EnumCertContiner()
{
	var container = token.SOF_EnumCertContiner();
	if(container == "" || container == null)
	{
		alert("枚举容器失败"+token.SOF_GetLastError());
		return;
	}
	document.getElementById("txt_ContainerName").value = container.split("||")[0];
}

function exportPubKeyEx()
{
	document.getElementById("PubKey").value = "";	
		
	var container = document.getElementById("sele_contentList");
	if(container.selectedIndex < 0)
	{
		alert("请选择容器操作");
		return;
	}
		
	var selectType = document.getElementById("sele_cerType");
	var containerName = container.options[container.selectedIndex].text;
	if(containerName == null || containerName == "")
	{
		alert("请选择容器操作");
		return;
	}

	var exportType = 2; //DER
	var sign = 1;
	var strPubKey = token.SOF_ExportPubKey(containerName, sign, exportType);
	if(strPubKey != null && strPubKey != "")
	{
		document.getElementById("PubKey").value = strPubKey;	
	}
	else
		alert("获取公钥失败,错误码:" + token.SOF_GetLastError());
}
