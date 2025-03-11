package com.xoa.service.officesupplies;

import com.xoa.dao.officesupplies.OfficeDepositoryMapper;
import com.xoa.dao.officesupplies.OfficeTypeMapper;
import com.xoa.model.officesupplies.OfficeDepositoryWithBLOBs;
import com.xoa.model.officesupplies.OfficeType;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 创建作者:   高亚峰
 * 创建日期:   2017/10/7 18:08
 * 类介绍  :  新建办公用品类别
 * 构造参数:
 */
@Service
public class OfficeTypeService {

    @Resource
    private OfficeTypeMapper officeTypeMapper;
    @Resource
    private OfficeDepositoryMapper officeDepositoryMapper;

    public ToJson<Object> addOfficeType(OfficeType officeType) {
        ToJson<Object> json = new ToJson<Object>(1, "err");
        try {
            int i = officeTypeMapper.insertSelective(officeType);
            if (i > 0) {
                OfficeDepositoryWithBLOBs officeDepositoryWithBLOBs =new OfficeDepositoryWithBLOBs();
                OfficeDepositoryWithBLOBs officeDepositoryWithBLOBs1 = officeDepositoryMapper.selectByPrimaryKey(officeType.getTypeDepository());
                String officeTypeId = officeDepositoryWithBLOBs1.getOfficeTypeId();
                StringBuffer sb =new StringBuffer();
               if(!StringUtils.checkNull(officeTypeId)){
                   sb.append(officeTypeId+officeType.getId()+",");
               }else{
                   sb.append(officeType.getId()+",");
               }
                officeDepositoryWithBLOBs.setId(officeType.getTypeDepository());
                officeDepositoryWithBLOBs.setOfficeTypeId(sb.toString());
                int i1 = officeDepositoryMapper.updateByPrimaryKeySelective(officeDepositoryWithBLOBs);
                json.setFlag(0);
                json.setMsg("ok");
            }
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/07 10:44
     * 类介绍  :   编辑办公用品类别接口
     * 构造参数:
     */
    public ToJson<Object> editOfficeType(OfficeType OfficeType) {
        ToJson<Object> json = new ToJson<Object>(1, "err");
        try {
            int i = officeTypeMapper.updateByPrimaryKeySelective(OfficeType);
            if (i > 0) {
                json.setMsg("ok");
                json.setFlag(0);
            }
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            json.setFlag(1);
            e.printStackTrace();
        }
        return json;
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/07 12:44
     * 类介绍  :   删除办公用品接口
     * 构造参数:
     */
    public ToJson<Object> deleteOfficeTypeById(Integer id) {
        ToJson<Object> json = new ToJson<Object>(1, "err");
        try {
            OfficeType officeType = officeTypeMapper.selectByPrimaryKey(id);
            Integer typeDepository = officeType.getTypeDepository();
            OfficeDepositoryWithBLOBs officeDepositoryWithBLOBs1 = officeDepositoryMapper.selectByPrimaryKey(typeDepository);
            String officeTypeId = officeDepositoryWithBLOBs1.getOfficeTypeId();
            if(!StringUtils.checkNull(officeTypeId)){
             if(officeTypeId.startsWith(String.valueOf(typeDepository) + ",")){
                 OfficeDepositoryWithBLOBs officeDepositoryWithBLOBs =new OfficeDepositoryWithBLOBs();
                 officeDepositoryWithBLOBs.setId(typeDepository);
                 officeTypeId.replace(String.valueOf(typeDepository) + ",","");
                 officeDepositoryWithBLOBs.setOfficeTypeId(officeTypeId);
                 int i1 = officeDepositoryMapper.updateByPrimaryKeySelective(officeDepositoryWithBLOBs);
             }
             if(officeTypeId.contains(","+String.valueOf(typeDepository)+",")){
                 OfficeDepositoryWithBLOBs officeDepositoryWithBLOBs =new OfficeDepositoryWithBLOBs();
                 officeDepositoryWithBLOBs.setId(typeDepository);
                 officeTypeId.replace(","+String.valueOf(typeDepository) + ",",",");
                 officeDepositoryWithBLOBs.setOfficeTypeId(officeTypeId);
                 int i1 = officeDepositoryMapper.updateByPrimaryKeySelective(officeDepositoryWithBLOBs);
             }

            }
            int i = officeTypeMapper.deleteByPrimaryKey(id);
            if (i > 0) {
                json.setFlag(0);
                json.setMsg("ok");
            }
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;
    }

    public String getTypeNameByTypeIds(String typeIds) {
        StringBuffer str = new StringBuffer();
        String[] strArr = typeIds.split(",");
        for (int i = 0; i < strArr.length; i++) {
            OfficeType type = officeTypeMapper.selectByPrimaryKey(Integer.valueOf(strArr[i]));
            if (type != null) {
                if (!StringUtils.checkNull(type.getTypeName())) {
                    if (i < strArr.length - 1) {
                        str.append(type.getTypeName() + ",");
                    } else {
                        str.append(type.getTypeName());
                    }
                }
            }
        }
        return str.toString();
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/11 10:44
     * 类介绍  :   办公用品分类列表展示接口
     * 构造参数:
     */
    public ToJson<OfficeType> selectAllOffType(HttpServletRequest request,String typeDepository) {
        ToJson<OfficeType> json =new ToJson<OfficeType>();
        try {
            List<OfficeType> officeTypes = officeTypeMapper.selectDownObject(typeDepository);
            for(OfficeType officeType:officeTypes){
                Integer typeDepository1 = officeType.getTypeDepository();
                if(typeDepository1!=null){
                    OfficeDepositoryWithBLOBs officeDepositoryWithBLOBs = officeDepositoryMapper.selectByPrimaryKey(typeDepository1);
                   if(officeDepositoryWithBLOBs!=null){
                       officeType.setTypeDepositoryName(officeDepositoryWithBLOBs.getDepositoryName());
                   }
                }

            }
            json.setObj(officeTypes);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
            e.printStackTrace();
        }
        return json;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/11 10:44
     * 类介绍  :   办公用品分类详情接口
     * 构造参数:
     */
    public ToJson<OfficeType> getOfficeTypeById(Integer id){
        ToJson<OfficeType> json = new ToJson<OfficeType>(1, "err");
        try {
            OfficeType officeType = officeTypeMapper.selectByPrimaryKey(id);
            Integer typeDepository1 = officeType.getTypeDepository();
            if(typeDepository1!=null){
                OfficeDepositoryWithBLOBs officeDepositoryWithBLOBs = officeDepositoryMapper.selectByPrimaryKey(typeDepository1);
                if(officeDepositoryWithBLOBs!=null){
                    officeType.setTypeDepositoryName(officeDepositoryWithBLOBs.getDepositoryName());
                }
            }
            json.setMsg("ok");
            json.setFlag(0);
            json.setObject(officeType);
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017/10/11 10:44
     * 类介绍  :   根据officeProType查询办公用品类别，进而查询办公用品库
     * 构造参数:
     */
    public ToJson<OfficeType> getDepositoryByProType(String officeProType){
        ToJson<OfficeType> json =new ToJson<OfficeType>(1,"err");
        try {
            OfficeType officeType = officeTypeMapper.selectOffTypeByProType(officeProType);
            json.setFlag(0);
            json.setObject(officeType);
            json.setMsg("ok");
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;
    }
}
