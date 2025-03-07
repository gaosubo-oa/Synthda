package com.xoa.util.common;

import com.xoa.dao.users.UsersMapper;
import com.xoa.model.users.Users;
import com.xoa.util.FileUploadUtil;
import com.xoa.util.common.wrapper.BaseWrapper;
import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.List;

/**
 * Created by pfl on 2018-2-4.
 */
@Component
public class ImgUpUtils {

    @Autowired
    UsersMapper usersMapper;

    public BaseWrapper updateUserImgaes(HttpServletRequest request){
         BaseWrapper wrapper  =new BaseWrapper();
        String realPath = request.getSession().getServletContext().getRealPath("/");
        String resourcePath = "ui/img/user";

        List<Users> users =usersMapper.getAlluser(new HashedMap());
        //上传图片并进行修改数据库数据
        File dir = new File(realPath + resourcePath);
        if(dir.exists()){
            File[] files = dir.listFiles();
            for (File file2 : files) {
                if (file2.isDirectory()) {
                } else {
                    //过滤末尾带s的压缩图片
                   if(!tailWiths(file2.getName())){
                       for (Users user:users){
                           if(file2.getName().equals(user.getAvatar())){
                               String fileName128 = FileUploadUtil.rename(file2.getName(),"s");
                               String newImg = FileUploadUtil.zipImageFile(file2.getAbsolutePath(), 128, 128, 1, fileName128,dir.getAbsolutePath());
                               user.setAvatar(fileName128);
                               user.setAvatar128(newImg);
                               int count = usersMapper.editUser(user);
                           }
                       }
                   }
                }
            }
        }
        return wrapper;
    }

    private boolean tailWiths(String name) {
       return name.contains("s.");
    }


}
