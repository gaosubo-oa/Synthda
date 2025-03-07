package com.xoa.util;

import java.lang.reflect.Field;
import java.text.NumberFormat;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Function;
import java.util.function.Predicate;

public class ListUtil {
    //list根据对象中的某个属性去重
    //使用案例：list = list.stream().filter(distinctByKey(Department::getDeptId)).collect(Collectors.toList());
    public static <T> Predicate<T> distinctByKey(Function<? super T, Object> keyExtractor) {
        Map<Object, Boolean> seen = new ConcurrentHashMap<>();
        return t -> seen.putIfAbsent(keyExtractor.apply(t), Boolean.TRUE) == null;
    }


    public static List startPage(List list, Integer pageNum,
                                 Integer pageSize) {
        if (list == null) {
            return null;
        }
        if (list.size() == 0) {
            return null;
        }

        Integer count = list.size(); // 记录总数
        Integer pageCount = 0; // 页数
        if (count % pageSize == 0) {
            pageCount = count / pageSize;
        } else {
            pageCount = count / pageSize + 1;
        }

        int fromIndex = 0; // 开始索引
        int toIndex = 0; // 结束索引

        if (pageNum != pageCount) {
            fromIndex = (pageNum - 1) * pageSize;
            toIndex = fromIndex + pageSize;
        } else {
            fromIndex = (pageNum - 1) * pageSize;
            toIndex = count;
        }

        List pageList = list.subList(fromIndex, toIndex);

        return pageList;
    }


    /**
     * 给list的每个属性都指定是升序还是降序
     *
     * @param list
     * @param sortnameArr  参数数组
     * @param typeArr      每个属性对应的升降序数组， true升序，false降序
     */

    public static <E> void sort(List<E> list, final String[] sortnameArr, final boolean[] typeArr) {
        if (sortnameArr.length != typeArr.length) {
            throw new RuntimeException("属性数组元素个数和升降序数组元素个数不相等");
        }
        Collections.sort(list, new Comparator<E>() {
            @Override
            public int compare(E a, E b) {
                int ret = 0;
                try {
                    for (int i = 0; i < sortnameArr.length; i++) {
                        ret = ListUtil.compareObject(sortnameArr[i], typeArr[i], a, b);
                        if (0 != ret) {
                            break;
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return ret;
            }
        });
    }


    /**
     * 对2个对象按照指定属性名称进行排序
     *
     * @param sortname
     *            属性名称
     * @param isAsc
     *            true升序，false降序
     * @param a
     * @param b
     * @return
     * @throws Exception
     */
    private static <E> int compareObject(final String sortname, final boolean isAsc, E a, E b) throws Exception {
        int ret;
        Object value1 = ListUtil.forceGetFieldValue(a, sortname);
        Object value2 = ListUtil.forceGetFieldValue(b, sortname);
        String str1 = value1.toString();
        String str2 = value2.toString();
        if (value1 instanceof Number && value2 instanceof Number) {
            int maxlen = Math.max(str1.length(), str2.length());
            str1 = ListUtil.addZero2Str((Number) value1, maxlen);
            str2 = ListUtil.addZero2Str((Number) value2, maxlen);
        } else if (value1 instanceof Date && value2 instanceof Date) {
            long time1 = ((Date) value1).getTime();
            long time2 = ((Date) value2).getTime();
            int maxlen = Long.toString(Math.max(time1, time2)).length();
            str1 = ListUtil.addZero2Str(time1, maxlen);
            str2 = ListUtil.addZero2Str(time2, maxlen);
        }
        if (isAsc) {
            ret = str1.compareTo(str2);
        } else {
            ret = str2.compareTo(str1);
        }
        return ret;
    }


    /**
     * 获取指定对象的指定属性值（去除private,protected的限制）
     *
     * @param obj
     *            属性名称所在的对象
     * @param fieldName
     *            属性名称
     * @return
     * @throws Exception
     */
    public static Object forceGetFieldValue(Object obj, String fieldName) throws Exception {
        Field field = obj.getClass().getDeclaredField(fieldName);
        Object object = null;
        boolean accessible = field.isAccessible();
        if (!accessible) {
            // 如果是private,protected修饰的属性，需要修改为可以访问的
            field.setAccessible(true);
            object = field.get(obj);
            // 还原private,protected属性的访问性质
            field.setAccessible(accessible);
            return object;
        }
        object = field.get(obj);
        return object;
    }


    /**
     * 给数字对象按照指定长度在左侧补0.
     *
     * 使用案例: addZero2Str(11,4) 返回 "0011", addZero2Str(-18,6)返回 "-000018"
     *
     * @param numObj
     *            数字对象
     * @param length
     *            指定的长度
     * @return
     */
    public static String addZero2Str(Number numObj, int length) {
        NumberFormat nf = NumberFormat.getInstance();
        // 设置是否使用分组
        nf.setGroupingUsed(false);
        // 设置最大整数位数
        nf.setMaximumIntegerDigits(length);
        // 设置最小整数位数
        nf.setMinimumIntegerDigits(length);
        return nf.format(numObj);
    }
}
