package com.xoa.service.wechat.weChat.impl;

import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.dao.wechat.WeChatCommentMapper;
import com.xoa.dao.wechat.WeChatCommentReplyMapper;
import com.xoa.dao.wechat.WeChatMapper;
import com.xoa.model.enclosure.Attachment;
import com.xoa.model.users.Users;
import com.xoa.model.wechat.LikeUser;
import com.xoa.model.wechat.WeChat;
import com.xoa.model.wechat.WeChatComment;
import com.xoa.model.wechat.WeChatCommentReply;
import com.xoa.service.wechat.weChat.WeChatService;
import com.xoa.util.GetAttachmentListUtil;
import com.xoa.util.ToJson;
import com.xoa.util.page.PageParams;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by gsb on 2017/10/12.
 */
@Service
public class WeChatServiceImpl implements WeChatService {
    @Resource
    private WeChatMapper weChatMapper;
    @Resource
    private UsersMapper usersMapper;
    @Resource
    private WeChatCommentMapper weChatCommentMapper;

    @Resource
    private WeChatCommentReplyMapper weChatCommentReplyMapper;

    @Resource
    private DepartmentMapper departmentMapper;
//转化
    public static String emojiConvert1(String str)
            throws UnsupportedEncodingException {

        String patternString = "([\\x{10000}-\\x{10ffff}\ud800-\udfff])";

        Pattern pattern = Pattern.compile(patternString);

        Matcher matcher = pattern.matcher(str);

        StringBuffer sb = new StringBuffer();
        while(matcher.find()) {
            try {
                matcher.appendReplacement(
                        sb,
                        "[["
                                + URLEncoder.encode(matcher.group(1),
                                "UTF-8") + "]]");
            } catch(UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        matcher.appendTail(sb);
//        LOG.debug("emojiConvert " + str + " to " + sb.toString()
//                + ", len：" + sb.length());
        return sb.toString();
    }
//还原
    public static String emojiRecovery2(String str)
            throws UnsupportedEncodingException {
        String patternString = "\\[\\[(.*?)\\]\\]";

        Pattern pattern = Pattern.compile(patternString);
        Matcher matcher = pattern.matcher(str);

        StringBuffer sb = new StringBuffer();
        while(matcher.find()) {
            try {
                matcher.appendReplacement(sb,
                        URLDecoder.decode(matcher.group(1), "UTF-8"));

            } catch(UnsupportedEncodingException e) {
               e.printStackTrace();
            }
        }
        matcher.appendTail(sb);
//        LOG.debug("emojiRecovery " + str + " to " + sb.toString());
        return sb.toString();
    }
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-13 上午9:46:17
     * 方法介绍：添加一条微讯信息
     * 参数说明：
     */
    public ToJson<WeChat> insertWeChat(WeChat weChat,  Users user){
        ToJson<WeChat> json = new ToJson<WeChat>();
        try {
            int uid = user.getUid();
            String currentTime = String.valueOf(new Date().getTime()/1000);
            int time =Integer.valueOf(currentTime);
            weChat.setUid(uid);
            weChat.setsTime(time);
            String message = emojiConvert1(weChat.getMessage());
            weChat.setMessage(message);
            weChatMapper.insertWeChat(weChat);
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }
    /**
     * 创建作者:   季佳伟
     * 创建日期:   2017年10月13日 上午09:48:12
     * 方法介绍:   查询所有微讯  并分页
     * 参数说明:   @param maps 集合
     * 参数说明:   @param page 当前页面
     * 参数说明:   @param pageSize  页面大小
     * 参数说明:   @param useFlag  是否开启分页
     * 参数说明:   @return
     */
    public ToJson<WeChat> selectWeChat(Map<String,Object> maps, Integer page,
                                       Integer pageSize, boolean useFlag,String sqlType,Users users){
        ToJson<WeChat> json = new ToJson<WeChat>();
        PageParams pageParams = new PageParams();
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        pageParams.setUseFlag(useFlag);
        maps.put("page", pageParams);
        try {
            List<WeChat>  weChatList = weChatMapper.selectWeChat(maps);
            for (WeChat weChat:weChatList){
                if (weChat.getFileName() != null && weChat.getFileId() != null) {
                    weChat.setAttachment(GetAttachmentListUtil.returnAttachment(weChat.getFileName(), weChat.getFileId(), sqlType, GetAttachmentListUtil.WE_CHAT));
                } else {
                    weChat.setFileName("");
                    weChat.setFileId("");
                    List<Attachment> attachmentList = new List<Attachment>() {
                        @Override
                        public int size() {
                            return 0;
                        }

                        @Override
                        public boolean isEmpty() {
                            return false;
                        }

                        @Override
                        public boolean contains(Object o) {
                            return false;
                        }

                        @Override
                        public Iterator<Attachment> iterator() {
                            return null;
                        }

                        @Override
                        public Object[] toArray() {
                            return new Object[0];
                        }

                        @Override
                        public <T> T[] toArray(T[] a) {
                            return null;
                        }

                        @Override
                        public boolean add(Attachment attachment) {
                            return false;
                        }

                        @Override
                        public boolean remove(Object o) {
                            return false;
                        }

                        @Override
                        public boolean containsAll(Collection<?> c) {
                            return false;
                        }

                        @Override
                        public boolean addAll(Collection<? extends Attachment> c) {
                            return false;
                        }

                        @Override
                        public boolean addAll(int index, Collection<? extends Attachment> c) {
                            return false;
                        }

                        @Override
                        public boolean removeAll(Collection<?> c) {
                            return false;
                        }

                        @Override
                        public boolean retainAll(Collection<?> c) {
                            return false;
                        }

                        @Override
                        public void clear() {

                        }

                        @Override
                        public Attachment get(int index) {
                            return null;
                        }

                        @Override
                        public Attachment set(int index, Attachment element) {
                            return null;
                        }

                        @Override
                        public void add(int index, Attachment element) {

                        }

                        @Override
                        public Attachment remove(int index) {
                            return null;
                        }

                        @Override
                        public int indexOf(Object o) {
                            return 0;
                        }

                        @Override
                        public int lastIndexOf(Object o) {
                            return 0;
                        }

                        @Override
                        public ListIterator<Attachment> listIterator() {
                            return null;
                        }

                        @Override
                        public ListIterator<Attachment> listIterator(int index) {
                            return null;
                        }

                        @Override
                        public List<Attachment> subList(int fromIndex, int toIndex) {
                            return null;
                        }
                    };
                    weChat.setAttachment(attachmentList);
                }
                String uid = users.getUid()+"";
                if(users.getUid() == weChat.getUid()){
                         weChat.setIsSend(0);
                }else{
                    weChat.setIsSend(1);
                }
                String likeIds =weChat.getLikeIds();
                int result = likeIds.indexOf(",");
                if(likeIds != "" && result != -1){
                    String[] likeIdsArray = likeIds.split(",");
                    int a = 0;
                    for(int i = 0;i<likeIdsArray.length;i++){
                        if(likeIdsArray[i].equals(uid)){
                            a = a + 1;
                        }else{
                            weChat.setIsLike(0);
                        }
                    }
                    if(a == 1){
                        weChat.setIsLike(1);
                    }
                    weChat.setLikeNum(likeIdsArray.length);
                }else if (likeIds != ""){

                    if(likeIds.equals(uid)){
                        weChat.setIsLike(1);
                    }else {
                        weChat.setIsLike(0);
                    }
                    weChat.setLikeNum(1);
                }else {
                    weChat.setIsLike(0);
                    weChat.setLikeNum(0);
                }
                int sTime = weChat.getsTime();
                SimpleDateFormat sformat =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                long lTime = new Long(sTime*1000L);
                Date date = new Date(lTime);
                String newTime = sformat.format(date);
                weChat.setTime(newTime);
                Users user = new Users();
                user = usersMapper.selectUserByUId(weChat.getUid());
                if(user != null){
                    weChat.setUserName(user.getUserName());
                    weChat.setUserAvatar(user.getAvatar());
                    weChat.setUserSex(Integer.parseInt(user.getSex()));
                    weChat.setUserPrivName(user.getUserPrivName());
                    String deptName = departmentMapper.getDeptNameByDeptId(user.getDeptId());
                    weChat.setDeptName(deptName);
                }else {
                    weChat.setUserName("");
                    weChat.setUserAvatar("");
                }

                List<WeChatComment> weChatComment = weChatCommentMapper.selectWeChatCommentByWID(weChat.getWid());
                if(weChatComment!=null) {
                    weChat.setCommentNum(weChatComment.size());
                }else {
                    weChat.setCommentNum(0);
                }
                String message = emojiRecovery2(weChat.getMessage());
                weChat.setMessage(message);

            }
            json.setTotleNum(pageParams.getTotal());
            json.setObj(weChatList);
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-13 上午11:46:17
     * 方法介绍：根据主键修改微讯
     * 参数说明：
     */
    public ToJson<WeChat> updateWeChatByPrimaryKey(Integer wid,Users user){
        ToJson<WeChat> json = new ToJson<WeChat>();
        try {
            int uid = user.getUid();
            WeChat newWeChat = weChatMapper.selectWeChatByPrimaryKey(wid);
            String oldUIds = newWeChat.getLikeIds();
            String newUIds = "";
            if(oldUIds==null || oldUIds ==""){
                newUIds = uid + "";
            }else {
                boolean status = oldUIds.contains(",");
                if(status){
                    String sUId1 =uid + "";
                    String[] uidArray =oldUIds.split(",");
                    int a = 0 ;
                    for (int i = 0;i<uidArray.length;i++){
                        if (sUId1.equals(uidArray[i])){
                            String sUId = "";
                            if(i == 0){
                                sUId = uid+",";
                            }else {
                                sUId = "," +uid;
                            }
                            newUIds = oldUIds.replace(sUId ,"");
                        }else {
                           a = a + 1;
                        }

                    }
                    if(a == uidArray.length){
                        newUIds = oldUIds + "," + uid;
                    }

                }else{
                    String sUId =uid + "";
                    if(sUId.equals(oldUIds)){
                        newUIds = "";
                    }else {
                        newUIds = oldUIds + "," + uid;
                    }
                }


            }

            newWeChat.setLikeIds(newUIds);
            weChatMapper.updateWeChatByPrimaryKey(newWeChat);
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-18 上午10:46:17
     * 方法介绍：根据主键查询微讯
     * 参数说明：
     */
    public ToJson<WeChat> selectWeChatByPrimaryKey(Integer wid,String sqlType){
        ToJson<WeChat> json = new ToJson<WeChat>();
        try{

            WeChat weChat = weChatMapper.selectWeChatByPrimaryKey(wid);
            if (weChat.getFileName() != null && weChat.getFileId() != null) {
                weChat.setAttachment(GetAttachmentListUtil.returnAttachment(weChat.getFileName(), weChat.getFileId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL));
            } else {
                weChat.setFileName("");
                weChat.setFileId("");
                List<Attachment> attachmentList = new List<Attachment>() {
                    @Override
                    public int size() {
                        return 0;
                    }

                    @Override
                    public boolean isEmpty() {
                        return false;
                    }

                    @Override
                    public boolean contains(Object o) {
                        return false;
                    }

                    @Override
                    public Iterator<Attachment> iterator() {
                        return null;
                    }

                    @Override
                    public Object[] toArray() {
                        return new Object[0];
                    }

                    @Override
                    public <T> T[] toArray(T[] a) {
                        return null;
                    }

                    @Override
                    public boolean add(Attachment attachment) {
                        return false;
                    }

                    @Override
                    public boolean remove(Object o) {
                        return false;
                    }

                    @Override
                    public boolean containsAll(Collection<?> c) {
                        return false;
                    }

                    @Override
                    public boolean addAll(Collection<? extends Attachment> c) {
                        return false;
                    }

                    @Override
                    public boolean addAll(int index, Collection<? extends Attachment> c) {
                        return false;
                    }

                    @Override
                    public boolean removeAll(Collection<?> c) {
                        return false;
                    }

                    @Override
                    public boolean retainAll(Collection<?> c) {
                        return false;
                    }

                    @Override
                    public void clear() {

                    }

                    @Override
                    public Attachment get(int index) {
                        return null;
                    }

                    @Override
                    public Attachment set(int index, Attachment element) {
                        return null;
                    }

                    @Override
                    public void add(int index, Attachment element) {

                    }

                    @Override
                    public Attachment remove(int index) {
                        return null;
                    }

                    @Override
                    public int indexOf(Object o) {
                        return 0;
                    }

                    @Override
                    public int lastIndexOf(Object o) {
                        return 0;
                    }

                    @Override
                    public ListIterator<Attachment> listIterator() {
                        return null;
                    }

                    @Override
                    public ListIterator<Attachment> listIterator(int index) {
                        return null;
                    }

                    @Override
                    public List<Attachment> subList(int fromIndex, int toIndex) {
                        return null;
                    }
                };
                weChat.setAttachment(attachmentList);
            }
            json.setObject(weChat);
            json.setFlag(0);
            json.setMsg("ok");

        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

    public ToJson<WeChat> deleteByPrimaryKey(Integer wid){
        ToJson<WeChat> json = new ToJson<WeChat>();
        try {
            weChatMapper.deleteByPrimaryKey(wid);
            List<WeChatComment> weChatCommentList = weChatCommentMapper.selectWeChatCommentByWID(wid);
            if (weChatCommentList.size() != 0){
                weChatCommentMapper.deleteWeChatCommentByWID(wid);
                List<WeChatCommentReply> weChatCommentReplyList = weChatCommentReplyMapper.selectWeChatCommentReplyByWID(wid);
                if (weChatCommentReplyList.size() != 0){
                    weChatCommentReplyMapper.deleteWeChatCommentReplyByWID(wid);
                }
            }
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

    public ToJson<LikeUser> getLikeUser(Integer wid){
        ToJson<LikeUser> json = new ToJson<LikeUser>();
        try {
            List<LikeUser> likeUserList = new  ArrayList<LikeUser>() ;
            WeChat weChat = weChatMapper.selectWeChatByPrimaryKey(wid);
            String likeIds =weChat.getLikeIds();

            int result = likeIds.indexOf(",");
            if(likeIds != null && result != -1){
                String[] likeIdsArray = likeIds.split(",");
               for (int i = 0 ;i<likeIdsArray.length;i++){
                   Users user = usersMapper.getUserByUid(Integer.parseInt(likeIdsArray[i]));
                   LikeUser likeUser = new LikeUser();
                   likeUser.setLikeUId(Integer.parseInt(likeIdsArray[i]));
                   likeUser.setLikeUserName(user.getUserName());
                   likeUser.setLikeUserrAvatar(user.getAvatar());
                   likeUserList.add(likeUser);
               }
            }else if (likeIds != ""&&result == -1){
                Users user = usersMapper.getUserByUid(Integer.parseInt(likeIds));
                LikeUser likeUser = new LikeUser();
                likeUser.setLikeUId(Integer.parseInt(likeIds));
                likeUser.setLikeUserName(user.getUserName());
                likeUser.setLikeUserrAvatar(user.getAvatar());
                likeUserList.add(likeUser);
            }else {

            }
            json.setObj(likeUserList);
            json.setFlag(0);
            json.setMsg("ok");

        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }


}
